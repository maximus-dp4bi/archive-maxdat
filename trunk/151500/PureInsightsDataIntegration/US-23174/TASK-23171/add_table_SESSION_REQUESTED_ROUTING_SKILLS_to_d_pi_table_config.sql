use role PI_DATA_INGEST_DEV_ALERT_USER;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema RAW;

-- session_requested_routing_skills

delete from d_pi_tables where table_name = 'session_requested_routing_skills';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('session_requested_routing_skills', TRUE, TRUE, current_timestamp(), 'truncate_multi_file_insert', 'NA');

