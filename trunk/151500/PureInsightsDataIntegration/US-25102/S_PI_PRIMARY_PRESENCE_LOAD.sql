use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema STAGE;

use role sysadmin;
SHOW GRANTS ON PROCEDURE STAGE.S_PI_PRIMARY_PRESENCE_LOAD(VARCHAR, BOOLEAN, BOOLEAN);
SHOW GRANTS ON PROCEDURE STAGE.S_PI_PRJ_SESSION_CONTACT_SUMMARY_LOAD(VARCHAR, BOOLEAN, BOOLEAN);
GRANT USAGE ON PROCEDURE S_PI_PRIMARY_PRESENCE_LOAD(VARCHAR, BOOLEAN, BOOLEAN) TO PI_DATA_INGEST_DEV_ALERT_USER;

use schema STAGE;

CREATE OR REPLACE PROCEDURE S_PI_PRIMARY_PRESENCE_LOAD("PROJECTID" VARCHAR, "REINGESTFLAG" BOOLEAN, "RUNFROMBASHFLAG" BOOLEAN)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";
     if (RUNFROMBASHFLAG) {
      sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG_"+PROJECTID+"';";
     }
     snowflake.execute ({sqlText: sqlCommand});
     
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call RAW.do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
}

REINGEST_SFX = ""
if (REINGESTFLAG){
REINGEST_SFX=" REINGEST";
} 

	var stageTable = "STAGE.S_PI_PRIMARY_PRESENCE";
	var rawTable = "RAW.PRIMARY_PRESENCE";
	var tempTable = stageTable+"_"+PROJECTID;

    log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "INFO","Procedure has started successfully.");

	//CREATE TEMP TABLE
	var sqlCommand = "create or replace table "+tempTable+" as select * from "+rawTable+" where projectid='"+PROJECTID+"';"

	try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "FAILED", "Failed to create table "+tempTable+": "+ err); 
        return "1";
        }
	
    log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "INFO","Succeeded creating temp table "+tempTable);
                
	//TRUNCATE project data

  	sqlCommand = "delete from "+stageTable+" where projectid = '"+PROJECTID+"';";

    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "FAILED", "Failed to truncate project data from "+stageTable+": "+ err); 
        return "2";
        }

    log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "INFO","Succeeded truncating project data from "+stageTable);        
        
    //INSERT NEW DATA INTO STAGE Table
    var sqlCommand = "INSERT INTO "+stageTable+" (PROJECTID, PROJECTNAME, PROGRAMID, PROGRAMNAME, DURATION, ORGANIZATIONPRESENCE, PRESENCEENDTIME, PRESENCEENDDATE, PRESENCESTARTTIME, PRESENCESTARTDATE, PROJECTPRESENCEENDTIME, PROJECTPRESENCEENDDATE, PROJECTPRESENCESTARTTIME, PROJECTPRESENCESTARTDATE, SYSTEMPRESENCE, USERID, USERNAME) select PROJECTID, 	PROJECTNAME, 	PROGRAMID, 	PROGRAMNAME, 	case when  duration < 1 then DATEDIFF(millisecond,presenceStartTime,cast(PRESENCEENDTIME as DATETIME))           else duration end as DURATION, 	ORGANIZATIONPRESENCE, 	PRESENCEENDTIME,     to_date(cast(PRESENCEENDTIME as DATETIME)) as	PRESENCEENDDATE, 	PRESENCESTARTTIME, 	PRESENCESTARTDATE, 	convert_timezone('UTC',projectTimezone,cast (PRESENCEENDTIME as DATETIME)) as PROJECTPRESENCEENDTIME, 	to_date(convert_timezone('UTC',projectTimezone,cast (PRESENCEENDTIME as DATETIME))) as PROJECTPRESENCEENDDATE, 	PROJECTPRESENCESTARTTIME, 	PROJECTPRESENCESTARTDATE, 	SYSTEMPRESENCE, 	USERID, 	USERNAME   from (WITH u AS (SELECT projectid, RAW:id as userId , RAW:name AS userName FROM raw.configuration_objects  WHERE RAW:type = 'user'),         s AS (SELECT RAW:id as statusId , RAW:name AS organizationPresence FROM raw.configuration_objects  WHERE RAW:type = 'statuses')   select distinct rt.projectId as projectId,   pr.projectName as projectName,   rt.programId as programId,   rt.programName as programName,   cast (rt.RAW:duration as INT) as duration,   cast (s.organizationPresence as VARCHAR(255)) as organizationPresence, cast( iff(rt.RAW:endTime < date '2000-01-01',lead(rt.RAW:startTime,1,null) over (partition by  rt.RAW:userId order by rt.RAW:startTime) , rt.RAW:endTime) as DATETIME) as presenceEndTime,   cast (rt.RAW:startTime as DATETIME) as presenceStartTime,   cast (rt.RAW:startTime as DATE) as presenceStartDate,convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:startTime as DATETIME)) as projectPresenceStartTime,   to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:startTime as DATETIME))) as projectPresenceStartDate,   cast (rt.RAW:systemPresence as VARCHAR(255)) as systemPresence,   cast (rt.RAW:userId as VARCHAR(255)) as userId,   cast (u.userName as VARCHAR(255)) as userName,  pr.projecttimezone as projecttimezone from "+tempTable+" rt join PUBLIC.D_PI_PROJECTS pr on rt.projectId = pr.projectId  LEFT OUTER JOIN u ON rt.projectid = u.projectid and rt.RAW:userId = u.userId  LEFT OUTER JOIN s ON rt.RAW:organizationPresenceId = s.statusId) where (presencestarttime <> presenceendtime or presenceendtime is null);";

	try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID,"SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "FAILED","Failed to LOAD NEW DATA INTO "+stageTable+": "+ err);
        return "3";
        }        

    //DROP TEMP table
    var sqlCommand = "drop table "+tempTable+";";

	try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID,"SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "FAILED","Failed to drop temp table "+tempTable+": "+ err);
        return "4";
        }        
 
  log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "INFO","Succeeded dropping temp table "+tempTable+".");        
        
  log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "INFO","Succeeded loading DATA INTO TABLE "+stageTable); 
  log(PROJECTID, "SP"+REINGEST_SFX, "S_PI_PRIMARY_PRESENCE_LOAD", "SUCCEEDED","Procedure has completed successfully."); 
 
  return "0";
  $$;
 
use schema RAW;
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('551', true, true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1001', true, true);

SELECT 'CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('''||projectid||''',true,true);'
FROM PUBLIC.D_PI_PROJECTS
WHERE active = TRUE;

CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('701',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('6666',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('8888',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('5555',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('4444',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('3333',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1111',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('601',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('201',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('621',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('301',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('801',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('221',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('101',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('401',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1001',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('901',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1101',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('2001',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('551',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('903',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('501',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('421',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('321',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('555',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1201',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1301',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('361',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1601',true,true);
CALL STAGE.S_PI_PRIMARY_PRESENCE_LOAD('1701',true,true);

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ts))) as tstamp, * from raw.ingest_pi_data_det_log_551 order by ts desc;
