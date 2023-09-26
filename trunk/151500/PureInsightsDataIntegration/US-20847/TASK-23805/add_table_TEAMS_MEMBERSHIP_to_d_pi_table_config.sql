use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

-- teams_membership

delete from d_pi_tables where table_name = 'teams_membership';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('teams_membership', TRUE, TRUE, current_timestamp(), 'truncate_insert', 'NA');

