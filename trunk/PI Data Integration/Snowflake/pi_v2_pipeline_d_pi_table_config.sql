use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

SELECT * FROM d_pi_projects;

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

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wfm_planning_group_agents', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');

-- wfm_planning_group_configuration

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

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wrapup_mapping', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'wrapupCodeId');

USE ROLE sysadmin;

 SELECT * FROM  PUREINSIGHTS_DEV.PUBLIC.D_PI_TABLES
 WHERE table_name NOT IN (SELECT table_name FROM d_pi_tables)
 AND active = TRUE;

SELECT
  pia.*
FROM 
	PUBLIC.d_pi_tables pia
    LEFT JOIN
    PUREINSIGHTS_DEV.PUBLIC.D_PI_TABLES pid    
    ON (pia.table_name = pid.table_name)
WHERE
     pid.ingest_type != pia.ingest_type
  OR pid.key_string != pia.key_string
  OR pid.active != pia.ACTIVE 
  OR pid.s3_sourced != pia.s3_sourced;
 
UPDATE d_pi_tables SET active = TRUE, update_timestamp = current_timestamp WHERE table_name = 'wrapup_mapping' ;
