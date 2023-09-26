use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace file format MYFORMAT2 type=parquet;
grant usage on file format MYFORMAT2 to PI_DATA_INGEST_PRD_ALERT_USER;
show file formats;

alter table d_pi_tables add column ingest_type varchar(255);
alter table d_pi_tables add column key_string varchar(255); 

alter table d_pi_tables_history add column ingest_type varchar(255);
alter table d_pi_tables_history add column key_string varchar(255);    

-- audio_quality

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;sessionId;edgeId;codec'
WHERE 
	table_name = 'audio_quality';

-- billable_usage

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'id;observedDate;licenseName'
WHERE 
	table_name = 'billable_usage';


-- configuration_objects
-- check ingest_type:  DD specifies "Data is either inserted or updated from the table" with PK.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'id'
WHERE 
	table_name = 'configuration_objects';


-- contact_center_settings
-- check ingest_type:  DD specifies "Data is either inserted or updated from the table" with no PK specified

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'NA'
WHERE 
	table_name = 'contact_center_settings';


-- conversation_attributes

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId;participantId;key'
WHERE 
	table_name = 'conversation_attributes';


-- conversations

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId'
WHERE 
	table_name = 'conversations';


-- conversations_detail

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;sessionId;segmentIndex'
WHERE 
	table_name = 'conversations_detail';


-- conversations_summary
-- check ingest_type:  DD specifies "Data is either inserted or updated from the table" with no PK specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'NA'
WHERE 
	table_name = 'conversations_summary';


-- dialer_detail

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;attemptTime'
WHERE 
	table_name = 'dialer_detail';

-- dialer_preview_detail

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;sessionId;attemptStartTime;attemptEndTime'
WHERE 
	table_name = 'dialer_preview_detail';


-- divisions

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;divisionId'
WHERE 
	table_name = 'divisions';


-- evaluation_calibrations

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'id;conversationId;evaluationId'
WHERE 
	table_name = 'evaluation_calibrations';

-- evaluation_forms
-- check ingest_type (not in DD)

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'NA'
WHERE 
	table_name = 'evaluation_forms';


-- evaluations
-- check ingest_type:  
-- DD states "Evaluations that are deleted within 45 days of the conversation start time will be removed from this table."
-- Then it specifies an Update Method:  "Data is either inserted or updated from the table"


UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'id;questionId;questionAnswerID'
WHERE 
	table_name = 'evaluations';


-- flow_outcomes

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;sessionId;outcomeId'
WHERE 
	table_name = 'flow_outcomes';


-- groups_membership
-- check ingestion_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'groupId;userId'
WHERE 
	table_name = 'groups_membership';

-- locations

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'NA'
WHERE 
	table_name = 'locations';


-- mysql_audits
-- check ingestion_type:  Not in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = NULL, 
	key_string = NULL
WHERE 
	table_name = 'mysql_audits';


-- participants

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'participantId'
WHERE 
	table_name = 'participants';


-- primary_presence

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'userId;startTime'
WHERE 
	table_name = 'primary_presence';


-- queue_configuration
-- check ingestion_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'id'
WHERE 
	table_name = 'queue_configuration';



-- queues_membership
-- check ingestion_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.
-- Table is listed as "queue_membership" in DD?

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'queueId;userId'
WHERE 
	table_name = 'queues_membership';


-- routing_status

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'userId;startTime'
WHERE 
	table_name = 'routing_status';


-- segments

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;sessionId;segmentIndex'
WHERE 
	table_name = 'segments';


-- session_summary

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationID;sessionID'
WHERE 
	table_name = 'session_summary';


-- sessions

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'conversationId;sessionId'
WHERE 
	table_name = 'sessions';



-- transcription_topic_phrases
-- Not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'NA'
WHERE 
	table_name = 'transcription_topic_phrases';


-- transcription_topics
-- Not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = NULL, 
	key_string = NULL
WHERE 
	table_name = 'transcription_topics';


-- user_details
-- check ingest_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'id'
WHERE 
	table_name = 'user_details';


-- user_locations
-- check ingest_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'userId;locationId'
WHERE 
	table_name = 'user_locations';


-- user_roles
-- check ingest_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'userId;roleId'
WHERE 
	table_name = 'user_roles';


-- user_skills
-- check ingest_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'userId;skillId'
WHERE 
	table_name = 'user_skills';


-- wfm_activity_codes
-- Table not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'activityCodeId'
WHERE 
	table_name = 'wfm_activity_codes';


-- wfm_day_metrics

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'userId;managementUnitId;dayStartTime'
WHERE 
	table_name = 'wfm_day_metrics';


-- wfm_historical_actuals
-- Table not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'userId;activityStartTime'
WHERE 
	table_name = 'wfm_historical_actuals';

-- wfm_historical_exceptions
-- Table not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'userId;exceptionStartTime'
WHERE 
	table_name = 'wfm_historical_exceptions';


-- wfm_management_unit_configuration
-- check ingestion_type:  DD states "Data can be inserted, updated or removed from the table" and PK is specified.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_insert', 
	key_string = 'managementUnitId'
WHERE 
	table_name = 'wfm_management_unit_configuration';

-- wfm_planning_group_agents

DELETE FROM d_pi_tables WHERE table_name = 'wfm_planning_group_agents';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wfm_planning_group_agents', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');

-- wfm_planning_group_configuration

DELETE FROM d_pi_tables WHERE table_name = 'wfm_planning_group_configuration';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wfm_planning_group_configuration', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');

-- wfm_schedule
-- Table is listed as wfs_schedules in DD.  We have not been specified with any rules to use to detect deletes.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'truncate_multi_file_insert', 
	key_string = 'scheduleID;userId;activityStartTime'
WHERE 
	table_name = 'wfm_schedule';

-- wrapup_mapping

DELETE FROM d_pi_tables WHERE table_name = 'wrapup_mapping';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wrapup_mapping', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'wrapupCodeId');

SELECT * FROM pureinsights_uat.PUBLIC.d_pi_tables WHERE table_name NOT IN (SELECT table_name FROM d_pi_tables WHERE active = true);

SELECT
  pia.*
FROM 
    PUREINSIGHTS_UAT.PUBLIC.D_PI_TABLES pid
    LEFT JOIN
    PUBLIC.d_pi_tables pia    
    ON (pid.table_name = pia.table_name)
WHERE
     pid.ingest_type != pia.ingest_type
  OR pid.key_string != pia.key_string
  OR pid.active != pia.ACTIVE 
  OR pid.s3_sourced != pia.s3_sourced;

use role PI_DATA_INGEST_PRD_ALERT_USER;
use schema RAW;
  
create or replace view PI_TABLES_CHANGE_DATA COPY GRANTS as
select table_name, s3_sourced, active, ingest_type, key_string, start_time, end_time, current_flag, 'I' as dml_type
from (select table_name, s3_sourced, active, ingest_type, key_string, update_timestamp as start_time,
      lag(update_timestamp) over (partition by table_name order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag
      from (select table_name, s3_sourced, active,ingest_type, key_string, update_timestamp
            from pi_tables_stream
            where metadata$action = 'INSERT'
            and metadata$isupdate = 'FALSE'))
union
select table_name, s3_sourced, active,  ingest_type, key_string, start_time, end_time, current_flag, dml_type
from (select table_name, s3_sourced, active,  ingest_type, key_string, update_timestamp as start_time,
      lag(update_timestamp) over (partition by table_name order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag,dml_type
      from (-- Identify data to insert into nation_history table
        select table_name, s3_sourced, active,  ingest_type, key_string, update_timestamp, 'I' as dml_type
        from pi_tables_stream
        where metadata$action = 'INSERT'
        and metadata$isupdate = 'TRUE'
union
select table_name, null, null, null,null,start_time, 'U' as dml_type
from public.d_pi_tables_history
where table_name in (select distinct table_name 
                             from pi_tables_stream
                             where metadata$action = 'INSERT'
                             and metadata$isupdate = 'TRUE')
        and current_flag = 1))
union
select str.table_name, null, null, null,null,hist.start_time, current_timestamp()::timestamp_ntz, null, 'D'
from public.d_pi_tables_history hist
inner join pi_tables_stream str
on hist.table_name = str.table_name
where str.metadata$action = 'DELETE'
and str.metadata$isupdate = 'FALSE'
and hist.current_flag = 1;
  
  
CREATE or replace PROCEDURE update_tables_history()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  
var sqlCommand = `merge into public.d_pi_tables_history nh
using pi_tables_change_data m 
   on  nh.table_name = m.table_name 
   and nh.start_time = m.start_time
when matched and m.dml_type = 'U' then update
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when matched and m.dml_type = 'D' then update 
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when not matched and m.dml_type = 'I' then insert
           (table_name, s3_sourced, active,  ingest_type, key_string, start_time, end_time, current_flag)
    values (m.table_name, m.s3_sourced, m.active,  m.ingest_type, m.key_string, m.start_time, m.end_time, m.current_flag);`;

snowflake.execute ({sqlText: sqlCommand});

sqlCommand = `update public.d_pi_tables_history hist
set hist.end_time = temp.real_end_time
from 
(select table_name, start_time, end_time ,
    lead (start_time) over (partition by table_name order by start_time asc) as proposed_end_time,
    case when proposed_end_time is not null and timestampdiff(seconds,end_time, proposed_end_time) <=60 then proposed_end_time else end_time end as real_end_time
from public.d_pi_tables_history) as temp
where hist.table_name = temp.table_name
and hist.start_time = temp.start_time
and hist.end_time != temp.real_end_time;
--and some time within 1 minute of now`;

snowflake.execute ({sqlText: sqlCommand});

return 0;

$$;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE VIEW D_PI_INGESTION_PROJECTS_VW COPY GRANTS
AS
SELECT * FROM PUBLIC.D_PI_PROJECTS WHERE active = true;

GRANT SELECT, REFERENCES ON D_PI_INGESTION_PROJECTS_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON D_PI_INGESTION_PROJECTS_VW TO ROLE DATA_SUPPORT_ROLE;


use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

create or replace TABLE PI_FILES_TO_INGEST (
	PROJECTID VARCHAR(255),
	PROGRAMID VARCHAR(255),
	TABLENAME VARCHAR(500),
	FILENAME VARCHAR(500),
	FILE_TIMESTAMP TIMESTAMP_NTZ(9),
	INGEST_START_TIMESTAMP TIMESTAMP_NTZ(9),
	INGEST_END_TIMESTAMP TIMESTAMP_NTZ(9),
	STATUS VARCHAR(255),
	STATUS_MSG VARCHAR(4000),
	STATUS_TIMESTAMP TIMESTAMP_NTZ(9)
);

insert into pi_files_to_ingest select * from pureinsights_uat.raw.pi_files_to_ingest;

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE createProjectFilesListTables (reIngestFlag Boolean)
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

var project_array=[];
var sqlCommand = "select projectid from public.D_PI_INGESTION_PROJECTS_VW;"
var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var projectid = rs.getColumnValue(1);
     project_array.push(projectid);
    }
  
  for (const projectid of project_array) {
//create tables
    sqlCommand = `create or replace TABLE PI_FILES_TO_INGEST_`+ projectid +` (
	PROJECTID VARCHAR(255),
	PROGRAMID VARCHAR(255),
        TABLENAME VARCHAR(500),
	FILENAME VARCHAR(500),
  	FILE_TIMESTAMP TIMESTAMP_NTZ(9),
	INGEST_START_TIMESTAMP TIMESTAMP_NTZ(9),
	INGEST_END_TIMESTAMP TIMESTAMP_NTZ(9),
	STATUS VARCHAR(255),
	STATUS_MSG VARCHAR(4000),
        STATUS_TIMESTAMP TIMESTAMP_NTZ(9)
);`;
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(projectid, "LOG"+REINGEST_SFX, "NA", "FAILED","Failed to create ingest files list table for project " + projectid +  ": "+ err); 
        return "3"; 
}

}     

    return "0";  
  $$;

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE TABLE raw.pi_files_to_ingest_2222 AS SELECT * FROM raw.pi_files_to_ingest;
CREATE OR REPLACE TABLE raw.pi_files_to_ingest_740 AS SELECT * FROM raw.pi_files_to_ingest;

CALL createProjectFilesListTables (true);

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

GRANT SELECT, REFERENCES ON ALL VIEWS IN SCHEMA RAW TO SYSADMIN;
GRANT SELECT, REFERENCES ON ALL TABLES IN SCHEMA RAW TO SYSADMIN;

USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE TABLE WRAPUP_MAPPING CLONE DIALER_DETAIL;
TRUNCATE TABLE WRAPUP_MAPPING;

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE GEN_DP4BI_PRD;
GRANT SELECT, REFERENCES ON TABLE WRAPUP_MAPPING TO ROLE KYVOS_DP4BI_PRD_READ;
GRANT SELECT, REFERENCES ON TABLE WRAPUP_MAPPING TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE PUREINSIGHTS_PRD_POC;
GRANT SELECT, REFERENCES ON TABLE WRAPUP_MAPPING TO ROLE PUREINSIGHTS_PRD_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE PUREINSIGHTS_GEN_DP4BI_PRD;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE createPIStageV2(AWSFolderName VARCHAR, stageName VARCHAR)
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
     
    //create stage for today''s data
    var sqlCommand = "CREATE STAGE RAW." + stageName + " URL = 's3://soapax-pureinsights-v2/"+ AWSFOLDERNAME +"/' STORAGE_INTEGRATION = PI_PARQUET_V2_S3_INT;";   
    snowflake.execute ({sqlText: sqlCommand});

  return "0";
  $$;  

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE getFilesToIngest(projectid varchar, programName varchar, tableName varchar, stageName varchar, afterTime varchar, beforeTime varchar, reIngestFlag Boolean, runFromBashFlag Boolean)
	RETURNS VARCHAR
  	LANGUAGE javascript
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
 
	function log(projectid, object_category, object_name, status_string, msg)
	{
    	snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
	}        

	function convertTZ(date, tzString) 
	{
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

	if (REINGESTFLAG)
	{
		REINGEST_SFX=" REINGEST";
	}         

   	sqlCommand = "list @"+ STAGENAME + "/"+ TABLENAME + " pattern='.*/*parquet';";

   	if (TABLENAME == "ALL")
   	{
    	sqlCommand = "list @"+ STAGENAME + " pattern='.*/*parquet';";
    }

    try 
    {
    	snowflake.execute ({sqlText: sqlCommand});
   	}
    catch (err)  
    {
    	log( PROJECTID, "S3 DATA"+REINGEST_SFX, "LIST FILES", "FAILED", "Failed to list files for projectid " + PROJECTID + " and table "+TABLENAME+": "+ err); 
       	return "4";
   	}

     var pi_files_to_ingest_table = "PI_FILES_TO_INGEST";

     if (RUNFROMBASHFLAG) {
      pi_files_to_ingest_table = "PI_FILES_TO_INGEST_"+PROJECTID;
     }

	sqlCommand = "insert into "+pi_files_to_ingest_table+" select * from (with parquet as (select case when split_part(\"name\",'/','-3') in ('transcription_topics','transcription_sentiment') then split_part(\"name\",'/','-3') else split_part(\"name\",'/','-2') end as tablename,split_part(\"name\",'/','-1') as filename,\"last_modified\" as modified_timestamp FROM table(result_scan(last_query_id())) lsid where convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) >= to_timestamp('"+AFTERTIME+"','YYYY/MM/DD HH24:MI:SS') and convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) <= to_timestamp('"+BEFORETIME+"','YYYY/MM/DD HH24:MI:SS') order by \"last_modified\") select '"+PROJECTID+"',null, pt.tablename,pt.filename,convert_timezone('UTC','America/New_York',to_timestamp(rtrim(modified_timestamp,' GMT'),'DY, DD MON YYYY HH24:MI:SS')),null,null,null,null,null from parquet pt left outer join pi_files_to_ingest fti on fti.projectid = '"+PROJECTID+"' and fti.tablename = pt.tablename and fti.filename = pt.filename and fti.file_timestamp = convert_timezone('UTC','America/New_York',to_timestamp(rtrim(modified_timestamp,' GMT'),'DY, DD MON YYYY HH24:MI:SS')) where ((fti.file_timestamp is null or fti.status != 'COMPLETE') and (pt.tablename != 'wfm_schedule' or REGEXP_COUNT(pt.filename, '_', 1, 'i') = 2)));";

   	//sqlCommand = "insert into pi_files_to_ingest_"+PROJECTID+" select * from (with parquet as (select case when split_part(\"name\",'/','-3') in ('transcription_topics','transcription_sentiment') then split_part(\"name\",'/','-3') else split_part(\"name\",'/','-2') end as tablename,split_part(\"name\",'/','-1') as filename,\"last_modified\" as modified_timestamp FROM table(result_scan(last_query_id())) lsid where convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) >= convert_timezone('America/New_York','UTC',to_timestamp('"+AFTERTIME+"','YYYY/MM/DD HH24:MI:SS')) and convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) < convert_timezone('America/New_York','UTC',to_timestamp('"+BEFORETIME+"','YYYY/MM/DD HH24:MI:SS')) order by \"last_modified\") select '"+PROJECTID+"',null, pt.tablename,pt.filename,convert_timezone('UTC','America/New_York',to_timestamp(rtrim(modified_timestamp,' GMT'),'DY, DD MON YYYY HH24:MI:SS')),null,null,null,null,null from parquet pt left outer join pi_files_to_ingest fti on fti.projectid = '"+PROJECTID+"' and fti.tablename = pt.tablename and fti.filename = pt.filename and fti.file_timestamp = convert_timezone('UTC','America/New_York',to_timestamp(rtrim(modified_timestamp,' GMT'),'DY, DD MON YYYY HH24:MI:SS')) where (fti.file_timestamp is null));";
	//log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO",sqlCommand); 

    try 
    {
    	snowflake.execute ({sqlText: sqlCommand});
   	}
    catch (err)
    {
    	log( PROJECTID, "S3 DATA"+REINGEST_SFX, "LIST FILES", "FAILED", "Failed to list files for projectid " + PROJECTID + " and table "+TABLENAME+": "+ err); 
        return "4";
   	}
    return "0";  
  	$$; 

 
use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE INGESTPIDATA_V2 (TABLENAME VARCHAR, STAGENAME VARCHAR, AWSFOLDERNAME VARCHAR,PROJECTID VARCHAR,PROJECTNAME VARCHAR, TRUNCATEFLAG BOOLEAN, REINGESTFLAG BOOLEAN,runFromBashFlag Boolean, tableIngestType varchar,tableKeyString varchar)
	RETURNS VARCHAR
  	LANGUAGE javascript
  	EXECUTE AS CALLER
  	AS
  	$$  
  	
  	var attempt = 0;
  	var max_attempts = 3000;
  	var	wait_seconds = 1;
  	  
	REINGEST_SFX = ""

	if (REINGESTFLAG)
	{
		REINGEST_SFX=" REINGEST";
	} 

	//set logging on

	var sqlCommand = "set do_log = true;";
   	snowflake.execute({sqlText: sqlCommand});

	sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";

	if (RUNFROMBASHFLAG) 
	{
    	sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG_"+PROJECTID+"';";
   	}
    snowflake.execute({sqlText: sqlCommand});
     
	function log(projectid, object_category, object_name, status_string, msg)
	{
    	snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] }).execute();
	}

	function wrapInsertValue(value, dataType){
	    if (value == 'null'){
	        return 'NULL';
	    }
	    switch (dataType){
	        case "TEXT":
	            return "'" + escapeInsertString(value) + "'";
	        case "OBJECT":
	            return "'" + escapeInsertString(value) + "'";
	        case "TIMESTAMP_TZ":
	            return "'" + value + "'";
	        case "TIMESTAMP":
	            return "'" + value + "'";
	        default: return value;
	    }
	}

	function escapeInsertString(value) {
	    var s = value.replace(/\\/g, "\\\\");
	    s = s.replace(/'/g, "''" );
	    s = s.replace(/"/g, '\\"');
	    s = s.replace(/\s+/g, " ");
	//  s = s.replace(/[^\x00-\x7F]/g, "");
	    return s;
	}	
	
	//default stage
	var stageName = STAGENAME;

	if (! stageName)
	{
		stageName = 'PUREINSIGHTS_S3_2';
   	} 

	var LOG_CATEGORY="TABLE";
	if (REINGESTFLAG)
	{
		LOG_CATEGORY="TABLE REINGEST";
	}

	//get list of files to ingest for this table

	var file_array=[];
	var filecslist = "?";

     	var pi_files_to_ingest_table = "PI_FILES_TO_INGEST";

     	if (RUNFROMBASHFLAG) {
      	  pi_files_to_ingest_table = "PI_FILES_TO_INGEST_"+PROJECTID;
     	}

	var sqlCommand = "select filename, to_varchar(file_timestamp) from "+pi_files_to_ingest_table+" where projectid = '"+PROJECTID+"' and tablename = '"+TABLENAME+"' and ingest_start_timestamp is null order by file_timestamp;";
    var createdSQL = snowflake.createStatement({sqlText: sqlCommand});
    var rs = createdSQL.execute();

   while (rs.next()) 
    {
		 var fileName = rs.getColumnValue(1);
		 var file_ts = rs.getColumnValue(2)
		 file_array.push(fileName+";"+file_ts);
		
		 if (filecslist == "?")
		 {
			filecslist = "'" + fileName + "'";
		 }
		 else
		 {
		 	filecslist += ",'" + fileName + "'";  
		 }
    }

    var filesToIngestCount = file_array.length;
 
 	if (filesToIngestCount < 1)
 	{
  		log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"WARNING","Table " + TABLENAME + " has 0 files to ingest."); 
	} 
 	else 
 	{
 		log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"INFO","filesToIngestCount: " + filesToIngestCount); 
 
		//tableingesttype
		//"truncate_insert","merge_no_deletes","merge_with_deletes", "insert"

		log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO","table ingest type: " + TABLEINGESTTYPE); 

		if (TABLEINGESTTYPE == "merge_no_deletes" || TABLEINGESTTYPE == "multi_file_merge_no_deletes")
		{
			var keyCounter = 0;
			var keyOnSQL = "";
			var selectKeySQL = "";
			var keyArray = TABLEKEYSTRING.split(";");

			for (const pKey of keyArray)
			{
				keyCounter++;

				if (keyCounter == 1)
				{
 					selectKeySQL = `SELECT parse_json(t.$1):`+pKey+`::string as pKey`+keyCounter+`,`;
 					keyOnSQL = `ON ` +TABLENAME+`.raw:`+pKey+`::string = bar.pKey`+keyCounter;
 				} 
 				else 
 				{
 					selectKeySQL += `parse_json(t.$1):`+pKey+`::string as pKey`+keyCounter+`,`;
 					keyOnSQL += ` AND `+TABLENAME+`.raw:`+pKey+`::string = bar.pKey`+keyCounter;
 				}
			}

			//ingest files

			if (TABLEINGESTTYPE == "merge_no_deletes")
			{
				for (const fileinfo of file_array) 
				{
					var info_array = fileinfo.split(";");
					var filename = info_array[0];
					var file_timestamp = info_array[1];
	
					//update files to ingest TABLE
					
	   				var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'IN PROGRESS', status_msg = 'Ingestion is currently running...', ingest_start_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where projectid = '"+PROJECTID+"' AND tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
	   				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
	  
					try 
					{
						snowflake.execute({sqlText: sqlCommand});
					                  
					}
					catch (err)  
					{
					
						log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 
						return "99";				
					}
        		        		        			
					var sqlCommand = `MERGE INTO `+TABLENAME+` USING
					(
					 `+selectKeySQL+`
					 t.$1 as newRecord
					from @`+stageName+`/`+TABLENAME+`/`+filename+` (PATTERN=>'.*.parquet', FILE_FORMAT => myformat2) t 
					) bar `+keyOnSQL+`
					and `+TABLENAME+`.projectid = '`+PROJECTID+`'
					WHEN MATCHED THEN
					 UPDATE SET `+TABLENAME+`.raw = bar.newRecord,`+TABLENAME+`.ingestiondatetime = convert_timezone('UTC','America/New_York',sysdate()),`+TABLENAME+`.ingestiondmloperation = 'UPDATE',`+TABLENAME+`.ingestionsource = '`+filename+`'
					 WHEN NOT MATCHED THEN
					 INSERT
					 (projectid, projectname, programid, programname,raw, ingestiondatetime, ingestiondmloperation, ingestionsource
					 ) VALUES
					 ('`+PROJECTID+`','`+PROJECTNAME+`',null,null,bar.newRecord,convert_timezone('UTC','America/New_York',sysdate()), 'INSERT', '`+filename+`'
					 );`;

					var fileIngestionSQLCommand = "call execFileIngestionSQLCommand('"+PROJECTID+"','','"+TABLENAME+"','"+filename+"','"+file_timestamp+"',"+wrapInsertValue(sqlCommand, "TEXT")+",true,"+REINGESTFLAG+","+RUNFROMBASHFLAG+");";
	
	  				try 
	  				{
	            		snowflake.execute ({sqlText: fileIngestionSQLCommand});
	        		}
	    			catch (err)  
	    			{
	        			log(PROJECTID, "FILES"+REINGEST_SFX, LOG_CATEGORY, "FAILED","SQL:"+fileIngestionSQLCommand+" - "+ err); 
	        			return "55"; 
					}
						
	           				        				        				       
	    		}

  			}
			else
			{
				//update files to ingest TABLE
				
   				var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'IN PROGRESS', status_msg = 'Ingestion is currently running...', ingest_start_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where projectid = '"+PROJECTID+"' AND tablename = '" + TABLENAME + "';";
   				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
  
				try 
				{
					snowflake.execute({sqlText: sqlCommand});
				                  
				}
				catch (err)  
				{
				
					log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for table " +TABLENAME+ ": "+ err); 
					return "99";				
				}
    		        		        			
				var sqlCommand = `MERGE INTO `+TABLENAME+` USING
				(
				 select * from (`+selectKeySQL+`
				 substr(METADATA$FILENAME, regexp_instr(METADATA$FILENAME, '`+TABLENAME+`')+LENGTH('`+TABLENAME+`')+1) as file_name,
				 t.$1 as newRecord
				from @`+stageName+`/`+TABLENAME+` (PATTERN=>'.*.parquet', FILE_FORMAT => myformat2) t) 
                where file_name in (select filename from raw.`+pi_files_to_ingest_table+` where projectid = '`+PROJECTID+`' and tablename = '`+TABLENAME+`')
				) bar `+keyOnSQL+`
				and `+TABLENAME+`.projectid = '`+PROJECTID+`'
				WHEN MATCHED THEN
				 UPDATE SET `+TABLENAME+`.raw = bar.newRecord,`+TABLENAME+`.ingestiondatetime = convert_timezone('UTC','America/New_York',sysdate()),`+TABLENAME+`.ingestiondmloperation = 'UPDATE',`+TABLENAME+`.ingestionsource = bar.file_name 
				 WHEN NOT MATCHED THEN
				 INSERT
				 (projectid, projectname, programid, programname,raw, ingestiondatetime, ingestiondmloperation, ingestionsource
				 ) VALUES
				 ('`+PROJECTID+`','`+PROJECTNAME+`',null,null,bar.newRecord,convert_timezone('UTC','America/New_York',sysdate()), 'INSERT', bar.file_name
				 );`;

				var fileIngestionSQLCommand = "call execFileIngestionSQLCommand('"+PROJECTID+"','','"+TABLENAME+"','NA','1900-01-01',"+wrapInsertValue(sqlCommand, "TEXT")+",true,"+REINGESTFLAG+","+RUNFROMBASHFLAG+");";

  				try 
  				{
            		snowflake.execute ({sqlText: fileIngestionSQLCommand});
        		}
    			catch (err)  
    			{
        			log(PROJECTID, "FILES"+REINGEST_SFX, LOG_CATEGORY, "FAILED","SQL:"+fileIngestionSQLCommand+" - "+ err); 
        			return "55"; 
				}

			}
  
		}

		if (TABLEINGESTTYPE == "truncate_insert" || TABLEINGESTTYPE == "truncate_file_insert" || TABLEINGESTTYPE == "truncate_multi_file_insert")
		{

			if (TABLEINGESTTYPE == "truncate_insert")
			{
				var sqlCommand = "delete from raw."+TABLENAME+" where projectid = '" + PROJECTID + "';";
			}
			else
			{
				var sqlCommand = "delete from raw."+TABLENAME+" where projectid = '" + PROJECTID + "' and ingestionsource IN (select filename from raw."+pi_files_to_ingest_table+" where tablename='"+TABLENAME+"');";
			}
   					
			var fileIngestionSQLCommand = "call execFileIngestionSQLCommand('"+PROJECTID+"','','"+TABLENAME+"','NA','1900-01-01',"+wrapInsertValue(sqlCommand, "TEXT")+",false,"+REINGESTFLAG+","+RUNFROMBASHFLAG+");";


			try 
			{
        		snowflake.execute ({sqlText: fileIngestionSQLCommand});
    		}
			catch (err)  
			{
    			log(PROJECTID, "FILES"+REINGEST_SFX, TABLENAME, "FAILED","SQL:"+fileIngestionSQLCommand+" - "+ err); 
    			return "5"; 
			}
	
			//ingest data from parquet files

            if (TABLEINGESTTYPE != "truncate_multi_file_insert")
			{

				for (const fileinfo of file_array) 
				{
					var info_array = fileinfo.split(";");
					var filename = info_array[0];
					var file_timestamp = info_array[1];
	
					//update files to ingest TABLE
					
	   				var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'IN PROGRESS', status_msg = 'Ingestion is currently running...', ingest_start_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where projectid = '"+PROJECTID+"' AND tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
	   				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
	  
					try 
					{
						snowflake.execute({sqlText: sqlCommand});
					                  
					}
					catch (err)  
					{
					
						log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 
						return "99";				
					}
					
	
					//var sqlCommand = "copy into raw." + TABLENAME + " (projectid, projectname, ingestiondmloperation, ingestionsource, ingestionDateTime, raw) from (select '"+ PROJECTID +"','" + PROJECTNAME + "','INSERT','"+filename+"',convert_timezone('UTC','America/New_York',sysdate()), * from @" + stageName + "/" + TABLENAME + "/) PATTERN='.*"+filename+"' FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;"; 
					var sqlCommand = "copy into raw." + TABLENAME + " (projectid, projectname, ingestiondmloperation, ingestionsource, ingestionDateTime, raw) from (select '"+ PROJECTID +"','" + PROJECTNAME + "','INSERT','"+filename+"',convert_timezone('UTC','America/New_York',sysdate()), * from @" + stageName + "/" + TABLENAME + "/) FILES=('"+filename+"') FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;";		  			
	
	
					var fileIngestionSQLCommand = "call execFileIngestionSQLCommand('"+PROJECTID+"','','"+TABLENAME+"','"+filename+"','"+file_timestamp+"',"+wrapInsertValue(sqlCommand, "TEXT")+",true,"+REINGESTFLAG+","+RUNFROMBASHFLAG+");";
	
	  				try 
	  				{
	            		snowflake.execute ({sqlText: fileIngestionSQLCommand});
	        		}
	    			catch (err)  
	    			{
	        			log(PROJECTID, "FILES"+REINGEST_SFX, LOG_CATEGORY, "FAILED","SQL:"+fileIngestionSQLCommand+" - "+ err); 
	        			return "55"; 
					}
				
			        					    
	  			}
			}
			else
			{

   				var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'IN PROGRESS', status_msg = 'Ingestion is currently running...', ingest_start_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where projectid = '"+PROJECTID+"' AND tablename = '" + TABLENAME + "';";
   				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
  
				try 
				{
					snowflake.execute({sqlText: sqlCommand});
				                  
				}
				catch (err)  
				{
				
					log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for table " +TABLENAME+ ": "+ err); 
					return "99";				
				}

				const filecslistarr = filecslist.split(',');
				filecslist = "?";

				var fileCounter = 0;
	
				for (const filecs of filecslistarr)
				{
					fileCounter++;

					if (filecslist == "?")
					{
						filecslist = filecs;
					}
					else
					{
					 	filecslist += "," + filecs;  
					}
	
					if (fileCounter % 1000 == 0 || fileCounter == filecslistarr.length)
					{

						var sqlCommand = "copy into raw." + TABLENAME + " (projectid, projectname, ingestiondmloperation, ingestionsource, ingestionDateTime, raw) from (select '"+ PROJECTID +"','" + PROJECTNAME + "','INSERT',substr(METADATA$FILENAME, regexp_instr(METADATA$FILENAME, '"+TABLENAME+"')+LENGTH('"+TABLENAME+"')+1),convert_timezone('UTC','America/New_York',sysdate()), * from @" + stageName + "/" + TABLENAME + "/) FILES=("+filecslist+") FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;";		  			


						if (fileCounter == filecslistarr.length)
						{
							var fileIngestionSQLCommand = "call execFileIngestionSQLCommand('"+PROJECTID+"','','"+TABLENAME+"','NA','1900-01-01',"+wrapInsertValue(sqlCommand, "TEXT")+",true,"+REINGESTFLAG+","+RUNFROMBASHFLAG+");";
						}
						else
						{
							var fileIngestionSQLCommand = "call execFileIngestionSQLCommand('"+PROJECTID+"','','"+TABLENAME+"','NA','1900-01-01',"+wrapInsertValue(sqlCommand, "TEXT")+",false,"+REINGESTFLAG+","+RUNFROMBASHFLAG+");";
						}

		  				try 
		  				{
		            		snowflake.execute ({sqlText: fileIngestionSQLCommand});
		        		}
		    			catch (err)  
		    			{
		        			log(PROJECTID, "FILES"+REINGEST_SFX, LOG_CATEGORY, "FAILED","SQL:"+fileIngestionSQLCommand+" - "+ err); 
		        			return "55"; 
						}
					
						filecslist = "?";
						
	 				} 

				}				

			} 
		}
	}

/*
	//generate warning if 0 records for any table not listed in unavailable tables table
    var sqlCommand = "select count(*) from raw." + TABLENAME + " rw where rw.projectid = '" + PROJECTID + "';"; 
 
  	try 
  	{
    	stmt = snowflake.createStatement({sqlText: sqlCommand});
       	var result1 = stmt.execute();

        result1.next();
      	rowCount = result1.getColumnValue(1); 
  	}
    catch (err)  
    {
    	log(PROJECTID, "TABLE ROW COUNT"+REINGEST_SFX, TABLENAME, "FAILED","Failed to count records after ingestion: "+ err);
        return "4";
    }

    log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"INFO","rowcount: " + rowCount); 
        
   	if (rowCount < 1) 
   	{
       log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"WARNING","Table " + TABLENAME + " has 0 records after ingestion."); 
	} 

*/
  	log(PROJECTID, LOG_CATEGORY, TABLENAME, "SUCCEEDED","Succeeded loading files for table " + TABLENAME + " for projectid " + PROJECTID);
  	return "0";  
  	$$;   
 

  
use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;


CREATE or replace PROCEDURE INGESTPIDATASEGMENTS_V2(TABLENAME VARCHAR, STAGENAME VARCHAR, AWSFOLDERNAME VARCHAR,PROJECTID VARCHAR,PROJECTNAME VARCHAR, TRUNCATEFLAG BOOLEAN, REINGESTFLAG BOOLEAN,runFromBashFlag BOOLEAN, tableIngestType VARCHAR,tableKeyString VARCHAR)
	RETURNS VARCHAR
  	LANGUAGE javascript
  	EXECUTE AS CALLER
  	AS
  	$$  
  
  	var attempt=0;
  	var max_attempts=100;
  	var wait_seconds=30;
  	
  	var REINGEST_SFX = "";
    
	if (REINGESTFLAG)
	{
		REINGEST_SFX=" REINGEST";
	} 

	//set logging on
   	var sqlCommand = "set do_log = true;";
   	snowflake.execute ({sqlText: sqlCommand});

  	sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";

  	if (RUNFROMBASHFLAG) 
  	{
    	sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG_"+PROJECTID+"';";
   	}

   	snowflake.execute ({sqlText: sqlCommand});
     
	function log(projectid, object_category, object_name, status_string, msg)
	{
    	snowflake.createStatement({sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg]}).execute();
	}

 	//default stage
  	var stageName = STAGENAME;

  	if (! stageName)
  	{
    	stageName = 'PUREINSIGHTS_S3_2';
   	} 

	var LOG_CATEGORY="TABLE";
	if (REINGESTFLAG)
	{
   		LOG_CATEGORY="TABLE REINGEST";
	}

	//get list of files to ingest for this table

	var file_array=[];
 	var sqlCommand = "select filename, to_varchar(file_timestamp) from pi_files_to_ingest_" + PROJECTID + " where projectid = '"+PROJECTID+"' and tablename = '"+TABLENAME+"' and ingest_start_timestamp is null order by file_timestamp;";
    var createdSQL = snowflake.createStatement({sqlText: sqlCommand });
    var rs = createdSQL.execute();
   
   	while (rs.next()) 
    {
    	var fileName = rs.getColumnValue(1);
     	var file_ts = rs.getColumnValue(2)
     	file_array.push(fileName+";"+file_ts);
    }

 	var filesToIngestCount = file_array.length;
 
 	if (filesToIngestCount < 1)
 	{
  		log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"WARNING","Table " + TABLENAME + " has 0 files to ingest."); 
	} 
	else 
	{
		log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"INFO","filesToIngestCount: " + filesToIngestCount); 
 
		//tableingesttype
		//"truncate_insert","merge_no_deletes","merge_with_deletes", "insert"
 
		log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO","table ingest type: " + TABLEINGESTTYPE); 

		if (TABLEINGESTTYPE == "merge_no_deletes")
		{

			//get keys
			//var keyString = "conversationId";

			var keyCounter = 0;
			var keyOnSQL = "";
			var selectKeySQL = "";
			var keyArray = TABLEKEYSTRING.split(";");

			for (const pKey of keyArray)
			{
				keyCounter++;

				if (keyCounter == 1)
				{
 					selectKeySQL = `SELECT parse_json(t.$1):`+pKey+` as pKey`+keyCounter+`,`;
 					keyOnSQL = `ON NVL(TO_CHAR(` +TABLENAME+`.raw:`+pKey+`),'') = NVL(TO_CHAR(bar.pKey`+keyCounter+`),'')`;
 				} 
 				else 
 				{
 					selectKeySQL += `parse_json(t.$1):`+pKey+` as pKey`+keyCounter+`,`;
 					keyOnSQL += ` AND NVL(TO_CHAR(` +TABLENAME+`.raw:`+pKey+`),'') = NVL(TO_CHAR(bar.pKey`+keyCounter+`),'')`;
 				}
			}

			//ingest files

			for (const fileinfo of file_array) 
			{
				var info_array = fileinfo.split(";");
				var filename = info_array[0];
				var file_timestamp = info_array[1];

			    log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO", "FILENAME="+filename+",FILE_TIMESTAMP="+file_timestamp);
			
				//update files to ingest table
   				var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'IN PROGRESS', status_msg = 'Ingestion is currently running...', ingest_start_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
   				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
  
    			try 
    			{
            		snowflake.execute ({sqlText: sqlCommand});
                      
        		}
    			catch (err)  
    			{
        			log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 
        			return "99";
        		}
		
				attempt = 0;
		
				while (attempt <= max_attempts)
				{			
					if (attempt != 0)
					{
				       var sqlCommand = "call SYSTEM$WAIT("+wait_seconds+",'SECONDS');";
				       snowflake.execute ({sqlText: sqlCommand});
					}

					attempt++;
				
					try 
	  				{
				 	  				
						var sqlCommand = `MERGE INTO `+TABLENAME+` USING
						(
						 `+selectKeySQL+` parse_json(cast('{' || '"audioMuted":"'|| COALESCE(to_char(parse_json(t.$1):audioMuted),'') || '",' || '"conference":"'|| COALESCE(to_char(parse_json(t.$1):conference),'') || '",' || '"conversationId":"'|| COALESCE(to_char(parse_json(t.$1):conversationId),'') || '",' || '"disconnecttype":"'|| COALESCE(to_char(parse_json(t.$1):disconnecttype),'') || '",' || '"errorCode":"'|| COALESCE(to_char(parse_json(t.$1):errorCode),'') || '",' || '"participantid":"'|| COALESCE(to_char(parse_json(t.$1):participantid),'') || '",' || '"queueId":"'|| COALESCE(to_char(parse_json(t.$1):queueId),'') || '",' || '"segmentEndTime":"'|| COALESCE(to_char(parse_json(t.$1):segmentEndTime),'') || '",' || '"segmentStartTime":"'|| COALESCE(to_char(parse_json(t.$1):segmentStartTime),'') || '",' || '"duration":"'|| COALESCE(to_char(parse_json(t.$1):duration),'') || '",' || '"segmentType":"'|| COALESCE(to_char(parse_json(t.$1):segmentType),'') || '",' || '"sessionId":"'|| COALESCE(to_char(parse_json(t.$1):sessionId),'') || '",' || '"subject":"'|| COALESCE(to_char(parse_json(t.$1):subject),'') || '",' || '"wrapUpCode":"' || COALESCE(to_char(parse_json(t.$1):wrapUpCode),'') || '"}' as variant)) as newRecord
						from @`+stageName+`/`+TABLENAME+`/`+filename+` (PATTERN=>'.*.parquet', FILE_FORMAT => myformat2) t 
						) bar `+keyOnSQL+`
						and `+TABLENAME+`.projectid = '`+PROJECTID+`'
						WHEN MATCHED THEN
						 UPDATE SET `+TABLENAME+`.raw = bar.newRecord,`+TABLENAME+`.ingestiondatetime = convert_timezone('UTC','America/New_York',sysdate()),`+TABLENAME+`.ingestiondmloperation = 'UPDATE',`+TABLENAME+`.ingestionsource = '`+filename+`'
						 WHEN NOT MATCHED THEN
						 INSERT
						 (projectid, projectname, programid, programname,raw, ingestiondatetime, ingestiondmloperation, ingestionsource) VALUES
						 ('`+PROJECTID+`','`+PROJECTNAME+`',null,null,bar.newRecord,convert_timezone('UTC','America/New_York',sysdate()), 'INSERT', '`+filename+`');`;

						log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO","SQL: " + sqlCommand); 
	  				
	  					snowflake.execute ({sqlText: sqlCommand});
	            	
	            		attempt = max_attempts + 1;

			  			//update files to ingest table

			  			var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'COMPLETE', status_msg = 'Ingestion completed successfully.', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
						log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
				  
				    	try 
				    	{
				        	snowflake.execute ({sqlText: sqlCommand});          
				        }
				    	catch (err)  
				    	{
				    		log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 
				        	
				        	if (attempt >= max_attempts)
				        	{				        	
				        		return "99";
				       		}
				        }           				       		        		        
	        		}
	    			catch (err)  
	    			{
	        			log(PROJECTID,LOG_CATEGORY, TABLENAME, "FAILED","Failed to ingest file "+filename+" for table "+TABLENAME+": "+ err);

	   	   				//update files to ingest TABLE
	   	   				
		    			var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+err+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
	   				    log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO", sqlCommand);
		  
		    			try 
		    			{
		            		snowflake.execute({sqlText: sqlCommand});
		        		}
		    			catch (err)  
		    			{
		        			log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file "+filename+" for table "+TABLENAME+": "+ err);

		        			if (attempt >= max_attempts)
				        	{
		        		    	return "99";
		        		   	}
		        		}           
	        		     
  				        var error = err.message;
				        
					    if(!error.includes("was aborted because the number of waiters for this lock exceeds"))
					    {
		  					attempt = max_attempts + 1;
					    }
					    
	        		}
  				}
	        		
  			}
  
		}
		
		if (TABLEINGESTTYPE == "truncate_insert" || TABLEINGESTTYPE == "insert")
		{

   			//ingest data from parquet files

			for (const fileinfo of file_array) 
			{
				var info_array = fileinfo.split(";");
				var filename = info_array[0];
				var file_timestamp = info_array[1];

				//update files to ingest TABLE
				
   				var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'IN PROGRESS', status_msg = 'Ingestion is currently running...', ingest_start_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
   				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
  
				try 
				{
					snowflake.execute({sqlText: sqlCommand});
				                  
				}
				catch (err)  
				{
					log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err);
					return "99";
				}

    			//truncate TABLE
    			
   				if (TABLEINGESTTYPE == "truncate_insert") 
   				{
					attempt = 0;
			
					while (attempt <= max_attempts)
					{			
						if (attempt != 0)
						{
					       var sqlCommand = "call SYSTEM$WAIT("+wait_seconds+",'SECONDS');";
					       snowflake.execute ({sqlText: sqlCommand});
						}
					
						attempt++;
   				   				
	    				try 
	    				{
		   					var sqlCommand = "delete from raw."+TABLENAME+" where projectid = '" + PROJECTID + "';";
		   					log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);

	    					snowflake.execute ({sqlText: sqlCommand});
	            		
	            			attempt = max_attempts + 1;
	        			}
	    				catch (err)  
	    				{
	       					log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to truncate table " +TABLENAME+ " for projectid " + PROJECTID + ": "+ err); 
	
	   	  					//update files to ingest TABLE
	   	  					
		   					var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+err+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
	                 	    log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
		  
		    				try 
		    				{
		            			snowflake.execute ({sqlText: sqlCommand});
		                      
		        			}
		    				catch (err)  
		    				{
		        				log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 

		        				if (attempt >= max_attempts)
								{		        				
		        					return "99";
		        				}
		        			}           
	            
	  				        var error = err.message;
					        
						    if(!error.includes("was aborted because the number of waiters for this lock exceeds"))
						    {
			  					attempt = max_attempts + 1;
						    }
	    				}
					}	    				
  				}     

				attempt = 0;
		
				while(attempt <= max_attempts)
				{			
					if (attempt != 0)
					{
				       var sqlCommand = "call SYSTEM$WAIT("+wait_seconds+",'SECONDS');";
				       snowflake.execute ({sqlText: sqlCommand});
					}
				
					attempt++;
  				  				
					try
					{
	
		    			var sqlCommand = "copy into raw." + TABLENAME + " (projectid, projectname, ingestionDateTime, raw) from (select '"+ PROJECTID +"','" + PROJECTNAME + "',convert_timezone('UTC','America/New_York',sysdate()), * from @" + stageName + "/" + TABLENAME + "/) PATTERN='.*"+filename+"' FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;";
		 				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
									
						snowflake.execute ({sqlText: sqlCommand});
					
						attempt = max_attempts + 1;

			  			//update files to ingest table
			   			var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'COMPLETE', status_msg = 'Ingestion completed successfully.', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
	   					log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
			  
			    		try 
			    		{
			            	snowflake.execute ({sqlText: sqlCommand});
			                      
			        	}
			    		catch (err)  
			    		{
			        		log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 

			        		if (attempt >= max_attempts)
							{		        				
			        			return "99";
			        		}
			        	}           
			        	
	        		}
	    			catch (err)  
	    			{
	        			log(PROJECTID,LOG_CATEGORY, TABLENAME, "FAILED","Failed to ingest file "+filename+" for table " + TABLENAME +" : "+ err);
	
	   	   				//update files to ingest table
		    			var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+err+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('"+file_timestamp+"');";
	   				    log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
		  
		    			try 
		    			{
		            		snowflake.execute ({sqlText: sqlCommand});	                      
		        		}
		    			catch (err)  
		    			{
		        			log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " + filename+ "for table " +TABLENAME+ ": "+ err); 

		        			if (attempt >= max_attempts)
							{		        				
		        				return "99";
		        			}
		        		}           
	        		        		        		
  				        var error = err.message;
				        
					    if(!error.includes("was aborted because the number of waiters for this lock exceeds"))
					    {
		  					attempt = max_attempts + 1;
					    }
					    
	        		}

	       		}

			} 

		}
	}
     
	//generate warning if 0 records for any table not listed in unavailable tables table
    var sqlCommand = "select count(*) from raw." + TABLENAME + " rw where rw.projectid = '" + PROJECTID + "';"; 
 
   	try 
   	{
    	stmt = snowflake.createStatement({sqlText: sqlCommand});
       	var result1 = stmt.execute();
        result1.next();
        rowCount = result1.getColumnValue(1); 
  	}
   	catch (err)  
   	{
    	log(PROJECTID, "TABLE ROW COUNT"+REINGEST_SFX, TABLENAME, "FAILED","Failed to count records after ingestion: "+ err);
        return "4";
  	}

  	log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"INFO","rowcount: " + rowCount); 
        
  	if (rowCount < 1) 
  	{
    	log(PROJECTID,"TABLE"+REINGEST_SFX,TABLENAME,"WARNING","Table " + TABLENAME + " has 0 records after ingestion."); 
	} 

  	log(PROJECTID, LOG_CATEGORY, TABLENAME, "SUCCEEDED","Succeeded loading table " + TABLENAME + " for projectid " + PROJECTID);
  	return "0";
  	$$;
  

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE PROCEDURE INGESTUNINGESTEDPIDATA_V2(PROJECTID VARCHAR, REINGESTFLAG BOOLEAN, INGESTALLFLAG BOOLEAN, WAITFORS3FLAG BOOLEAN, RUNFROMBASHFLAG BOOLEAN, afterTimeStr VARCHAR, beforeTimeStr VARCHAR, lookBackDays VARCHAR, tableName VARCHAR)
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

     var setLogTableSQLCommand = sqlCommand;

     snowflake.execute ({sqlText: sqlCommand});
 
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
} 
       

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

function addDays(date, days) {
  var result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
}
     //get date string for today

     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     var todayDateString = yyyy + mm + dd;
  
	 if (AFTERTIMESTR && BEFORETIMESTR)
	 {
		var afterTimeString = AFTERTIMESTR;		
	    var beforeTimeString = BEFORETIMESTR;		  
	 }
	 else
	 {

	 	var lookBackDaysInt = parseInt(LOOKBACKDAYS)*-1;

	 	let startDate = new Date();		 
		startDate = addDays(today, lookBackDaysInt);

		let endDate = new Date();
	 	endDate = addDays(today, 1, 'days');

	 	var sdYear = String(startDate.getFullYear());
	    var sdMonth = String(startDate.getMonth()+1).padStart(2,'0');
	    var sdDayOfMonth = String(startDate.getDate()).padStart(2,'0');

	 	var edYear = String(endDate.getFullYear());
	    var edMonth = String(endDate.getMonth()+1).padStart(2,'0');
	    var edDayOfMonth = String(endDate.getDate()).padStart(2,'0');
	   	   
	 	var afterTimeString = sdYear + "/" + sdMonth + "/" + sdDayOfMonth + " 00:00:00";
	 	var beforeTimeString =  edYear + "/" + edMonth + "/" + edDayOfMonth + " 00:00:00";
	 
	 }
     
	 log(PROJECTID, "DATE", "NA", "SUCCEEDED", "Ingestion running for range " +afterTimeString+" to "+beforeTimeString);
	
REINGEST_SFX = ""
if (REINGESTFLAG){
REINGEST_SFX=" REINGEST";
}     
         
    
 //log start
 if (! RUNFROMBASHFLAG){
     log(PROJECTID, "INGESTION STARTED"+REINGEST_SFX, "NA", "SUCCEEDED","Starting ingestion for PI data");
 }
 
//get project fields 
    var PROJECTNAME = "";
    var AWSFOLDERNAME = "";
    var ingest_wh = "";
    var stageName = "PI_V2_" + PROJECTID;
    var truncateFlag = true;
    var sqlCommand = "select pr.projectname, pr.awsfoldername, pr.ingest_wh from public.D_PI_INGESTION_PROJECTS_VW pr where pr.projectid = '"+PROJECTID+"';";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
     try {
            var result1 = stmt.execute();
            result1.next();
            PROJECTNAME = result1.getColumnValue(1);
            AWSFOLDERNAME = result1.getColumnValue(2);
            ingest_wh = result1.getColumnValue(3);
         }
    catch (err)  {
        log(PROJECTID, "PROJECT INFO"+REINGEST_SFX, "NA", "FAILED","Failed to get project info from project table: " + err);
        return "2";
        }    
   
   //set ingestion warehouse
     var sqlCommand = "USE WAREHOUSE "+ingest_wh +";";
     try {
     snowflake.execute ({sqlText: sqlCommand});
     } 
     catch(err){
      log(PROJECTID, "WAREHOUSE"+REINGEST_SFX, "NA", "FAILED","Failed to set project ingestion warehouse: " + err + sqlCommand);
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

       
    //create stage for DATA today 
    sqlCommand = "call createPIStageV2('" + AWSFOLDERNAME + "','" + stageName + "');";
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "STAGE"+REINGEST_SFX, stageName, "FAILED","Failed to create stage" + stageName + " for " +AWSFOLDERNAME+ + " for "+todayDateString+ ": "+ err); 
        return "3"; 
}
    
  //get list of tables yet to be ingested today

  	if (Math.floor(Math.random() * 11) > 5)
    {
		var sortOrder = "asc";
    }
    else
    {
		var sortOrder = "desc";
    }
  
    var table_array=[];
    if (INGESTALLFLAG){
       sqlCommand = "select ta.table_name,ta.ingest_type, ta.key_string from public.D_PI_INGESTION_PROJECTS_VW pr left outer join public.d_pi_tables ta where pr.projectid = '"+PROJECTID+"' and ta.s3_sourced = true and ta.active = true and (ta.table_name = '"+TABLENAME+"' or '"+TABLENAME+"'='ALL') order by ta.table_name "+sortOrder+";"; 
    } else {
       sqlCommand = "select ta.table_name,ta.ingest_type,ta.key_string from public.D_PI_INGESTION_PROJECTS_VW pr left outer join public.d_pi_tables ta where pr.projectid = '"+PROJECTID+"' and ta.s3_sourced = true and ta.active = true and (ta.table_name = '"+TABLENAME+"' or '"+TABLENAME+"'='ALL') and not exists (select 1 from raw.ingest_pi_data_det_log dl where dl.projectid = pr.projectid and dl.object_category in ('TABLE','TABLE REINGEST') and dl.object_name = ta.table_name and dl.status_string = 'SUCCEEDED' and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())) order by ta.table_name "+sortOrder+";"; 
    }
    
    var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var table_name = rs.getColumnValue(1);
     var table_type = rs.getColumnValue(2);
     var key_string = rs.getColumnValue(3);
     table_array.push(table_name+"|"+table_type+"|"+key_string);
    }
 
 //get list of files to ingest by table
 sqlCommand="call getFilesToIngest ('"+PROJECTID+"',null,'"+TABLENAME+"','"+stageName+"','"+afterTimeString+"','"+beforeTimeString+"',"+REINGESTFLAG+","+RUNFROMBASHFLAG+");"; 
       log(PROJECTID, "SQL2"+REINGEST_SFX, "NA", "SUCCEEDED", sqlCommand);
  try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "FILES"+REINGEST_SFX, "NA", "FAILED","Failed to list files to be ingested" + err); 
        return "5"; 
}
 
  //ingest tables in list
  var rowCount=0;
  var stmt="";
  for (const table_info of table_array) {
  var info_array = table_info.split("|");
  var table_name = info_array[0];
  var tableIngestType = info_array[1];
  var tableKeyString = info_array[2];

    sqlCommand = "call ingestPIData_V2('"+ table_name +"','" + stageName + "','" + AWSFOLDERNAME + "','" + PROJECTID + "','" + PROJECTNAME + "',"+ truncateFlag +"," + REINGESTFLAG + ","+RUNFROMBASHFLAG+",'"+tableIngestType+"','"+tableKeyString+"');";

    try {
            snowflake.execute ({sqlText: sqlCommand});
        }
    catch (err)  {
        log(PROJECTID, "FILES"+REINGEST_SFX, "NA", "FAILED","Failed to execute procedure "+sqlCommand+": "+ err); 
        return "21"; 
	}
  }
      
//call sps
  //get list of sps
    var sp_array=[];

    sqlCommand = "select sp.sp_name,sp.schema_name from public.d_pi_ingestion_sps sp order by sp.sp_name; "; 
    var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();

    while (rs.next()) {
     var sp_name = rs.getColumnValue(1);
     var schema_name = rs.getColumnValue(2)
     sp_array.push(schema_name + "." + sp_name);
    }
  
  //call sps in list
  var rowCount=0;
  var stmt="";
  for (const sp of sp_array) {
/*
     sqlCommand = "call "+ sp + "('"+PROJECTID+"',"+REINGESTFLAG+","+RUNFROMBASHFLAG+");"
     snowflake.execute ({sqlText: sqlCommand});
*/ 
  
	sp_name = sp;
  	var spNamePartArray = sp.split(".");
  
  	if(spNamePartArray[0] != sp)
  	{
  		sp_name = spNamePartArray[spNamePartArray.length - 1];
  	}
  	  
    var spSQL = snowflake.createStatement( { sqlText: `call `+ sp + `(:1,:2,:3)`, binds:[PROJECTID, REINGESTFLAG, RUNFROMBASHFLAG] } );
    var rs = spSQL.execute();

    while (rs.next()) {
     var returnVal = rs.getColumnValue(1);
    }
    
    var returnValUC = returnVal.toUpperCase();
    
    if(returnValUC == "SUCCESS")
    {
        log(PROJECTID, "SP"+REINGEST_SFX, sp_name, "SUCCEEDED","Succeeded executing stored procedure " + sp + " for projectid " + PROJECTID);
    }
    else if (returnValUC == "ERROR")
    {
		log(PROJECTID,"SP"+REINGEST_SFX, sp_name, "FAILED","Failed to execute stored procedure " + sp + " for projectid " + PROJECTID);
    }
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

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE PROCEDURE MergeProjectFileListsForIngestion(reIngestFlag Boolean)
	RETURNS VARCHAR(16777216)
	LANGUAGE JAVASCRIPT
	EXECUTE AS CALLER
	AS 
	$$  

 	//set logging on

 	var sqlCommand = "set do_log = true;";
   	snowflake.execute ({sqlText: sqlCommand});

   	sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";
   	snowflake.execute ({sqlText: sqlCommand});
 
	function log(projectid, object_category, object_name, status_string, msg)
	{
    	snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
	} 
       
	function convertTZ(date, tzString)
	{
    	return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
	}

  	//get date string for today

  	var today_local = new Date();
   	var today = convertTZ(today_local,'America/New_York');
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    var hh = String(today.getHours());
    var todayDateString = yyyy + mm + dd;

	REINGEST_SFX = ""
	if (REINGESTFLAG)
	{
		REINGEST_SFX=" REINGEST";
	}         

	var logTable = "pi_files_to_ingest";

	var project_array=[];
	var sqlCommand = "select projectid from public.D_PI_INGESTION_PROJECTS_VW;"
	var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );

	var rs = createdSQL.execute();

	while (rs.next()) 
	{
     	var projectid = rs.getColumnValue(1);
     	project_array.push(projectid);
    }
  
  	for (const projectid of project_array) 
  	{
		//merge into main file list log table
    	sqlCommand = `MERGE INTO `+ logTable +` USING (select * from `+logTable+`_`+ projectid +` WHERE ingest_end_timestamp IS NOT NULL) s
                      ON 
                      `+ logTable +`.projectid = s.projectid AND 
                      `+ logTable +`.tablename = s.tablename AND 
                      `+ logTable +`.filename = s.filename AND 
                      `+ logTable +`.file_timestamp = s.file_timestamp
                      WHEN MATCHED THEN
                      UPDATE SET 
                      `+ logTable +`.ingest_start_timestamp = s.ingest_start_timestamp,
                      `+ logTable +`.ingest_end_timestamp = s.ingest_end_timestamp,
                      `+ logTable +`.status = s.status,
                      `+ logTable +`.status_msg = s.status_msg,
                      `+ logTable +`.status_timestamp = s.status_timestamp
                      WHEN NOT MATCHED THEN
                      INSERT (projectid, programid, tablename, filename, file_timestamp, ingest_start_timestamp, ingest_end_timestamp, status, status_msg, status_timestamp)
                      VALUES (s.projectid, s.programid, s.tablename, s.filename, s.file_timestamp, s.ingest_start_timestamp, s.ingest_end_timestamp, s.status, s.status_msg, status_timestamp);`;
    
    	try 
    	{
        	snowflake.execute({sqlText: sqlCommand});
        }
    	catch (err)  
    	{
        	log(projectid, "LOG"+REINGEST_SFX, "NA", "FAILED","Failed to insert files to ingest log into main log for project " + projectid +  ": "+ err); 
        	return "3"; 
    	}
    	
    	sqlCommand = `delete from raw.`+logTable+`_`+ projectid +`;`;
    	
    	try 
    	{
        	snowflake.execute({sqlText: sqlCommand});
        }
    	catch (err)  
    	{
        	log(projectid, "LOG"+REINGEST_SFX, "NA", "FAILED","Failed to insert files to ingest log into main log for project " + projectid +  ": "+ err); 
        	return "5"; 
    	}
    	
    	
	 }     
	return "0";
	$$;


use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE createProjectLogsForIngestion(reIngestFlag Boolean)
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

var project_array=[];
var sqlCommand = "select projectid from public.D_PI_INGESTION_PROJECTS_VW;"
var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var projectid = rs.getColumnValue(1);
     project_array.push(projectid);
    }
  
  for (const projectid of project_array) {
//create table log table
    sqlCommand = `create or replace TABLE INGEST_PI_DATA_DET_LOG_`+ projectid +` (
	TS NUMBER(38,0),
	PROJECTID VARCHAR(16777216),
	OBJECT_CATEGORY VARCHAR(16777216),
	OBJECT_NAME VARCHAR(16777216),
	STATUS_STRING VARCHAR(16777216),
	MSG VARCHAR(16777216)
);`;
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(projectid, "LOG"+REINGEST_SFX, "NA", "FAILED","Failed to create log table for project " + projectid +  ": "+ err); 
        return "3"; 
}

}     

    return "0";  
  
  $$;
 
use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE PROCEDURE "MERGEPROJECTLOGSFORINGESTION"("REINGESTFLAG" BOOLEAN, "TEMPLOGTABLE" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
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

var logTable="ingest_pi_data_det_log";
if (TEMPLOGTABLE) {
logTable= TEMPLOGTABLE;
}
var project_array=[];
var sqlCommand = "select projectid from public.D_PI_INGESTION_PROJECTS_VW;"
var createdSQL = snowflake.createStatement( { sqlText: sqlCommand } );
    var rs = createdSQL.execute();
    while (rs.next()) {
     var projectid = rs.getColumnValue(1);
     project_array.push(projectid);
    }
  
  for (const projectid of project_array) {
//mrge into main log table
    sqlCommand = `insert into raw.`+ logTable +` select * from raw.INGEST_PI_DATA_DET_LOG_`+ projectid +`;`;
    
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(projectid, "LOG"+REINGEST_SFX, "NA", "FAILED","Failed to insert project log into main log for project " + projectid +  ": "+ err); 
        return "3"; 
}

}     
return "0";
$$;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace view D_PI_EVALUATION_CALIBRATIONS_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME,
	AGENTCOMMENTS,
	AGENTHASREAD,
	AGENTID,
	AGENTNAME,
	ANSWERID,
	ANSWERTEXT,
	ANSWERVALUE,
	ANYFAILEDKILLQUESTIONS,
	ASSIGNEDDATETIME,
	ASSIGNEDDATE,
	PROJECTASSIGNEDDATETIME,
	PROJECTASSIGNEDDATE,
	CALIBRATIONID,
	CHANGEDDATETIME,
	CHANGEDDATE,
	PROJECTCHANGEDDATETIME,
	PROJECTCHANGEDDATE,
	CONVERSATIONID,
	CONVERSATIONSTARTTIME,
	CONVERSATIONSTARTDATE,
	PROJECTCONVERSATIONSTARTTIME,
	PROJECTCONVERSATIONSTARTDATE,
	EVALUATIONCOMMENTS,
	EVALUATIONFORMNAME,
	EVALUATIONID,
	EVALUATIONFORMID,
	EVALUATIONFORMCONTEXTID,
	EVALUATIONFORMLASTMODIFIED,
	ISPUBLISHED,
	EVALUATORID,
	EVALUATORNAME,
	FAILEDKILLQUESTION,
	MARKEDNA,
	MAXQUESTIONSCORE,
	MAXQUESTIONSCOREWEIGHTED,
	MAXGROUPTOTALCRITICALSCORE,
	MAXGROUPTOTALCRITICALSCOREUNWEIGHTED,
	MAXGROUPTOTALSCORE,
	MAXGROUPTOTALSCOREUNWEIGHTED,
	NEVERRELEASE,
	QUESTIONGROUPMARKEDNA,
	QUESTIONGROUPNAME,
	QUESTIONGROUPWEIGHT,
	QUESTIONSCORECOMMENT,
	QUESTIONTEXT,
	QUESTIONGROUPID,
	QUESTIONID,
	QUESTIONSCORE,
	QUESTIONSCOREWEIGHTED,
	QUEUENAME,
	RELEASEDATETIME,
	RELEASEDATE,
	PROJECTRELEASEDATETIME,
	PROJECTRELEASEDATE,
	STATUS,
	TOTALEVALUATIONCRITICALSCORE,
	TOTALEVALUATIONSCORE,
	TOTALGROUPCRITICALSCORE,
	TOTALGROUPCRITICALSCOREUNWEIGHTED,
	QUESTIONISCRITICAL,
	QUESTIONISKILL,
	WEIGHTMODE,
	CALIBRATIONCREATEDDATETIME,
	PROJECTCALIBRATIONCREATEDDATETIME,
	CALIBRATIONCREATEDDATE,
	PROJECTCALIBRATIONCREATEDDATE,
	AVERAGESCORE,
	HIGHSCORE,
	LOWSCORE,
	CALIBRATORNAME,
	EVALUATION_FORM_DISPLAY_NAME,
	QUESTION_DISPLAY_NAME,
	QUESTION_SORT_ORDER,
	QUESTION_GROUP_DISPLAY_NAME,
	QUESTIONHELPTEXT,
	QUESTION_GROUP_SORT_ORDER,
	QUESTIONGROUPDEFAULTANSWERSTOHIGHEST,
	QUESTIONGROUPDEFAULTANSWERSTONA,
	QUESTIONGROUPMANUALWEIGHT,
	QUESTIONGROUPNAENABLED,
	QUESTIONGROUPTYPE,
	QUESTIONCOMMENTSREQUIRED,
	QUESTIONNAENABLED,
	QUESTIONTYPE
) COPY GRANTS as
  WITH
 a AS (SELECT cob.RAW:id AS agentId , cob.RAW:name AS agentName, cob.projectid as projectid FROM raw.configuration_objects cob  WHERE cob.RAW:type = 'user'),
 c AS (SELECT cob3.RAW:id AS calibratorId , cob3.RAW:name AS calibratorName, cob3.projectid as projectid FROM raw.configuration_objects cob3  WHERE cob3.RAW:type = 'user'),
 e AS (SELECT cob2.RAW:id AS evaluatorId , cob2.RAW:name AS evaluatorName, cob2.projectid as projectid FROM raw.configuration_objects cob2 WHERE cob2.RAW:type = 'user'),
 q AS (SELECT  projectid, RAW:id AS queueId , RAW:name AS queueName FROM raw.configuration_objects  WHERE RAW:type = 'queue'),
 conversations AS (SELECT co.RAW:userId as aId, co.RAW:conversationId as cid, co.RAW:organizationid as orgid, 
                  co.RAW:queueId as queueId, co.projectid, min(co.RAW:conversationStartTime) as conversationStartTime from raw.conversations_detail co group by 1,2, 3,4,5),
 forms as (select projectid,
                  RAW:id as evaluationFormId, RAW:questionID as questionId, RAW:questionGroupId as questionGroupId, RAW:questionGroupManualWeight as questionGroupManualWeight,
                  RAW:questionGroupNaEnabled as questionGroupNaEnabled, RAW:questionGroupType as questionGroupType, RAW:questionCommentsRequired as questionCommentsRequired,
                  RAW:questionNaEnabled as questionNaEnabled, RAW:questionType as questionType, RAW:contextId as contextId, RAW:modifiedDate as modifiedDate,
                  RAW:published as published, RAW:questionHelpText as questionHelpText, min(RAW:questionGroupName) as questiongroupname,
                  min(RAW:questionText) as questiontext, min(RAW:questionGroupWeight) as questiongroupweight, min(RAW:name) AS evaluationFormName,
                  min(RAW:weightMode) as weightMode, min(RAW:questionIsKill) as questionIsKill, min(RAW:questionIsCritical) as questionIsCritical,
                  min(RAW:questionGroupDefaultAnswersToHighest) as questionGroupDefaultAnswersToHighest, min(RAW:questionGroupDefaultAnswersToNA) as questionGroupDefaultAnswersToNA,
                  max(RAW:answerValue) as maxQuestionScore
              FROM RAW.evaluation_forms
              group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14)
select
  ev.projectId as projectId,
  ev.projectName as projectName,
  ev.programId as programId,
  ev.programName as programName,
  trim(cast (ev.RAW:answersAgentComments as VARCHAR(4000))) as agentComments,
  cast (ev.RAW:agentHasRead as BOOLEAN) as agentHasRead,
  trim(cast (ev.RAW:agentId as VARCHAR(255))) as agentId,
  trim(cast (a.agentName as VARCHAR(255))) as agentName,
  trim(cast (ef.RAW:answerId as VARCHAR(255))) as answerId,
--cast (ev.RAW:questionAnswerID as VARCHAR(255)) as answerID,
  trim(cast (ef.RAW:answerText as VARCHAR(4000))) as answerText,
  cast (ef.RAW:answerValue as INT) as answerValue,
  cast (ev.RAW:answersAnyFailedKillQuestions as BOOLEAN) as anyFailedKillQuestions,    
  cast (ev.RAW:assignedDate as DATETIME) as assignedDateTime,
  to_date(cast (ev.RAW:assignedDate as DATETIME)) as assignedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME)) as projectAssignedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME))) as projectAssignedDate,
  trim(cast (ev.RAW:calibrationId as VARCHAR(255))) as calibrationId,
  cast (ev.RAW:changedDate as DATETIME) as changedDateTime,
  to_date(cast (ev.RAW:changedDate as DATETIME)) as changedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME)) as projectChangedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME))) as projectChangedDate,
  trim(cast (ev.RAW:conversationId as VARCHAR(255))) as conversationId,
  cast (conversations.conversationStartTime as DATETIME) as conversationStartTime,
  to_date(cast (conversations.conversationStartTime as DATETIME)) as conversationStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME))) as projectConversationStartDate,
  trim(cast (ev.RAW:answersComments as VARCHAR(4000))) as evaluationComments,
  trim(cast (replace (replace(replace(ef2.evaluationFormName,'\t',' '),'\r',' '),'\n',' ') as VARCHAR(255))) as evaluationFormName,     
  trim(cast (ev.RAW:id as VARCHAR(255))) as evaluationId,        
  trim(cast (ev.RAW:evaluationFormId as VARCHAR(255))) as evaluationFormId,      
  trim(cast (ef2.contextId as VARCHAR(255))) as evaluationFormContextId,    
  cast (ef2.modifiedDate as DATETIME) as evaluationFormLastModified,     
  cast (ef2.published as BOOLEAN) as isPublished,                        
  trim(cast (ev.RAW:EvaluatorId as VARCHAR(255))) as EvaluatorId,
  trim(cast (e.evaluatorName as VARCHAR(255))) as evaluatorName,
  cast (ev.RAW:questionFailedKillQuestion as BOOLEAN) as failedKillQuestion,
  cast (ev.RAW:questionMarkedNA as BOOLEAN) as markedNA,
  cast (to_double(ef2.maxQuestionScore) as DECIMAL(38,19)) as maxQuestionScore,
  Case when weightmode ='OFF' then  to_double(ef2.maxquestionscore)/100.0 else (to_double(ef2.maxquestionscore)*(to_double(ef2.questionGroupWeight)/100.0)) end as maxquestionscoreweighted,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScore) as DECIMAL(38,19)) as maxgrouptotalcriticalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalcriticalscoreunweighted,        
  cast (to_double(ev.RAW:questionGroupMaxTotalScore) as DECIMAL(38,19)) as maxgrouptotalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalscoreunweighted,        
  cast (ev.RAW:neverRelease as BOOLEAN) as neverRelease,
  cast (ev.RAW:questionGroupMarkedNA as BOOLEAN) as questionGroupMarkedNA,
  trim(cast (replace (replace(replace(ef2.questionGroupName,'\t',' '),'\r',' '),'\n',' ') as VARCHAR(255))) as questionGroupName,
  cast (to_double(ef2.questionGroupWeight) as DECIMAL(38,19)) as questionGroupWeight, 
  trim(cast (ev.RAW:questionComments as VARCHAR(4000))) as questionScoreComment,
  trim(replace (replace(replace(ef2.questionText,'\t',' '),'\r',' '),'\n',' ')) as questionText,
  trim(cast (ef2.questionGroupID as VARCHAR(255))) as questionGroupId,
  trim(cast (ev.RAW:questionId as VARCHAR(255))) as questionId,
  cast (ev.RAW:questionScore as INT) as questionScore,
  Case when weightmode ='OFF' then to_double(ev.RAW:questionScore)/100.0 else (to_double(ev.RAW:questionScore)*(to_double(ef2.questionGroupWeight)/100.0)) end as questionscoreweighted,
  trim(cast (q.queueName as VARCHAR(255))) as queueName,        
  cast (ev.RAW:releaseDate as DATETIME) as releaseDateTime,
  to_date(cast (ev.RAW:releaseDate as DATETIME)) as releaseDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME)) as projectReleaseDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME))) as projectReleaseDate,
  trim(cast (ev.RAW:status as VARCHAR(255))) as status,
  cast (to_double(ev.RAW:answersTotalCriticalScore) as DECIMAL(38,19)) as totalEvaluationCriticalScore,  
  cast (to_double(ev.RAW:answersTotalScore) as DECIMAL(38,19)) as totalEvaluationScore,     
  cast (to_double(ev.RAW:questionGroupTotalCriticalScore) as DECIMAL(38,19)) as totalgroupcriticalscore,
  cast (to_double(ev.RAW:questionGroupTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as totalgroupcriticalscoreunweighted,
  cast (ef2.questionIsCritical as BOOLEAN) as questionisCritical,
  cast (ef2.questionIsKill as BOOLEAN) as questionisKill,
  trim(cast (ef2.weightMode as VARCHAR(255))) as weightMode,
  cast (ec.RAW:createdDate as DATETIME) as calibrationCreatedDateTime,
  convert_timezone('UTC',pr.projectTimezone,cast (ec.RAW:createdDate as DATETIME)) as projectCalibrationCreatedDateTime,
  to_date(cast (ec.RAW:createdDate as DATETIME)) as calibrationCreatedDate,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ec.RAW:createdDate as DATETIME))) as projectCalibrationCreatedDate,
  cast (ec.RAW:averageScore as INT) as averageScore,
  cast (ec.RAW:highScore as INT) as highScore,
  cast (ec.RAW:lowScore as INT) as lowScore,
  trim(cast (c.calibratorName as VARCHAR(255))) as calibratorName,
  trim(eqi.EVALUATION_FORM_DISPLAY_NAME) as evaluation_form_display_name,
  trim(eqi.QUESTION_DISPLAY_NAME) as question_display_name,
  eqi.QUESTION_SORT_ORDER,
  trim(eqi.QUESTION_GROUP_DISPLAY_NAME) as question_group_display_name,      
  trim(ef2.questionHelpText) as questionHelpText, 	
  eqi.QUESTION_GROUP_SORT_ORDER,
  cast (ef2.questionGroupDefaultAnswersToHighest as boolean) as questionGroupDefaultAnswersToHighest,
  cast (ef2.questionGroupDefaultAnswersToNA as boolean) as questionGroupDefaultAnswersToNA,
  cast (ef2.questionGroupManualWeight as decimal(38,19)) as questionGroupManualWeight,
  cast (ef2.questionGroupNaEnabled as boolean) as questionGroupNaEnabled,  
  trim( cast (ef2.questionGroupType as varchar)) as questionGroupType,
  cast (ef2.questionCommentsRequired as boolean) as questionCommentsRequired,
  cast (ef2.questionNaEnabled as boolean) as questionNaEnabled,
  trim( cast(ef2.questionType as varchar)) as questionType
  --below not in DD 
  --cast (RAW:questionGroupTotalScore as DECIMAL(38,38)) as questionGroupTotalScore,
  --cast (RAW:questionGroupTotalScoreUnweighted as DECIMAL(38,38)) as questionGroupTotalScoreUnweighted,
  from RAW.EVALUATIONS ev
  inner join PUBLIC.D_PI_PROJECTS pr
  on ev.projectId = pr.projectId
  LEFT OUTER JOIN RAW.EVALUATION_FORMS ef 
  ON ev.RAW:evaluationFormId = ef.RAW:id
  and ev.RAW:questionAnswerID = ef.RAW:answerId
  and ev.projectid = ef.projectid
  LEFT OUTER JOIN forms ef2 
  ON ev.RAW:evaluationFormId = ef2.evaluationFormId
  and ev.RAW:questionId = ef2.questionId
  and ev.projectid = ef2.projectid
  INNER JOIN conversations conversations
  ON ev.RAW:conversationId = conversations.cid 
  and ev.RAW:agentId = conversations.aId
  and ev.projectid = conversations.projectid
  --and ev.RAW:organizationid = conversations.orgid
  LEFT JOIN RAW.EVALUATION_CALIBRATIONS ec
  ON ev.RAW:calibrationId = ec.RAW:id 
  and ev.RAW:conversationId = ec.RAW:conversationId 
  LEFT OUTER JOIN a a ON ev.RAW:agentId = a.agentid and ev.projectid = a.projectid
  LEFT OUTER JOIN c c ON ec.RAW:calibratorId = c.calibratorid and ev.projectid = c.projectid
LEFT OUTER JOIN e e ON ev.RAW:EvaluatorId = e.evaluatorId and ev.projectid = e.projectid
LEFT OUTER JOIN q q ON conversations.queueId = q.queueId and ev.projectid = q.projectid
LEFT OUTER JOIN d_evaluations_questions_info eqi ON ev.projectid = eqi.projectid and ev.RAW:questionId = eqi.question_id
where ev.RAW:calibrationId != '' and ev.RAW:calibrationId is not NULL;


USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE TABLE WFM_PLANNING_GROUP_AGENTS CLONE DIALER_DETAIL;
TRUNCATE TABLE WFM_PLANNING_GROUP_AGENTS;

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_AGENTS TO ROLE GEN_DP4BI_PRD;
GRANT SELECT, REFERENCES ON TABLE WFM_PLANNING_GROUP_AGENTS TO ROLE KYVOS_DP4BI_PRD_READ;
GRANT SELECT, REFERENCES ON TABLE WFM_PLANNING_GROUP_AGENTS TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_AGENTS TO ROLE PUREINSIGHTS_PRD_POC;
GRANT SELECT, REFERENCES ON TABLE WFM_PLANNING_GROUP_AGENTS TO ROLE PUREINSIGHTS_PRD_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_AGENTS TO ROLE PUREINSIGHTS_GEN_DP4BI_PRD;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_AGENTS TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;


USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE TABLE WFM_PLANNING_GROUP_CONFIGURATION CLONE DIALER_DETAIL;
TRUNCATE TABLE WFM_PLANNING_GROUP_CONFIGURATION;

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_CONFIGURATION TO ROLE GEN_DP4BI_PRD;
GRANT SELECT, REFERENCES ON TABLE WFM_PLANNING_GROUP_CONFIGURATION TO ROLE KYVOS_DP4BI_PRD_READ;
GRANT SELECT, REFERENCES ON TABLE WFM_PLANNING_GROUP_CONFIGURATION TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_CONFIGURATION TO ROLE PUREINSIGHTS_PRD_POC;
GRANT SELECT, REFERENCES ON TABLE WFM_PLANNING_GROUP_CONFIGURATION TO ROLE PUREINSIGHTS_PRD_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_CONFIGURATION TO ROLE PUREINSIGHTS_GEN_DP4BI_PRD;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WFM_PLANNING_GROUP_CONFIGURATION TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace view F_PI_WFM_PLANNING_GROUP_AGENTS_VW COPY GRANTS
(
	PROJECTNAME,
	PROJECTID,
	PROGRAMNAME,
	PROGRAMID,
	USERID,
	USERNAME,
	PLANNINGGROUPID,
	PLANNINGGROUPNAME,
	BUSINESSUNITID,
	BUSINESSUNITNAME
) as
WITH
    u AS (SELECT CAST(raw:id AS VARCHAR) AS id , CAST(raw:name AS VARCHAR) AS userName FROM RAW.configuration_objects  WHERE raw:type = 'user'),
    pgc AS (SELECT CAST(raw:id AS VARCHAR) AS id, CAST(raw:name AS VARCHAR) AS planningGroupName, CAST(raw:businessUnitId AS VARCHAR) AS businessUnitId FROM RAW.wfm_planning_group_configuration),
    bu AS (SELECT CAST(raw:id AS VARCHAR) AS id, CAST(raw:name AS VARCHAR) AS businessUnitName FROM RAW.configuration_objects  WHERE raw:type = 'businessunit')
SELECT
	pr.projectName							AS projectName,
	pr.projectId							AS projectId,
	pga.programName							AS programName,
	pga.programId							AS programId,
	CAST(pga.raw:userId AS VARCHAR)			AS userId,
   	u.userName,
   	CAST(pga.raw:planningGroupId AS VARCHAR)	AS planningGroupId,
   	pgc.planningGroupName,
   	pgc.businessUnitId,
   	bu.businessUnitName
FROM 
	RAW.wfm_planning_group_agents		pga
LEFT OUTER JOIN u ON pga.raw:userId = u.id 
LEFT OUTER JOIN pgc ON pga.raw:planningGroupId = pgc.id 
LEFT OUTER JOIN bu ON bu.id = pgc.businessUnitId
INNER JOIN D_PI_PROJECTS pr ON pga.projectId = pr.projectId;

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE AddNewPIProject_V2(projectid VARCHAR, projectname VARCHAR, AWSFOLDERNAME VARCHAR, PROJECTTIMEZONE VARCHAR,ACTIVE BOOLEAN,INGEST_WH VARCHAR, PROJECTCHARGECODE VARCHAR, PROJECTCHARGECODENAME VARCHAR)
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

  //add to projects table
  var sqlCommand = "call insertPIProject('" + PROJECTID +"','" + PROJECTNAME + "','" + AWSFOLDERNAME +  "','"+PROJECTTIMEZONE+ "'," + ACTIVE + ",'"+INGEST_WH+"','"+PROJECTCHARGECODE+"','"+PROJECTCHARGECODENAME+"');";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed configure projects table for projectid " + PROJECTID + ": "+ err); 
        return "1";
        }     
  
  //add to unavailable tables table
  sqlCommand = "call configurePIUnavailableTables('" + PROJECTID + "');";
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to configure unavailable tables table for projectid " + PROJECTID + ": "+ err); 
        return "1";
        }     
  
  //test if this project has been ingested today already
  var ingestCount=0;
  sqlCommand = "select count(*) from raw.ingest_pi_data_det_log dl where dl.projectid = '" + PROJECTID + "' and to_date(convert_timezone('America/New_York',to_timestamp_ltz(to_varchar(dl.ts)))) = to_date(convert_timezone('America/New_York',current_timestamp()))";
    var stmt = snowflake.createStatement({sqlText: sqlCommand});    
  try {
            var result1 = stmt.execute();
            result1.next();
            ingestCount = result1.getColumnValue(1); 
         }
    catch (err)  {
        log("Failed to count previous ingestions for projectid " + PROJECTID + ": "+ err);
        return "1";
        }
  
  
  
  
  
  //run initial ingestion or reingestion
  if (ingestCount == 0){
       sqlCommand = "call ingestUningestedPIData_V2('"+PROJECTID+"',false,false,false,false,'1970/01/01 00:00:00','2080/12/31 00:00:00','0','ALL');";
  } else {
       sqlCommand = "call ingestUningestedPIData_V2('"+PROJECTID+"',true,false,false,false,'1970/01/01 00:00:00','2080/12/31 00:00:00','0','ALL');";
}
try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log("Failed to run initial ingestion for projectid " + PROJECTID + ": "+ err); 
        return "1";
        }     
  
  return "0";
  
  $$;

use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE or replace PROCEDURE execFileIngestionSQLCommand(projectid varchar, programName varchar, tableName varchar, fileName varchar, fileTimeStamp varchar, sqlCommandToExecute varchar, setStatus Boolean, reIngestFlag Boolean, runFromBashFlag Boolean)
	RETURNS VARCHAR
  	LANGUAGE javascript
  	EXECUTE AS CALLER
  	AS
  	$$
  
	//set logging on

	var LOG_CATEGORY="TABLE";
	if (REINGESTFLAG)
	{
		LOG_CATEGORY="TABLE REINGEST";
	}
		
	var sqlCommand = "set do_log = true;";
   	snowflake.execute({sqlText: sqlCommand});

     	var pi_files_to_ingest_table = "PI_FILES_TO_INGEST";
	sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG';";

	if (RUNFROMBASHFLAG) 
	{
    	 sqlCommand = "set log_table = 'INGEST_PI_DATA_DET_LOG_"+PROJECTID+"';";
         pi_files_to_ingest_table = "PI_FILES_TO_INGEST_"+PROJECTID;
   	}
    snowflake.execute({sqlText: sqlCommand});
 
	function log(projectid, object_category, object_name, status_string, msg)
	{
    	snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
	}        

	function convertTZ(date, tzString) 
	{
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
   
  	var attempt = 0;
  	var max_attempts = 3000;
  	var	wait_seconds = 1;
   
	REINGEST_SFX = ""

	if (REINGESTFLAG)
	{
		REINGEST_SFX=" REINGEST";
	}         

	attempt = 0;
			
	while(attempt <= max_attempts)
	{			
		if (attempt != 0)
		{
	       var sqlCommand = "call SYSTEM$WAIT("+wait_seconds+",'SECONDS');";
	       snowflake.execute ({sqlText: sqlCommand});
		}

		attempt++;
	
		sqlCommand = SQLCOMMANDTOEXECUTE;
		log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO", "SQL:  "+sqlCommand); 	
	
	    try 
	    {
	    	snowflake.execute ({sqlText: sqlCommand});
	  		attempt = max_attempts + 1;
		    log(PROJECTID, LOG_CATEGORY, TABLENAME, "SUCCEEDED", "SQL:  "+sqlCommand);	  	

	    	if (SETSTATUS)
	    	{	    
		   		if (FILENAME != "NA")
	    		{
		   			var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'COMPLETE', status_msg = 'Ingestion completed successfully.', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where projectid = '"+PROJECTID+"' and tablename = '" + TABLENAME + "' and filename = '"+FILENAME+"' and file_timestamp = to_timestamp('" + FILETIMESTAMP + "');";
				}
				else
				{
					var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'COMPLETE', status_msg = 'Ingestion completed successfully.', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where projectid = '"+PROJECTID+"' and tablename = '" + TABLENAME + "';";
				}

				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
			
		    	try 
		    	{
			    	
		    		snowflake.execute ({sqlText: sqlCommand});
		                      
		        }
		    	catch (err)  
		    	{
		        	log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " +FILENAME+ "for table " +TABLENAME+ ": "+ err); 
		        	return "99";				        
		        }           
			
			}
	    
	   	}
	    catch (err)  
	    {
			var error = err.message;
	        error = error.replace("'", " ");
	       
		    if(error.includes("was aborted because the number of waiters for this lock exceeds"))
		    {
				error = "Transaction was aborted because the number of waiters for this lock exceeds the maximum";
		    }
			else
		    {
		        log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "SQL:  "+sqlCommand+" - "+ err);
		    	attempt = max_attempts + 1;
		    }
		    		    
			if (SETSTATUS)
			{
			    if (FILENAME != "NA")
			    {
					var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+error+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+FILENAME+"' and file_timestamp = to_timestamp('" + FILETIMESTAMP + "');";
				}
				else
				{
					var sqlCommand = "update raw."+pi_files_to_ingest_table+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+error+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "';";
				}
				
				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
	
				try 
		    	{
			    	
		    		snowflake.execute ({sqlText: sqlCommand});
		                      
		        }
		    	catch (err)  
		    	{
		        	log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to update files_to_ingest table for file " +FILENAME+ "for table " +TABLENAME+ ": "+ err); 
		        	return "99";				        
		        }           
			}

			if (attempt >= max_attempts)
			{
				return "88";
			}
					        
		}
			    	   
	}

    return "0";
  	$$; 


use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

GRANT USAGE ON PROCEDURE DECISIONPOINT_PRD.STAGE.LOAD_PI_USER_HISTORY_PROC(VARCHAR, BOOLEAN, BOOLEAN) TO ROLE PI_DATA_INGEST_PRD_ALERT_USER WITH GRANT OPTION;

GRANT OWNERSHIP ON PROCEDURE STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD(VARCHAR, BOOLEAN, BOOLEAN) TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, INSERT, UPDATE, DELETE ON STAGE.S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT ON VIEW PUBLIC.D_PROJECT_DATES_SV TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT ON VIEW PUBLIC.D_PI_EVALUATIONS_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;

DELETE FROM 
	PUBLIC.D_PI_INGESTION_SPS 
WHERE 	
	sp_name = 'LOAD_PI_USER_HISTORY_PROC'
AND	schema_name = 'DECISIONPOINT_PRD.STAGE';

INSERT INTO
	PUBLIC.D_PI_INGESTION_SPS	
	(
		sp_name,
		schema_name,
		active,
		update_timestamp
	)
VALUES
	(	'LOAD_PI_USER_HISTORY_PROC',	
		'DECISIONPOINT_PRD.STAGE',
		TRUE,
		current_timestamp()
	);

DELETE FROM 
	PUBLIC.D_PI_INGESTION_SPS 
WHERE 	
	sp_name = 'S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD'
AND	schema_name = 'STAGE';

INSERT INTO
	PUBLIC.D_PI_INGESTION_SPS	
	(
		sp_name,
		schema_name,
		active,
		update_timestamp
	)
VALUES
	(	'S_PI_QUEUE_MONITORING_PENDING_EVALUATIONS_LOAD',	
		'STAGE',
		TRUE,
		current_timestamp()
	);

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

create or replace view F_PI_SURVEY_VERIFICATION_VW(
	PROJECTID,
	PROJECTNAME,
	SURVEYNAME,
	CONVERSATIONID,
	PARTICIPANTSTARTDATE,
	PROJECTPARTICIPANTSTARTDATE,
	VALUE
) COPY GRANTS as 
select distinct al.PROJECTID,
al.PROJECTNAME,
al.SURVEYNAME,
al.conversationid,
al.participantStartDate,
al.projectParticipantStartDate,
al.value
from
((with ca3 as (select distinct
projectId,
projectName,
programId,
programName,
conversationid,
key as SURVEYNAME,
Substr(right(key,6),1,3) as LANGUAGE,
value,
case when len(value) = 4 then left(value, 2)
when (len(value) = 5  and substr(value,3,1) = 'A') then left(value, 2)
when (len(value) = 5  and substr(value,4,1) = 'A') then left(value, 3)
when len(value) = 8 then left(value, 2)
when len(value) = 9 then left(value, 2)
when len(value) = 10 then left(value, 3)
when len(value) = 12 then left(value, 2)
when len(value) = 13 then left(value, 2)
else null end as QUESTIONNR,
case when len(value) = 4 then right(value, 2)
when (len(value) = 5 and substr(value,3,1) = 'A') then right(value, 3)
when (len(value) = 5 and substr(value,4,1) = 'A') then right(value, 2)
when len(value) = 8 then substr(value,3,2)
when (len(value) = 9  and substr(value,6,1) = '_') then substr(value,4,2)
when (len(value) = 9  and substr(value,6,1) != '_') then substr(value,3,2)
when len(value) = 12 then substr(value,3,2)
when len(value) = 13 then substr(value,3,2)
else '' end as ANSWERNR,
participantEndTime,
participantEndDate,
projectParticipantEndTime,
projectParticipantEndDate,
participantid,
participantName,
participantStartTime,
participantStartDate,
projectParticipantStartTime,
projectParticipantStartDate,
purpose,
userId
from
(select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (to_char(rp.RAW:participantEndTime) as DATETIME) as participantEndTime,
  cast (to_char(rp.RAW:participantEndTime) as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rp.RAW:participantName as VARCHAR(255)) as participantName,
  cast (to_char(rp.RAW:participantStartTime) as DATETIME) as participantStartTime,
  cast (to_char(rp.RAW:participantStartTime) as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME))) as projectParticipantStartDate,
  cast (rp.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rp.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as col
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left join RAW.participants rp
  on rt.projectid = rp.projectid
  and rt.RAW:participantId =rp.RAW:participantId
 --where participantstartdate between add_months(last_day(current_date())+1, -1) and current_date() - 1
  where key like ('%CSAT%') or key like ('CoverVA%')
),  lateral split_to_table(COL, '||')
where VALUE <> '')
  select ca3.PROJECTID,
ca3.PROJECTNAME,
ca3.SURVEYNAME,
ca3.QUESTIONNR,
ca3.ANSWERNR,
si.SURVEYNAME as config_surveyname,
si.QUESTIONNR as config_questionnr,
si.ANSWERNR as config_answernr,
 ca3.conversationid,
ca3.participantStartDate,
ca3.projectParticipantStartDate,
cast(ca3.value as varchar) as value
from CA3 
LEFT OUTER JOIN PUBLIC.D_CSAT_QUESTIONS_INFO SI
on ca3.projectID = si.projectId
and ca3.SURVEYNAME = si.SURVEYNAME
and ((ca3.QUESTIONNR = si.QUESTIONNR
and ca3.ANSWERNR = si.ANSWERNR) or
     (ca3.value = si.questanscombo))

)
UNION ALL
(with ca2 as (select distinct
projectId,
projectName,
programId,
programName,
conversationid,
key as SURVEYNAME,
Substr(right(key,6),1,3) as LANGUAGE,
value,
case when len(value) = 8 then left(value, 4)
when (len(value) = 9 and substr(value,6,1) = '_') then left(value, 5)
when (len(value) = 9 and substr(value,6,1) != '_') then left(value, 4)
when len(value) = 12 then left(value, 4)
when (len(value) = 13 and substr(value,6,1) != '_') then left(value,4)
when (len(value) = 13 and substr(value,6,1) = '_') then left(value,5)
else null end as QUESTIONNR,
case when len(value) = 8 then right(value, 3)
when (len(value) = 9 and substr(value,6,1) = '_') then right(value, 3)
when (len(value) = 9 and substr(value,6,1) != '_') then right(value, 4)
when len(value) = 12 then substr(value,6,3)
when (len(value) = 13 and substr(value,6,1) != '_') then substr(value,6,3)
when (len(value) = 13 and substr(value,6,1) = '_') then substr(value,7,3)
else '' end as ANSWERNR,
participantEndTime,
participantEndDate,
projectParticipantEndTime,
projectParticipantEndDate,
participantid,
participantName,
participantStartTime,
participantStartDate,
projectParticipantStartTime,
projectParticipantStartDate,
purpose,
userId
from
(select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (to_char(rp.RAW:participantEndTime) as DATETIME) as participantEndTime,
  cast (to_char(rp.RAW:participantEndTime) as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rp.RAW:participantName as VARCHAR(255)) as participantName,
  cast (to_char(rp.RAW:participantStartTime) as DATETIME) as participantStartTime,
  cast (to_char(rp.RAW:participantStartTime) as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME))) as projectParticipantStartDate,
  cast (rp.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rp.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as col
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left join RAW.participants rp
  on rt.projectid = rp.projectid
  and rt.RAW:participantId =rp.RAW:participantId
--where participantstartdate between add_months(last_day(current_date())+1, -1) and current_date() - 1
  where key like ('%CSAT%') or key like ('CoverVA%')
),  lateral split_to_table(COL, '||')
where VALUE <> '')
 select ca2.PROJECTID,
ca2.PROJECTNAME,
ca2.SURVEYNAME,
ca2.QUESTIONNR,
ca2.ANSWERNR,
si.SURVEYNAME as config_surveyname,
si.QUESTIONNR as config_questionnr,
si.ANSWERNR as config_answernr,
 ca2.conversationid,
ca2.participantStartDate,
ca2.projectParticipantStartDate,
cast(ca2.value as varchar) as value
from CA2 
LEFT OUTER JOIN PUBLIC.D_CSAT_QUESTIONS_INFO SI
on ca2.projectID = si.projectId
and ca2.SURVEYNAME = si.SURVEYNAME
and ((ca2.QUESTIONNR = si.QUESTIONNR
and ca2.ANSWERNR = si.ANSWERNR) or
     (ca2.value = si.questanscombo))

)
UNION ALL
(with ca as (select distinct
projectId,
projectName,
programId,
programName,
conversationid,
key as SURVEYNAME,
Substr(right(key,6),1,3) as LANGUAGE,
value,
case when len(value) = 12 then left(value, 8)
when (len(value) = 13 and substr(value,5,1) = '_') then left(value,8)
when (len(value) = 13 and substr(value,6,1) = '_') then left(value,9)
else null end as QUESTIONNR,
case when len(value) = 12 then right(value,3)
when (len(value) = 13 and substr(value,5,1) = '_') then right(value,4)
when (len(value) = 13 and substr(value,6,1) = '_') then right(value,3)
else '' end as ANSWERNR,
participantEndTime,
participantEndDate,
projectParticipantEndTime,
projectParticipantEndDate,
participantid,
participantName,
participantStartTime,
participantStartDate,
projectParticipantStartTime,
projectParticipantStartDate,
purpose,
userId
from
(select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (to_char(rp.RAW:participantEndTime) as DATETIME) as participantEndTime,
  cast (to_char(rp.RAW:participantEndTime) as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rp.RAW:participantName as VARCHAR(255)) as participantName,
  cast (to_char(rp.RAW:participantStartTime) as DATETIME) as participantStartTime,
  cast (to_char(rp.RAW:participantStartTime) as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME))) as projectParticipantStartDate,
  cast (rp.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rp.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as col
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left join RAW.participants rp
  on rt.projectid = rp.projectid
  and rt.RAW:participantId =rp.RAW:participantId
--where participantstartdate between add_months(last_day(current_date())+1, -1) and current_date() - 1
  where key like ('%CSAT%') or key like ('CoverVA%')
),  lateral split_to_table(COL, '||')
where VALUE <> '')
 select ca.PROJECTID,
ca.PROJECTNAME,
ca.SURVEYNAME,
ca.QUESTIONNR,
ca.ANSWERNR,
si.SURVEYNAME as config_surveyname,
si.QUESTIONNR as config_questionnr,
si.ANSWERNR as config_answernr,
 ca.conversationid,
ca.participantStartDate,
ca.projectParticipantStartDate,
cast(ca.value as varchar) as value
from CA 
LEFT OUTER JOIN PUBLIC.D_CSAT_QUESTIONS_INFO SI
on ca.projectID = si.projectId
and ca.SURVEYNAME = si.SURVEYNAME
and ((ca.QUESTIONNR = si.QUESTIONNR
and ca.ANSWERNR = si.ANSWERNR) or
     (ca.value = si.questanscombo))

)) al
left join D_CSAT_QUESTIONS_INFO cq
on cq.projectid = al.projectid
and (cq.questanscombo = al.value
     or cq.questionnr || cq.answernr = al.questionnr || al.answernr)
where config_questionnr is null
--and al.questionnr is null
and cq.questionnr is NULL;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE FORCE VIEW PI_FILES_TO_INGEST_VW COPY GRANTS AS
	SELECT * FROM raw.pi_files_to_ingest;

GRANT SELECT, REFERENCES ON PI_FILES_TO_INGEST_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON PI_FILES_TO_INGEST_VW TO ROLE DATA_SUPPORT_ROLE;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE FORCE VIEW PI_FILES_TO_INGEST_CURRENT_VW COPY GRANTS AS
	SELECT 
		d.*
	FROM
		(
			SELECT * FROM raw.pi_files_to_ingest_1001
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_101
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1101
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1111
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1201
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1301
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_2001
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_201
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_221
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_2222
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_301
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_321
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_3333
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_361
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_401
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_421
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_4444
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_501
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_551
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_555
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_5555
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_601
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_621
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_6666
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_701
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_740
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_801
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_8888
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_901
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_903
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1501
			UNION ALL
			SELECT * FROM raw.pi_files_to_ingest_1601
			
		)	D
		INNER JOIN d_pi_tables T ON (d.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL);
	
GRANT SELECT, REFERENCES ON PI_FILES_TO_INGEST_CURRENT_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON PI_FILES_TO_INGEST_CURRENT_VW TO ROLE DATA_SUPPORT_ROLE;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_VW COPY GRANTS
(
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT 	
	count(*) AS num_files,
	count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
	count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
	count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
FROM  
	PI_FILES_TO_INGEST_CURRENT_VW	s
INNER JOIN d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL);

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_VW TO ROLE DATA_SUPPORT_ROLE;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_TABLE_VW COPY GRANTS
(
	PROJECTID,
	PROJECTNAME,
	TABLE_NAME,
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT 	
	s.projectid,
	P.projectname,
	s.tablename,
	count(*) AS num_files,
	count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
	count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
	count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
FROM  
	PI_FILES_TO_INGEST_CURRENT_VW	s
INNER JOIN 
	d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL)
INNER JOIN 
	d_pi_projects P ON (s.projectid = P.projectid)	
GROUP BY 
	s.projectid,
	P.projectname,
	s.tablename;

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_TABLE_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_TABLE_VW TO ROLE DATA_SUPPORT_ROLE;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_VW COPY GRANTS
(
	PROJECTID,
	PROJECTNAME,
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT 	
	s.projectid,
	P.projectname,
	count(*) AS num_files,
	count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
	count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
	count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
FROM  
	PI_FILES_TO_INGEST_CURRENT_VW	s
INNER JOIN d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL)
INNER JOIN d_pi_projects P ON (s.projectid = P.projectid)
GROUP BY 
	s.projectid,
	P.projectname;

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_VW TO ROLE DATA_SUPPORT_ROLE;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_TABLE_VW COPY GRANTS
(
	TABLE_NAME,
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT 	
	tablename,
	count(*) AS num_files,
	count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
	count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
	count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
FROM  
	PI_FILES_TO_INGEST_CURRENT_VW	s
INNER JOIN 
	d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL)
GROUP BY 
	tablename;

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_TABLE_VW TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;
GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_TABLE_VW TO ROLE DATA_SUPPORT_ROLE;















 




  





