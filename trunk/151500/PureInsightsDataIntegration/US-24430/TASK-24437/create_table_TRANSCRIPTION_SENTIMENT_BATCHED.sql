USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

CREATE OR REPLACE TABLE transcription_sentiment_batched CLONE DIALER_DETAIL;
TRUNCATE TABLE transcription_sentiment_batched;

delete from pi_files_to_ingest where tablename = 'transcription_sentiment';
delete from pi_files_to_ingest where tablename = 'transcription_sentiment_batched';

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_sentiment_batched TO ROLE GEN_DP4BI_DEV;
GRANT SELECT, REFERENCES ON TABLE transcription_sentiment_batched TO ROLE KYVOS_DP4BI_DEV_READ;
GRANT SELECT, REFERENCES ON TABLE transcription_sentiment_batched TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_sentiment_batched TO ROLE PUREINSIGHTS_DEV_POC;
GRANT SELECT, REFERENCES ON TABLE transcription_sentiment_batched TO ROLE PUREINSIGHTS_UAT_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_sentiment_batched TO ROLE PUREINSIGHTS_GEN_DP4BI_UAT;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_sentiment_batched TO ROLE PI_DATA_INGEST_UAT_ALERT_USER;


