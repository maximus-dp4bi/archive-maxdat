use role PI_DATA_INGEST_DEV_ALERT_USER;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema RAW;

-- wfm_service_goal_templates

delete from d_pi_tables where table_name = 'wfm_service_goal_templates';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('wfm_service_goal_templates', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');



