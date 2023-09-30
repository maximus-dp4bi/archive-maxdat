use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

-- user_languages

delete from d_pi_tables where table_name = 'user_languages';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('user_languages', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');

