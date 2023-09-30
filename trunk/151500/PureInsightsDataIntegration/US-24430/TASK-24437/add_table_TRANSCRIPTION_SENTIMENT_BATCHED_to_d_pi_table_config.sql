use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

-- transcription_sentiment_batched

delete from d_pi_tables where table_name = 'transcription_sentiment';
delete from d_pi_tables where table_name = 'transcription_sentiment_batched';

INSERT INTO d_pi_tables (table_name, s3_sourced, active, update_timestamp, ingest_type, key_string)
VALUES ('transcription_sentiment_batched', TRUE, TRUE, current_timestamp(), 'truncate_multi_file_insert', 'NA');

