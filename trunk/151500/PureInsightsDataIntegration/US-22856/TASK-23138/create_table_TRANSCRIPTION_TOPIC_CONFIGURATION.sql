USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE TABLE transcription_topic_configuration  CLONE DIALER_DETAIL;
TRUNCATE TABLE transcription_topic_configuration;

delete from pi_files_to_ingest where tablename = 'transcription_topic_configuration';

INSERT INTO PUREINSIGHTS_PRD.RAW.transcription_topic_configuration SELECT * FROM PUREINSIGHTS_UAT.RAW.transcription_topic_configuration;

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_configuration  TO ROLE GEN_DP4BI_DEV;
GRANT SELECT, REFERENCES ON TABLE transcription_topic_configuration  TO ROLE KYVOS_DP4BI_DEV_READ;
GRANT SELECT, REFERENCES ON TABLE transcription_topic_configuration  TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_configuration TO ROLE PUREINSIGHTS_DEV_POC;
GRANT SELECT, REFERENCES ON TABLE transcription_topic_configuration  TO ROLE PUREINSIGHTS_PROD_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_configuration  TO ROLE PUREINSIGHTS_GEN_DP4BI_PRD;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_configuration  TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;


