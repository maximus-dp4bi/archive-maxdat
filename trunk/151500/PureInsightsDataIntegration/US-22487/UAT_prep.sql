use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

SELECT * FROM raw.transcription_program_queue_mapping;

SELECT * FROM d_pi_projects;

SELECT count(*) FROM raw.session_requested_routing_skills;  DEV=47,498,842  UAT=47,498,842  PRD=47,498,842
SELECT count(*) FROM raw.wfm_planning_group_configuration;  DEV=459  UAT=459  PRD=459
SELECT count(*) FROM raw.wfm_service_goal_templates;  DEV=2  UAT=2  PRD=2                            

SELECT count(*) FROM raw.transcription_program_configuration;  DEV=13   UAT=4
SELECT count(*) FROM raw.transcription_program_flow_mapping;   DEV=0    UAT=0
SELECT count(*) FROM raw.transcription_program_queue_mapping;  DEV=49   UAT=13
SELECT count(*) FROM raw.transcription_program_topic_mapping;  DEV=419  UAT=0

TRUNCATE TABLE raw.transcription_program_configuration;
DELETE FROM pi_files_to_ingest WHERE tablename = 'transcription_program_configuration';

TRUNCATE TABLE raw.transcription_program_flow_mapping;
DELETE FROM pi_files_to_ingest WHERE tablename = 'transcription_program_flow_mapping';

TRUNCATE TABLE raw.transcription_program_queue_mapping;
DELETE FROM pi_files_to_ingest WHERE tablename = 'transcription_program_queue_mapping';

TRUNCATE TABLE raw.transcription_program_topic_mapping;
DELETE FROM pi_files_to_ingest WHERE tablename = 'transcription_program_topic_mapping';

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ts))) as tstamp, * from raw.ingest_pi_data_det_log WHERE projectid = '701' order by TS desc;