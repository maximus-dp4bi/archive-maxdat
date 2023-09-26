use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

-- transcription_topic_configuration

delete from d_pi_tables where table_name = 'transcription_topic_configuration';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('transcription_topic_configuration', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');

