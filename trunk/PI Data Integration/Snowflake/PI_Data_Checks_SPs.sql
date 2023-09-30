  create or replace TABLE PI_DATA_CHECK_LOG (
	TS NUMBER(38,0),
    MSG VARCHAR(16777216)
);

CREATE or replace PROCEDURE checkDups(tableName VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'PI_DATA_CHECK_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}     
    
    var dupCount = 0;
    var projectid = "";
    var sqlCommand = "with dups as (select projectid, programid, raw, count(*) as dup_count from raw."+ TABLENAME + " group by 1,2,3) select projectid, count(*) from dups where dup_count > 1 group by 1;";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            while (result1.next()){
               dupCount = result1.getColumnValue(2);
               projectid = result1.getColumnValue(1) 
               if (dupCount > 1){
                  log("WARNING for project "+projectid+": "+ dupCount + " records have duplicates in table "+TABLENAME)
               }
            }
         }
    catch (err)  {
        log("WARNING for " + TABLENAME + ": "+ err);
        return "1"
        }
//log("Checked table for dups: "+TABLENAME);
  return "0";
  $$;


CREATE or replace PROCEDURE checkAllTablesForDups()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'PI_DATA_CHECK_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}   

log("Beginning");

  //get list of active tables
    var table_array=[];
    var sqlCommand = "select ta.table_name from public.d_pi_tables ta where ta.s3_sourced = true and ta.active = true order by ta.table_name; "; 
    
    var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var table_name = rs.getColumnValue(1);
     table_array.push(table_name);
    }
  
  //check tables in list
  var rowCount=0;
  var stmt="";
  for (const table_name of table_array) {

        sqlCommand = "call checkDups('"+ table_name + "');";
        snowflake.execute ({sqlText: sqlCommand});
  }   

log("Finished checking tables for duplicates.");
return "Finished checking tables for duplicates.";
$$;


GRANT usage ON procedure PUREINSIGHTS_DEV.RAW.checkAllTablesForDups() TO ROLE PI_Data_Ingest_DEV_Alert_User; 
GRANT usage ON procedure PUREINSIGHTS_DEV.RAW.checkDups(varchar) TO ROLE PI_Data_Ingest_DEV_Alert_User; 
grant usage on procedure do_log(varchar) TO ROLE PI_Data_Ingest_DEV_Alert_User;
grant all on table raw.pi_data_check_log to ROLE PI_Data_Ingest_DEV_Alert_User;


CREATE or replace PROCEDURE checkUnavailableTables(projectid VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'PI_DATA_CHECK_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}  

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}


log("Beginning");
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
    var stageName = "PI_DATA_CHECK_STAGE_" + PROJECTID;
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
        log("Failed to get project info from project table for project "+ PROJECTID + ": " + err);
        return "failed to get project info";
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
        return "failed to create stage"; 
}
  
    
    
    
    sqlCommand = "list @"+ stageName + " pattern='.*/_SUCCESS';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("ERROR listing _SUCCESS files for project " + PROJECTID + ": "+ err); 
        return "failed to list _SUCCESS files";
        }

    var table_list = "";
    sqlCommand = "select table_name from d_pi_tables ta where ta.active = true and ta.s3_sourced = true and not exists (select \"name\" FROM table(result_scan(last_query_id())) where contains(\"name\",ta.table_name));";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            while (result1.next()){
                table_list += ", "+ result1.getColumnValue(1);
            }
            
         }
    catch (err)  {
        log("ERROR listing missing tables for project "+PROJECTID +": "+ err);
        return "failed to list missing tables";
        }    
    
  //if (table_list !=""){
   log("INFO: S3 _SUCCESS file does not exist for the following tables for project "+PROJECTID+": "+table_list);
  
  //}
  
      //drop stage
    sqlCommand = "call dropPIStage('" + stageName + "');";
      try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to drop stage" + stageName +": "+ err); 
        return "failed to drop stage"; 
}
  
  return "No S3 _SUCCESS file for the following tables for project " + PROJECTID + ": "+table_list;
  $$;

  create or replace procedure do_log(msg varchar) 
   RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
 $$
 //see if we should log - checks for do_log = true session variable
 try{
    var foo = snowflake.createStatement( { sqlText: `select $do_log` } ).execute();
 } catch (ERROR){
    return; //swallow the error, variable not set so don't log
 }
 foo.next();
 if (foo.getColumnValue(1)==true){ //if the value is anything other than true, don't log
    try{
        snowflake.createStatement( { sqlText: `create table identifier ($log_table) if not exists (ts number, msg string)`} ).execute();
        snowflake.createStatement( { sqlText: `insert into identifier ($log_table) values (:1, :2)`, binds:[Date.now(), MSG] } ).execute();
    } catch (ERROR){
        throw ERROR;
    }
 }
 $$;

