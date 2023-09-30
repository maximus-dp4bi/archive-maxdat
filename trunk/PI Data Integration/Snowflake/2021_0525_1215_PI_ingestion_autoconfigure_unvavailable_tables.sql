CREATE or replace PROCEDURE ingestUningestedPIData(ProjectId VARCHAR,reIngestFlag Boolean, ingestAllFlag Boolean,waitForS3Flag Boolean)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
 
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
} 
       

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

     //get date string for today
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     var todayDateString = yyyy + mm + dd;

REINGEST_SFX = ""
if (REINGESTFLAG){
REINGEST_SFX=" REINGEST";
}     
     
 //log start
     log(PROJECTID, "INGESTION STARTED"+REINGEST_SFX, "NA", "SUCCEEDED","Starting ingestion for PI data");
 
 
//get project fields 
    var PROJECTNAME = "";
    var AWSFOLDERNAME = "";
    var stageName = "PI_STAGE_" + PROJECTID;
    var truncateFlag = true;
    var sqlCommand = "select pr.projectname, pr.awsfoldername from public.d_pi_projects pr where pr.projectid = '"+PROJECTID+"';";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            PROJECTNAME = result1.getColumnValue(1);
            AWSFOLDERNAME = result1.getColumnValue(2);
         }
    catch (err)  {
        log(PROJECTID, "PROJECT INFO"+REINGEST_SFX, "NA", "FAILED","Failed to get project info from project table: " + err);
        return "2";
        }    
    
    //drop stage if still exists
    var blah = 0;
    sqlCommand = "call dropPIStage('" + stageName + "');";
    try { 
    snowflake.execute ({sqlText: sqlCommand}); 
    }
    catch (err){ 
      blah=1;
    }

       
    //create stage for today's data
    sqlCommand = "call createPIStage('" + AWSFOLDERNAME + "','" + stageName + "','" + todayDateString + "');";
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "STAGE"+REINGEST_SFX, stageName, "FAILED","Failed to create stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "3"; 
}
  

     
//check and wait for S3 files to be available
if (WAITFORS3FLAG){
var missingCount = 0;
var i;
for (i = 0; i <= 100; i++) {

    sqlCommand = "list @"+ stageName + " pattern='.*/_SUCCESS';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log( PROJECTID, "S3 DATA"+REINGEST_SFX, "_SUCCESS FILE", "FAILED", "Failed to list _SUCCESS files for projectid " + PROJECTID + ": "+ err); 
        return "4";
        }


    sqlCommand = "select count(table_name) from d_pi_tables ta where ta.active = true and ta.s3_sourced = true and not exists (select \"name\" FROM table(result_scan(last_query_id())) where contains(\"name\",ta.table_name)) and not exists (select 1 from d_pi_project_unavailable_tables ua where ua.table_name = ta.table_name and ua.project_id = '"+PROJECTID+"' and (ua.end_unavailable_date is null or ua.end_unavailable_date >= date(current_timestamp())));";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            missingCount = result1.getColumnValue(1); 
         }
    catch (err)  {
        log(PROJECTID, "S3 DATA"+REINGEST_SFX, "_SUCCESS FILE", "FAILED","Failed to count success files for projectid " + PROJECTID + ": "+ err);
        return "1";
        }
        
   if (missingCount == 0) {
   log(PROJECTID, "S3 DATA"+REINGEST_SFX, "_SUCCESS FILE", "SUCCEEDED","All success files now available for projectid " + PROJECTID);
       break;
   } else {
      if (i < 100){
       log(PROJECTID,"S3 DATA"+REINGEST_SFX,"_SUCCESS FILE","WAITING","Not all success files available yet.");
       missingCount = 0;
       sqlCommand = "call SYSTEM$WAIT(3,'MINUTES');";
       snowflake.execute ({sqlText: sqlCommand});
      } else {
         log(PROJECTID,"S3 DATA"+REINGEST_SFX,"_SUCCESS FILE","FAILED","All success files not available during ingestion window.Aborting ingestion.");
         return "1"
      }
   }
}  
}  
    
  
  
  //get list of tables yet to be ingested today
    var table_array=[];
    if (INGESTALLFLAG){
       sqlCommand = "select ta.table_name from public.d_pi_projects pr left outer join public.d_pi_tables ta where pr.projectid = '"+PROJECTID+"' and ta.s3_sourced = true and ta.active = true order by ta.table_name; "; 
    } else {
       sqlCommand = "select ta.table_name from public.d_pi_projects pr left outer join public.d_pi_tables ta where pr.projectid = '"+PROJECTID+"' and ta.s3_sourced = true and ta.active = true and not exists (select 1 from raw.ingest_pi_data_det_log dl where dl.projectid = pr.projectid and dl.object_category in ('TABLE','TABLE REINGEST') and dl.object_name = ta.table_name and dl.status_string = 'SUCCEEDED' and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())) order by ta.table_name; "; 
    }
    var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var table_name = rs.getColumnValue(1);
     table_array.push(table_name);
    }
  
  //ingest tables in list
  var rowCount=0;
  var stmt="";
  for (const table_name of table_array) {
     if (table_name != 'segments'){
        sqlCommand = "call ingestPIData('"+ table_name +"','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag +","+ REINGESTFLAG + ");";
     } else {
       sqlCommand = "call ingestPIDataSegments('" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag +","+ REINGESTFLAG + ");";
     }
     snowflake.execute ({sqlText: sqlCommand});
     
     
     
     //generate warning if 0 records for any table not listed in unavailable tables table
     sqlCommand = "select case when not exists (select 1 from public.d_pi_project_unavailable_tables ua where ua.project_id = '" + PROJECTID + "' and ua.table_name = '" + table_name + "' and ((ua.end_unavailable_date is null) or (ua.end_unavailable_date >= current_date()))) then count(*) else 1 end from raw." + table_name + " rw where rw.projectid = '" + PROJECTID + "';"; 
     try {
            stmt = snowflake.createStatement({sqlText: sqlCommand});
            var result1 = stmt.execute();
            result1.next();
            rowCount = result1.getColumnValue(1); 
         }
     catch (err)  {
        log(PROJECTID, "TABLE ROW COUNT"+REINGEST_SFX, table_name, "FAILED","Failed to count records after ingestion: "+ err);
        return "1";
        }
        
     if (rowCount < 1) {
       log(PROJECTID,"TABLE"+REINGEST_SFX,table_name,"WARNING","Table " + table_name + " has 0 records though it is configured as an available table for this project."); 
}
  
  }
    
  
  //generate warning if success files available for tables claimed to be unavailable in projet unavailable tables table
var extraCount = 0;

    sqlCommand = "list @"+ stageName + " pattern='.*/_SUCCESS';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log( PROJECTID, "S3 DATA"+REINGEST_SFX, "_SUCCESS FILE", "FAILED", "Failed to list _SUCCESS files for projectid " + PROJECTID + ": "+ err); 
        return "4";
        }


    sqlCommand = "select count(table_name) from d_pi_tables ta where ta.active = true and ta.s3_sourced = true and exists (select \"name\" FROM table(result_scan(last_query_id())) where contains(\"name\",ta.table_name)) and exists (select 1 from d_pi_project_unavailable_tables ua where ua.table_name = ta.table_name and ua.project_id = '"+PROJECTID+"' and (ua.end_unavailable_date is null or ua.end_unavailable_date >= date(current_timestamp())));";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            extraCount = result1.getColumnValue(1); 
         }
    catch (err)  {
        log(PROJECTID, "S3 DATA"+REINGEST_SFX, "_SUCCESS FILE", "FAILED","Failed to count success files for projectid " + PROJECTID + ": "+ err);
        return "1";
        }
        
   if (extraCount > 0) {
       log(PROJECTID,"S3 DATA"+REINGEST_SFX,"_SUCCESS FILE","WARNING","_SUCCESS FILE found for table listed as unavailable in d_pi_project_unavailable_tables. Configuration entries have been modified to match available data in S3 bucket."); 
}

  //reconfigure unavailable tables table based on availability of data
      sqlCommand = "call raw.configurePIUnavailableTablesDuringIngest('" + PROJECTID + "','" + stageName + "','" + REINGEST_SFX + "');";
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "CONFIG"+REINGEST_SFX, "unavailable tables", "FAILED","Failed to reconfigure unavailable tables for project " + PROJECTID + " for "+todayDateString+ ": "+ err); 
        return "3"; 
}

      
    //drop stage
    sqlCommand = "call dropPIStage('" + stageName + "');";
      try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "STAGE"+REINGEST_SFX, stageName, "FAILED","Failed to drop stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "5"; 
}

    log(PROJECTID, "INGESTION COMPLETED"+REINGEST_SFX, "NA", "SUCCEEDED","Succeeded ingesting PI data");
    return "0";  
  $$;
 

CREATE or replace PROCEDURE ConfigurePIUnavailableTablesDuringIngest(projectid VARCHAR,stageName VARCHAR,REINGEST_SFX VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS  
  $$
  
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
 
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
} 
  


function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

     //get date string for today
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     var todayDateString = yyyy + mm + dd;

//get project fields 
    var PROJECTNAME = "";
    var AWSFOLDERNAME = "";
    var stageName = STAGENAME;
    var truncateFlag = true;
    var sqlCommand = "select pr.projectname, pr.awsfoldername from public.d_pi_projects pr where pr.projectid = '"+PROJECTID+"';";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            PROJECTNAME = result1.getColumnValue(1);
            AWSFOLDERNAME = result1.getColumnValue(2);
         }
    catch (err)  {
        log(PROJECTID, "CONFIG"+REINGEST_SFX, "unavailable tables", "FAILED","Failed to get project info for project " + PROJECTID + " for "+todayDateString+ ": "+ err); 
        return "failed to get project info";
        }    
    
    
    sqlCommand = "list @"+ stageName + " pattern='.*/_SUCCESS';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "CONFIG"+REINGEST_SFX, "unavailable tables", "FAILED","Failed to list _SUCCESS files for project " + PROJECTID + " for "+todayDateString+ ": "+ err); 
        return "failed to list _SUCCESS files";
        }

    var table_list = "";
    var sql_inserts = new Array();
    sqlCommand = "select table_name from public.d_pi_tables ta where ta.active = true and ta.s3_sourced = true and not exists (select \"name\" FROM table(result_scan(last_query_id())) where contains(\"name\",ta.table_name));";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            var tablename = "";
            while (result1.next()){
                tablename = result1.getColumnValue(1);
                table_list += ", "+ tablename;
                sql_inserts.push("call raw.insertPIUnavailableTablesDuringIngest('" + tablename + "','" + PROJECTID + "','" + PROJECTNAME + "')");
            }
            
         }
    catch (err)  {
        log(PROJECTID, "CONFIG"+REINGEST_SFX, "unavailable tables", "FAILED","Failed to list missing tables for project " + PROJECTID + " for "+todayDateString+ ": "+ err); 
        return "failed to list missing tables";
        }    
  
  //delete existing entries from unavailable tables table
     sqlCommand = "delete from public.d_pi_project_unavailable_tables where project_id = '" + PROJECTID + "';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
         log(PROJECTID, "CONFIG"+REINGEST_SFX, "unavailable tables", "FAILED","Failed to delete from unavailable tables for project " + PROJECTID + " for "+todayDateString+ ": "+ err); 
        return "failed to delete existing entries in unavailable tables";
        }     

  
  
  //insert into unavalable tables table
  
  for (i = 0; i < sql_inserts.length; i++) {
        try {
            snowflake.execute (
                {sqlText: sql_inserts[i]}
            );
        }
    catch (err)  {
        log(PROJECTID, "CONFIG"+REINGEST_SFX, "unavailable tables", "FAILED","Failed to insert into unavailable tables for project " + PROJECTID + " for "+todayDateString+ ": "+ err);  
        return "failed to insert new entries int unavailable tables"; 
}
}
  
  return "0"
  $$;  select * from d_pi_project_unavailable_tables;
  
  drop procedure insertPIUnavailableTablesDuringIngestion(varchar,varchar,varchar);
    CREATE or replace PROCEDURE insertPIUnavailableTablesDuringIngest(tableName VARCHAR, projectid VARCHAR, projectname VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  //error handling and logging handled by calling sp

    //truncate table
    sqlCommand = "delete from public.d_pi_project_unavailable_tables where project_id = '" + PROJECTID + "' and table_name = '" + TABLENAME + "';";
    snowflake.execute ({sqlText: sqlCommand});
          

    //insert new row 
    var sqlCommand = "insert into public.d_pi_project_unavailable_tables values ('" + PROJECTID +"','" + PROJECTNAME + "','" + TABLENAME + "',null,current_timestamp());";
    snowflake.execute ({sqlText: sqlCommand});
       
  return "0";  
  $$; 
