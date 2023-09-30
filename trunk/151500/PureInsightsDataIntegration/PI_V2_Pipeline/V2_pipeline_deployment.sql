use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

create or replace file format MYFORMAT2 type=parquet;
grant usage on file format MYFORMAT2 to PI_DATA_INGEST_UAT_ALERT_USER;
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
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId;sessionId;edgeId;codec'
WHERE 
	table_name = 'audio_quality';

-- billable_usage

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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
	key_string = 'participantId;key'
WHERE 
	table_name = 'conversation_attributes';


-- conversations

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId'
WHERE 
	table_name = 'conversations';


-- conversations_detail

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId;attemptTime'
WHERE 
	table_name = 'dialer_detail';


-- dialer_preview_detail

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId;sessionId;attemptStartTime;attemptEndTime'
WHERE 
	table_name = 'dialer_preview_detail';


-- divisions

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId;divisionId'
WHERE 
	table_name = 'divisions';


-- evaluation_calibrations

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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
	ingest_type = 'merge_no_deletes', 
	key_string = 'id;questionId;questionAnswerID'
WHERE 
	table_name = 'evaluations';


-- flow_outcomes

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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
	ingest_type = 'merge_no_deletes', 
	key_string = 'participantId'
WHERE 
	table_name = 'participants';


-- primary_presence

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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
	ingest_type = 'merge_no_deletes', 
	key_string = 'userId;startTime'
WHERE 
	table_name = 'routing_status';


-- segments

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationId;sessionId;segmentIndex'
WHERE 
	table_name = 'segments';


-- session_summary

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'conversationID;sessionID'
WHERE 
	table_name = 'session_summary';


-- sessions

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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
	ingest_type = 'merge_no_deletes', 
	key_string = 'userId;managementUnitId;dayStartTime'
WHERE 
	table_name = 'wfm_day_metrics';


-- wfm_historical_actuals
-- Table not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
	key_string = 'userId;activityStartTime'
WHERE 
	table_name = 'wfm_historical_actuals';

-- wfm_historical_exceptions
-- Table not included in DD.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_no_deletes', 
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


-- wfm_schedule
-- Table is listed as wfs_schedules in DD.  We have not been specified with any rules to use to detect deletes.

UPDATE 
	d_pi_tables 
SET 
	update_timestamp = current_timestamp(), 
	ingest_type = 'merge_with_deletes', 
	key_string = 'scheduleID;userId;activityStartTime'
WHERE 
	table_name = 'wfm_schedule';

-- wrapup_mapping

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wrapup_mapping', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'wrapupCodeId');

SELECT
  pia.*
FROM 
	PUBLIC.d_pi_tables pia
    LEFT JOIN
    PUREINSIGHTS_DEV.PUBLIC.D_PI_TABLES pid    
    ON (pia.table_name = pid.table_name)
WHERE
     pid.ingest_type != pia.ingest_type
  OR pid.key_string != pia.key_string;


CREATE OR REPLACE VIEW D_PI_INGESTION_PROJECTS_VW COPY GRANTS
AS
SELECT * FROM PUBLIC.D_PI_PROJECTS WHERE active = true;

GRANT SELECT ON D_PI_INGESTION_PROJECTS_VW TO PI_DATA_INGEST_DEV_ALERT_USER;

use role PI_DATA_INGEST_UAT_ALERT_USER;
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
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

CREATE OR REPLACE VIEW D_PI_INGESTION_PROJECTS_VW COPY GRANTS
AS
SELECT * FROM PUBLIC.D_PI_PROJECTS WHERE active = true;

GRANT SELECT ON D_PI_INGESTION_PROJECTS_VW TO PI_DATA_INGEST_UAT_ALERT_USER;

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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

insert into pi_files_to_ingest select * from pureinsights_dev.raw.pi_files_to_ingest;

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

CREATE OR REPLACE TABLE raw.pi_files_to_ingest_2222 AS SELECT * FROM raw.pi_files_to_ingest;
CREATE OR REPLACE TABLE raw.pi_files_to_ingest_740 AS SELECT * FROM raw.pi_files_to_ingest;

CALL createProjectFilesListTables (true);

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

GRANT SELECT, REFERENCES ON ALL VIEWS IN SCHEMA RAW TO SYSADMIN;
GRANT SELECT, REFERENCES ON ALL TABLES IN SCHEMA RAW TO SYSADMIN;

use role SYSADMIN;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_BY_FILE_VW COPY GRANTS
(
	TABLE_NAME,
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT *
  FROM (
			SELECT 	tablename,
					count(*) AS num_files,
					count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
					count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
					count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
			  FROM  (
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
			) s
			INNER JOIN d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.key_string IS NOT NULL)
			GROUP BY tablename
			ORDER BY tablename
	);

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_BY_FILE_VW TO ROLE PI_DATA_INGEST_UAT_ALERT_USER;

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

GRANT SELECT, REFERENCES ON ALL VIEWS IN SCHEMA RAW TO SYSADMIN;
GRANT SELECT, REFERENCES ON ALL TABLES IN SCHEMA RAW TO SYSADMIN;

use role SYSADMIN;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_SUMMARY_VW COPY GRANTS
(
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT 	count(*) AS num_files,
		count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
		count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
		count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
  FROM  (
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
) s
INNER JOIN d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.key_string IS NOT NULL);

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_SUMMARY_VW TO ROLE PI_DATA_INGEST_UAT_ALERT_USER;

USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

CREATE OR REPLACE TABLE WRAPUP_MAPPING CLONE DIALER_DETAIL;
TRUNCATE TABLE WRAPUP_MAPPING;

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE GEN_DP4BI_UAT;
GRANT SELECT, REFERENCES ON TABLE WRAPUP_MAPPING TO ROLE KYVOS_DP4BI_UAT_READ;
GRANT SELECT, REFERENCES ON TABLE WRAPUP_MAPPING TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE PUREINSIGHTS_UAT_POC;
GRANT SELECT, REFERENCES ON TABLE WRAPUP_MAPPING TO ROLE PUREINSIGHTS_UAT_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE PUREINSIGHTS_GEN_DP4BI_UAT;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON WRAPUP_MAPPING TO ROLE PI_DATA_INGEST_UAT_ALERT_USER;

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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
     
    //create stage for DATA today
    var sqlCommand = "CREATE STAGE RAW." + stageName + " URL = 's3://soapax-pureinsights-v2/"+ AWSFOLDERNAME +"/' CREDENTIALS=(aws_key_id='AKIAT6QV4CSZF5RW77X4' aws_secret_key='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');";
    snowflake.execute ({sqlText: sqlCommand});

  return "0";
  $$;  
 
use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

CREATE or replace PROCEDURE getFilesToIngest(projectid varchar, programName varchar, tableName varchar, stageName varchar, afterTime varchar, beforeTime varchar, reIngestFlag Boolean)
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

	sqlCommand = "insert into pi_files_to_ingest_"+PROJECTID+" select * from (with parquet as (select case when split_part(\"name\",'/','-3') in ('transcription_topics','transcription_sentiment') then split_part(\"name\",'/','-3') else split_part(\"name\",'/','-2') end as tablename,split_part(\"name\",'/','-1') as filename,\"last_modified\" as modified_timestamp FROM table(result_scan(last_query_id())) lsid where convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) >= to_timestamp('"+AFTERTIME+"','YYYY/MM/DD HH24:MI:SS') and convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) <= to_timestamp('"+BEFORETIME+"','YYYY/MM/DD HH24:MI:SS') order by \"last_modified\") select '"+PROJECTID+"',null, pt.tablename,pt.filename,convert_timezone('UTC','America/New_York',to_timestamp(rtrim(modified_timestamp,' GMT'),'DY, DD MON YYYY HH24:MI:SS')),null,null,null,null,null from parquet pt left outer join pi_files_to_ingest fti on fti.projectid = '"+PROJECTID+"' and fti.tablename = pt.tablename and fti.filename = pt.filename and fti.file_timestamp = convert_timezone('UTC','America/New_York',to_timestamp(rtrim(modified_timestamp,' GMT'),'DY, DD MON YYYY HH24:MI:SS')) where ((fti.file_timestamp is null or fti.status != 'COMPLETE') and (pt.tablename != 'wfm_schedule' or REGEXP_COUNT(pt.filename, '_', 1, 'i') = 2)));";

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

use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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
    var createdSQL = snowflake.createStatement({sqlText: sqlCommand});
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

		if (TABLEINGESTTYPE == "merge_no_deletes" || TABLEINGESTTYPE == "merge_with_deletes")
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

        		if (TABLEINGESTTYPE == "merge_with_deletes" && TABLENAME == "wfm_schedule")
        		{
					attempt = 0;
					var rowCount = -1;
				
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

							if (rowCount < 0)
							{
			        			var sqlCommand = `select count(*) from @`+stageName+`/`+TABLENAME+`/`+filename+` (PATTERN=>'.*.parquet', FILE_FORMAT => myformat2) t;`;

			        			stmt = snowflake.createStatement({sqlText: sqlCommand});
						       	var result2 = stmt.execute();
						
						        result2.next();
						      	rowCount = result2.getColumnValue(1); 
							}
							
					      	if (rowCount == 0)
					      	{
								var file_name_part_array = filename.split("_");
								var business_unit_id = file_name_part_array[0];
								var activity_start_date = file_name_part_array[1];
								var schedule_id = file_name_part_array[2];
							
								schedule_id = schedule_id.replace(".parquet", "");
							
								sqlCommand = `DELETE FROM raw.wfm_schedule WHERE projectid = '`+PROJECTID+`' AND raw:scheduleID::string = '`+schedule_id+`';`;
	  							snowflake.execute ({sqlText: sqlCommand});

								log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO","SQL: " + sqlCommand);
					    		log(PROJECTID, LOG_CATEGORY, TABLENAME, "SUCCEEDED","Succeeded in analyzing and processing deletes for file "+filename+" and scheduleID="+schedule_id+".");		   					
	  						
					      	}
					  		attempt = max_attempts + 1;
					  	}
					    catch (err)  
					    {

		 					var error = err.message;
					        error = error.replace("'", " ");
					       
						    if(error.includes("was aborted because the number of waiters for this lock exceeds"))
						    {
			  					error = "Transaction was aborted because the number of waiters for this lock exceeds the maximum";
						    }
					       
					    	log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED","Failed to analyze and process deletes for file "+filename+" and scheduleID="+schedule_id+": "+ error);
		
							//update files to ingest TABLE
							
						  	var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+error+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
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
	
						    if(!error.includes("was aborted because the number of waiters for this lock exceeds"))
						    {
			  					attempt = max_attempts + 1;
						    }
					    					    
		 					var error = err.message;
					        error = error.replace("'", " ");
					       
						    if(error.includes("was aborted because the number of waiters for this lock exceeds"))
						    {
			  					error = "Transaction was aborted because the number of waiters for this lock exceeds the maximum";
						    }
					    
					    	log(PROJECTID, LOG_CATEGORY+REINGEST_SFX, TABLENAME, "FAILED","Failed to analyze and process deletes for file "+filename+" and scheduleID="+schedule_id+": "+ error);
					        
					    	if (attempt >= max_attempts)
					    	{
					    		return "88";
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
		 
						log(PROJECTID,"SQL"+REINGEST_SFX,TABLENAME,"INFO","SQL: " + sqlCommand); 
	  				  				
	  					snowflake.execute ({sqlText: sqlCommand});
	  				
	  					attempt = max_attempts + 1;
	           
						//update files to ingest TABLE
						
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

	 					var error = err.message;
				        error = error.replace("'", " ");
				       
					    if(error.includes("was aborted because the number of waiters for this lock exceeds"))
					    {
		  					error = "Transaction was aborted because the number of waiters for this lock exceeds the maximum";
					    }
				       
	    				log(PROJECTID,LOG_CATEGORY, TABLENAME, "FAILED","Failed to ingest file "+filename+" for table " + TABLENAME +" : "+error);
	
						//update files to ingest TABLE
						
					  	var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+error+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
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

		        	if (attempt >= max_attempts)
		        	{				
						return "99";
					}
				}

    			//truncate table
   				if (TABLEINGESTTYPE == "truncate_insert") 
   				{

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
	
		   					var sqlCommand = "delete from raw."+TABLENAME+" where projectid = '" + PROJECTID + "';";
		   					log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
	    				
	    					snowflake.execute ({sqlText: sqlCommand});
	    				
	    					attempt = max_attempts + 1;
	        			}
	    				catch (err)  
	    				{

		 					var error = err.message;
					        error = error.replace("'", " ");

					      	if(error.includes("was aborted because the number of waiters for this lock exceeds"))
						    {
		 	 					error = "Transaction was aborted because the number of waiters for this lock exceeds the maximum";
					    	}

	       					log(PROJECTID, LOG_CATEGORY, TABLENAME, "FAILED", "Failed to truncate table " +TABLENAME+ " for projectid " + PROJECTID + ": "+ error); 
	
	   	  					//update files to ingest TABLE
	   	  					
		   					var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+error+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
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
		  				var sqlCommand = "copy into raw." + TABLENAME + " (projectid, projectname, ingestiondmloperation, ingestionsource, ingestionDateTime, raw) from (select '"+ PROJECTID +"','" + PROJECTNAME + "','INSERT','"+filename+"',convert_timezone('UTC','America/New_York',sysdate()), * from @" + stageName + "/" + TABLENAME + "/) PATTERN='.*"+filename+"' FILE_FORMAT = (TYPE= 'PARQUET') FORCE=TRUE;"; 
		  				log(PROJECTID,LOG_CATEGORY, TABLENAME, "INFO",sqlCommand);
	  				
	  					snowflake.execute ({sqlText: sqlCommand});
	  				
	  					attempt = max_attempts + 1;
	  				
			  			//update files to ingest TABLE
			  			
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
			 			var error = err.message;
					    error = error.replace("'", " ");
					   
					    if(error.includes("was aborted because the number of waiters for this lock exceeds"))
					    {
		  					error = "Transaction was aborted because the number of waiters for this lock exceeds the maximum";
					    }
					   
	        			log(PROJECTID,LOG_CATEGORY, TABLENAME, "FAILED","Failed to ingest file "+filename+" for table " + TABLENAME +" : "+ error);
	
	   	   				//update files to ingest TABLE
	   	   				
		    			var sqlCommand = "update raw.pi_files_to_ingest_"+PROJECTID+" set status = 'FAILED', status_msg = 'Ingestion failed with error:  "+error+"', ingest_end_timestamp = convert_timezone('UTC','America/New_York',sysdate()), status_timestamp = convert_timezone('UTC','America/New_York',sysdate()) where tablename = '" + TABLENAME + "' and filename = '"+filename+"' and file_timestamp = to_timestamp('" + file_timestamp + "');";
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
  
use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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
  
  
use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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
 sqlCommand="call getFilesToIngest ('"+PROJECTID+"',null,'"+TABLENAME+"','"+stageName+"','"+afterTimeString+"','"+beforeTimeString+"',"+REINGESTFLAG+");"; 
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
     
     
     snowflake.execute ({sqlText: sqlCommand});
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
     sqlCommand = "call "+ sp + "('"+PROJECTID+"','"+REINGESTFLAG+"',"+RUNFROMBASHFLAG+");"
     snowflake.execute ({sqlText: sqlCommand});
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


use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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


use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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
 
use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
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
 




  





