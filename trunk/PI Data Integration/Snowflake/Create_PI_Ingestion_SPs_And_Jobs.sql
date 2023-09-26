drop procedure ingestPIDATA(varchar, varchar, varchar,varchar, boolean);

CREATE or replace PROCEDURE ingestPIData(tableName VARCHAR, stageName VARCHAR, AWSFolderName VARCHAR, projectid VARCHAR, projectname VARCHAR, truncateFlag Boolean)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  
    //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
} 
     //default stage
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_2';
     } 

//check for success file
    //list _SUCCESS file
    sqlCommand = "list @"+ stageName + " pattern='.*" + TABLENAME + "/_SUCCESS';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log( "Failed to list _SUCCESS file for " +TABLENAME+ " for projectid " + PROJECTID + ": "+ err); 
        return "Failed to list _SUCCESS file  " +TABLENAME+ ": "+ err;
        }
        
    //count results from list
    var successCount = 0;
    var sqlCommand = "SELECT count(*) FROM table(result_scan(last_query_id()));"
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            success_count = result1.getColumnValue(1); 
            if (success_count < 1) {
               throw "_SUCCESS file does not exist";
            }
         }
    catch (err)  {
        log("Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err);
        return "Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err;
        }


    //truncate table
   if (TRUNCATEFLAG) {
   //log("truncating table");
    //sqlCommand = "truncate table raw."+TABLENAME+";";
    //sqlCommand = "CALL truncateTable('" + TABLENAME + "','" + PROJECTID + "');";
   sqlCommand = "delete from raw."+TABLENAME+" where projectid = '" + PROJECTID + "';";
    //log(sqlCommand);
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log( "Failed to truncate table " +TABLENAME+ " for projectid " + PROJECTID + ": "+ err); 
        return "Failed to truncate table " +TABLENAME+ ": "+ err;
        }
   }     

    //ingest date from parquet file    
    var sqlCommand = "copy into raw." + TABLENAME + " (projectid, projectname, ingestionDateTime, raw) 
    from (select '"+ PROJECTID +"','" + PROJECTNAME + "',sysdate(), * from @" + stageName + "/" + TABLENAME + "/) PATTERN='.*.parquet' FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;";
 //log("ingesting data")
try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err);
        return "Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err;
        }        
        //log("suceeded ingesting for "+TABLENAME);
  return "Succeeded ingesting PI data for table " + TABLENAME + ".";  
  $$;    
        
drop procedure ingestPIDataSegments(VARCHAR,VARCHAR,varchar,boolean);

CREATE or replace PROCEDURE ingestPIDataSegments(stageName VARCHAR,AWSFolderName VARCHAR, projectid VARCHAR,projectname varchar, truncateFlag Boolean)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$    
    //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
} 

var TABLENAME = 'segments';

     //default stage
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_2';
     } 

//check for success file
    //list _SUCCESS file
    sqlCommand = "list @"+ stageName + " pattern='.*" + TABLENAME + "/_SUCCESS';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log( "Failed to list _SUCCESS file for " +TABLENAME+ " for projectid " + PROJECTID + ": "+ err); 
        return "Failed to list _SUCCESS file  " +TABLENAME+ ": "+ err;
        }
        
    //count results from list
    var successCount = 0;
    var sqlCommand = "SELECT count(*) FROM table(result_scan(last_query_id()));"
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            success_count = result1.getColumnValue(1); 
            if (success_count < 1) {
               throw "_SUCCESS file does not exist";
            }
         }
    catch (err)  {
        log("Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err);
        return "Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err;
        }

    //truncate table
   if (TRUNCATEFLAG) {
    //sqlCommand = "truncate table raw."+TABLENAME+";";
    //sqlCommand = "CALL truncateTable('" + TABLENAME + "','" + PROJECTID + "');";
    sqlCommand = "delete from raw."+TABLENAME+" where projectid = '" + PROJECTID + "';";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log( "Failed to truncate table " +TABLENAME+ " for projectid " + PROJECTID + ": "+ err);   // Return a success/error indicator.
        return "Failed to truncate table " +TABLENAME+ ": "+ err;
        }
    }
    //ingest date from parquet file    
    var sqlCommand = "copy into raw.segments (projectid, projectname, ingestionDateTime, raw) from (select '" + PROJECTID + "','" + PROJECTNAME + "',sysdate(), parse_json(cast('{' || 'audioMuted:\"'|| $1:audioMuted || '\",' || 'conference:\"'|| $1:conference || '\",' || 'conversationId:\"'|| $1:conversationId || '\",' || 'disconnecttype:\"'|| $1:disconnecttype || '\",' || 'participantid:\"'|| $1:participantid || '\",' || 'queueId:\"'|| $1:queueId || '\",' || 'segmentduration:\"'|| $1:segmentduration || '\",' || 'segmentEndTime:\"'|| $1:segmentEndTime || '\",' || 'segmentStartTime:\"'|| $1:segmentStartTime || '\",' || 'segmenttype:\"'|| $1:segmenttype || '\",' || 'sessionId:\"'|| $1:sessionId || '\",' || 'subject:\"'|| $1:subject || '\",' || 'wrapupCode:\"' || $1:wrapupCode || '\"}' as variant)) from @" + stageName + "/segments/) PATTERN='.*.parquet' FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;";

try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err);
        
        return "Failed to load table " + TABLENAME + " for projectid " + PROJECTID + ": "+ err;
        }
        
        
  return "Succeeded ingesting PI data for table " + TABLENAME + ".";  
  $$;    
        
drop procedure ingestAllPIData(VARCHAR, VARCHAR,VARCHAR,VARCHAR, boolean);

   CREATE or replace PROCEDURE ingestAllPIData(ProjectId VARCHAR, ProjectName VARCHAR, AWSFolderName VARCHAR, stageName VARCHAR, todayDateString VARCHAR, truncateFlag Boolean)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}     

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}
     var todayDateString = TODAYDATESTRING;

     //get date string for today if parameter is missing
     if (! TODAYDATESTRING){
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     todayDateString = yyyy + mm + dd;
     }

     //default stageName
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_2';
     } 
    
    var AWSFolderName = AWSFOLDERNAME;
    var truncateFlag = TRUNCATEFLAG;
    
    
    //alter stage for today's data
    var sqlCommand = "call alterPIStage('" + AWSFOLDERNAME + "','" + stageName + "','" + todayDateString + "');";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to alter stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "Failed to alter stage " + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err; 
}
     
    sqlCommand = "call ingestPIData('configuration_objects','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});              
        
    sqlCommand = "call ingestPIData('conversations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});                      
     
    sqlCommand = "call ingestPIData('conversations_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});        
     
     
    sqlCommand = "call ingestPIData('conversations_summary','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('conversation_attributes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
     
    sqlCommand = "call ingestPIData('divisions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});  
    
    sqlCommand = "call ingestPIData('evaluations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('evaluation_forms','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
     
    sqlCommand = "call ingestPIData('groups_membership','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});     
        
    sqlCommand = "call ingestPIData('locations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('participants','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
        
    sqlCommand = "call ingestPIData('primary_presence','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});        
    
    sqlCommand = "call ingestPIData('queues_membership','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
        
    sqlCommand = "call ingestPIData('queue_configuration','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('sessions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});   
    
    sqlCommand = "call ingestPIData('session_summary','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
    
    sqlCommand = "call ingestPIData('user_details','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    

    sqlCommand = "call ingestPIData('user_locations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});

    sqlCommand = "call ingestPIData('user_roles','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('user_skills','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    //iteration 2
    
    sqlCommand = "call ingestPIData('flow_outcomes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
 
    sqlCommand = "call ingestPIDataSegments('" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
 
    sqlCommand = "call ingestPIData('mysql_audits','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('audio_quality','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('billable_usage','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('routing_status','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_historical_actuals','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_historical_exceptions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
   
    sqlCommand = "call ingestPIData('wfm_activity_codes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_schedule','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    var sqlCommand = "call ingestPIData('dialer_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('dialer_preview_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    var return_value = 0;
    try {
      var command = "SELECT count(*) FROM conversations_detail where projectid = '" + PROJECTID + "';"
      var stmt = snowflake.createStatement( {sqlText: command } );
      var rs = stmt.execute();
      if (rs.next())  {
          return_value = rs.getColumnValue(1);
          }
      }
  catch (err)  {
        log("Failed to get conversation_details count for " +AWSFOLDERNAME+ + " "+todayDateString+ ": "+ err);  
        return "Failed to get conversation_details count.";
      }
      
    log("Succeeded ingesting all PI data for today. Conversation_details count is "+ return_value + " for projectid '" + PROJECTID + "'");
    return "Succeeded ingesting all PI data for today";  
  $$;   
    
        CREATE or replace PROCEDURE ingestAllPIDataMultiOrg()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$ 
  var sqlCommand = "call raw.ingestAllPIData('741','NC UI','e529199f-f9a3-49ec-9701-0d26129da22f','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  sqlCommand = "call raw.ingestAllPIData('701','NCEB','3476b75e-94b2-4cf1-ab28-41ba3456de48','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  sqlCommand = "call raw.ingestAllPIData('8888','PAIEB/CHC','b96863fb-d35e-42db-ab0f-a5bbfc1e4599','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  return 'done';  
  $$; 
  
drop task INGEST_NCUI_PI_DATA_PRD;
  
  CREATE TASK INGEST_NCUI_PI_DATA_PRD
  WAREHOUSE = 'PUREINSIGHTS_DP4BI_PRD_WH'
  SCHEDULE = 'USING CRON 00 06 * * * America/New_York'
AS
  call PUREINSIGHTS_PRD.raw.ingestAllPIDataMultiOrg();
  
  ALTER TASK INGEST_NCUI_PI_DATA_PRD RESUME;
  
  
    drop task INGEST_NCUI_PI_DATA_PRD;
CREATE TASK INGEST_NCUI_PI_DATA_PRD
  WAREHOUSE = 'PUREINSIGHTS_PRD_LOAD_WH'
  SCHEDULE = 'USING CRON 06 06 * * * America/New_York'
AS
  call PUREINSIGHTS_PRD.raw.ingestAllPIDataMultiOrg();
  
  ALTER TASK INGEST_NCUI_PI_DATA_PRD RESUME;
  
   drop task INGEST_NCUI_PI_DATA_SANDBOX_PRD
CREATE TASK INGEST_NCUI_PI_DATA_SANDBOX_PRD
  WAREHOUSE = 'PUREINSIGHTS_PRD_LOAD_WH'
  SCHEDULE = 'USING CRON 30 07 * * * America/New_York'
AS
  call PUREINSIGHTS_PRD.raw.ingestAllPIData('9999','SANDBOX','609601d6-469f-4f96-b26c-4cea42ceeff4','','',true);
  
  ALTER TASK INGEST_NCUI_PI_DATA_SANDBOX_PRD RESUME;


-----------------------------------------------------------------

CREATE or replace PROCEDURE dropPIStage(stageName VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
        
     //default stageName
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_2';
     }     
     
    //create stage for today's data
    var sqlCommand = "DROP STAGE RAW." + stageName + ";";
      
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        if (typeof log == 'function'){
            log ("Failed to drop stage "+ stageName + ": "+ err);
        }
        return "Failed to drop stage " + stageName+ ": " + err;
        }
      
  if (typeof log == 'function'){
    log ("Dropped stage " + stageName);    
  }
  return "Dropped stage " + stageName;
  $$;

select * from public.d_pi_projects order by projectid;

call dropPIStage('PUREINSIGHTS_S3_TS1');

CREATE or replace PROCEDURE createPIStage(AWSFolderName VARCHAR, stageName VARCHAR, todayDateString VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
   
function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

     var todayDateString = TODAYDATESTRING;

     //get date string for today if parameter is missing
     if (! TODAYDATESTRING){
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     todayDateString = yyyy + mm + dd;
     }
     
     //default stageName
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_2';
     }     
     
    //create stage for today's data
    var sqlCommand = "CREATE STAGE RAW." + stageName + " URL = 's3://soapax-pureinsights/"+ AWSFOLDERNAME +"/"+ todayDateString +"/' CREDENTIALS=(aws_key_id='AKIAT6QV4CSZF5RW77X4' aws_secret_key='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');";
      
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        if (typeof log == 'function'){
            log ("Failed to create stage "+ stageName + " for " + AWSFOLDERNAME +  " for "+ todayDateString + ": "+ err);
        }
        return "Failed to create stage " + stageName + " for " + AWSFOLDERNAME + " for " + todayDateString;
        }
      
  if (typeof log == 'function'){
    log ("Created stage " + stageName + " for " + AWSFOLDERNAME + " for " + todayDateString+ " hour "+hh);    
  }
  return "Created stage " + stageName + " for " +AWSFOLDERNAME + " for " + todayDateString;
  $$;
  
call createPIStage('3476b75e-94b2-4cf1-ab28-41ba3456de48', 'PUREINSIGHTS_S3_2', '');
 
 
 
 CREATE or replace PROCEDURE ingestAllPIDataTableSetOne(ProjectId VARCHAR, ProjectName VARCHAR, AWSFolderName VARCHAR, stageName VARCHAR, todayDateString VARCHAR, truncateFlag Boolean)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}     

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}
     var todayDateString = TODAYDATESTRING;

     //get date string for today if parameter is missing
     if (! TODAYDATESTRING){
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     todayDateString = yyyy + mm + dd;
     }

     //default stageName
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_TS1';
     } 
    
    var AWSFolderName = AWSFOLDERNAME;
    var truncateFlag = TRUNCATEFLAG;
    
    
    //create stage for today's data
    var sqlCommand = "call createPIStage('" + AWSFOLDERNAME + "','" + stageName + "','" + todayDateString + "');";
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to create stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "Failed to create stage " + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err; 
}
     
    sqlCommand = "call ingestPIData('configuration_objects','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});              
        
    sqlCommand = "call ingestPIData('conversations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});                      
     
    sqlCommand = "call ingestPIData('conversations_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});        
     
     
    sqlCommand = "call ingestPIData('conversations_summary','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('conversation_attributes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
     
    sqlCommand = "call ingestPIData('divisions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});  
    
    sqlCommand = "call ingestPIData('evaluations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('evaluation_forms','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
     
    sqlCommand = "call ingestPIData('groups_membership','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});     
        
    sqlCommand = "call ingestPIData('locations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('participants','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
        
    sqlCommand = "call ingestPIData('primary_presence','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});        
    
    sqlCommand = "call ingestPIData('queues_membership','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
        
    sqlCommand = "call ingestPIData('queue_configuration','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('sessions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});   
    /*
    sqlCommand = "call ingestPIData('session_summary','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
    
    sqlCommand = "call ingestPIData('user_details','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    

    sqlCommand = "call ingestPIData('user_locations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});

    sqlCommand = "call ingestPIData('user_roles','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('user_skills','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    //iteration 2
    
    sqlCommand = "call ingestPIData('flow_outcomes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
 
    sqlCommand = "call ingestPIDataSegments('" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
 
    sqlCommand = "call ingestPIData('mysql_audits','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('audio_quality','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('billable_usage','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('routing_status','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_historical_actuals','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_historical_exceptions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
   
    sqlCommand = "call ingestPIData('wfm_activity_codes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_schedule','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    var sqlCommand = "call ingestPIData('dialer_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('dialer_preview_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    */
    
    //drop stage
    sqlCommand = "call dropPIStage('" + stageName + "');";
      try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to drop stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "Failed to drop stage " + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err; 
}
    
    //get sample count
    var return_value = 0;
    try {
      var command = "SELECT count(*) FROM conversations_detail where projectid = '" + PROJECTID + "';"
      var stmt = snowflake.createStatement( {sqlText: command } );
      var rs = stmt.execute();
      if (rs.next())  {
          return_value = rs.getColumnValue(1);
          }
      }
  catch (err)  {
        log("Failed to get conversation_details count for " +AWSFOLDERNAME+ + " "+todayDateString+ ": "+ err);  
        return "Failed to get conversation_details count.";
      }
      
    log("Succeeded ingesting all Tableset One PI data for today. Conversation_details count is "+ return_value + " for projectid '" + PROJECTID + "'");
    return "Succeeded ingesting all PI data for today";   // Return a success/error indicator.
  $$;  
  
  
  ------------------
 CREATE or replace PROCEDURE ingestAllPIDataTableSetTwo(ProjectId VARCHAR, ProjectName VARCHAR, AWSFolderName VARCHAR, stageName VARCHAR, todayDateString VARCHAR, truncateFlag Boolean)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}     

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}
     var todayDateString = TODAYDATESTRING;

     //get date string for today if parameter is missing
     if (! TODAYDATESTRING){
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     todayDateString = yyyy + mm + dd;
     }

     //default stageName
     var stageName = STAGENAME;
     if (! stageName){
        stageName = 'PUREINSIGHTS_S3_TS2';
     } 
    
    var AWSFolderName = AWSFOLDERNAME;
    var truncateFlag = TRUNCATEFLAG;
    
    
    //create stage for today's data
    var sqlCommand = "call createPIStage('" + AWSFOLDERNAME + "','" + stageName + "','" + todayDateString + "');";
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to create stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "Failed to create stage " + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err; 
}
    /* 
    sqlCommand = "call ingestPIData('configuration_objects','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});              
        
    sqlCommand = "call ingestPIData('conversations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});                      
     
    sqlCommand = "call ingestPIData('conversations_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});        
     
     
    sqlCommand = "call ingestPIData('conversations_summary','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('conversation_attributes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
     
    sqlCommand = "call ingestPIData('divisions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});  
    
    sqlCommand = "call ingestPIData('evaluations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('evaluation_forms','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
     
    sqlCommand = "call ingestPIData('groups_membership','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});     
        
    sqlCommand = "call ingestPIData('locations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('participants','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
        
    sqlCommand = "call ingestPIData('primary_presence','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});        
    
    sqlCommand = "call ingestPIData('queues_membership','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
        
    sqlCommand = "call ingestPIData('queue_configuration','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('sessions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});   
    */
    sqlCommand = "call ingestPIData('session_summary','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    
    
    sqlCommand = "call ingestPIData('user_details','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});    

    sqlCommand = "call ingestPIData('user_locations','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});

    sqlCommand = "call ingestPIData('user_roles','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('user_skills','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    //iteration 2
    
    sqlCommand = "call ingestPIData('flow_outcomes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
 
    sqlCommand = "call ingestPIDataSegments('" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
 
    sqlCommand = "call ingestPIData('mysql_audits','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('audio_quality','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand}); 
    
    sqlCommand = "call ingestPIData('billable_usage','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('routing_status','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_historical_actuals','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_historical_exceptions','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
   
    sqlCommand = "call ingestPIData('wfm_activity_codes','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('wfm_schedule','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    var sqlCommand = "call ingestPIData('dialer_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    sqlCommand = "call ingestPIData('dialer_preview_detail','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag + ");";
    snowflake.execute ({sqlText: sqlCommand});
    
    
    //drop stage
    sqlCommand = "call dropPIStage('" + stageName + "');";
      try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to drop stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "Failed to drop stage " + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err; 
}
    
    //get sample count
    var return_value = 0;
    try {
      var command = "SELECT count(*) FROM wfm_historical_exceptions where projectid = '" + PROJECTID + "';"
      var stmt = snowflake.createStatement( {sqlText: command } );
      var rs = stmt.execute();
      if (rs.next())  {
          return_value = rs.getColumnValue(1);
          }
      }
  catch (err)  {
        log("Failed to get wfm exceptions count for " +AWSFOLDERNAME+ + " "+todayDateString+ ": "+ err);  
        return "Failed to get wfm exceptions count.";
      }
      
    log("Succeeded ingesting all Tableset Two PI data for today. Wfm exceptions count is "+ return_value + " for projectid '" + PROJECTID + "'");
    return "Succeeded ingesting all Tableset Two PI data for today";   // Return a success/error indicator.
  $$;  
  
   
----------------------

    CREATE or replace PROCEDURE ingestAllPIDataTableSetOneMultiOrg()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$ 
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}     

log("Starting to ingest tableset one.");
  var sqlCommand = "call raw.ingestAllPIDataTableSetOne('741','NC UI','e529199f-f9a3-49ec-9701-0d26129da22f','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  sqlCommand = "call raw.ingestAllPIDataTableSetOne('701','NCEB','3476b75e-94b2-4cf1-ab28-41ba3456de48','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  sqlCommand = "call raw.ingestAllPIDataTableSetOne('8888','PAIEB/CHC','b96863fb-d35e-42db-ab0f-a5bbfc1e4599','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
    sqlCommand = "call raw.ingestAllPIDataTableSetOne('7777','FLCT','4d5ee9a3-ce93-43cc-a2a7-0949382ffa80','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  log("Finished ingesting tableset one.");
  return 'done';  
  $$; 
  
  
      CREATE or replace PROCEDURE ingestAllPIDataTableSetTwoMultiOrg()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$ 
  //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(msg){
    snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
}     

log("Starting to ingest tableset two.")
  var sqlCommand = "call raw.ingestAllPIDataTableSetTwo('741','NC UI','e529199f-f9a3-49ec-9701-0d26129da22f','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  sqlCommand = "call raw.ingestAllPIDataTableSetTwo('701','NCEB','3476b75e-94b2-4cf1-ab28-41ba3456de48','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  sqlCommand = "call raw.ingestAllPIDataTableSetTwo('8888','PAIEB/CHC','b96863fb-d35e-42db-ab0f-a5bbfc1e4599','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
    sqlCommand = "call raw.ingestAllPIDataTableSetTwo('7777','FLCT','4d5ee9a3-ce93-43cc-a2a7-0949382ffa80','','',true);";
  snowflake.execute ({sqlText: sqlCommand});
  log("Finished ingesting tableset two.");
  return 'done';  
  $$; 
    
    
    drop task INGEST_PI_DATA_TS1_MULTIORG_PRD;
  CREATE TASK INGEST_PI_DATA_TS1_MULTIORG_PRD
WAREHOUSE = 'PUREINSIGHTS_PRD_LOAD_WH'
  SCHEDULE = 'USING CRON 00 06 * * * America/New_York'
AS
  call PUREINSIGHTS_PRD.raw.ingestAllPIDataTableSetOneMultiOrg();
  
  ALTER TASK INGEST_PI_DATA_TS1_MULTIORG_PRD RESUME;
  
     drop task INGEST_PI_DATA_TS2_MULTIORG_PRD;
  CREATE TASK INGEST_PI_DATA_TS2_MULTIORG_PRD
WAREHOUSE = 'PUREINSIGHTS_PRD_LOAD_WH'
  SCHEDULE = 'USING CRON 00 06 * * * America/New_York'
AS
  call PUREINSIGHTS_PRD.raw.ingestAllPIDataTableSetTwoMultiOrg();
  
  ALTER TASK INGEST_PI_DATA_TS2_MULTIORG_PRD RESUME; 
  
       drop task INGEST_PI_DATA_COVAC_PRD;
CREATE TASK INGEST_PI_DATA_COVAC_PRD
  WAREHOUSE = 'PUREINSIGHTS_PRD_LOAD_WH'
  SCHEDULE = 'USING CRON 30 06 * * * America/New_York'
AS
  call PUREINSIGHTS_PRD.raw.ingestAllPIData('6666','COVAC','b94dde1d-7aa3-4c7f-9531-a8d8d433a6bf','','',true);
  
  ALTER TASK INGEST_PI_DATA_COVAC_PRD RESUME;