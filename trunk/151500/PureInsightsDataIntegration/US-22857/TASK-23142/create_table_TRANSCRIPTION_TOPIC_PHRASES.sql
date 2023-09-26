USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CREATE OR REPLACE TABLE transcription_topic_phrases  CLONE DIALER_DETAIL;
TRUNCATE TABLE transcription_topic_phrases ;

delete from pi_files_to_ingest where tablename = 'transcription_topic_phrases';

INSERT INTO PUREINSIGHTS_PRD.RAW.transcription_topic_phrases SELECT * FROM PUREINSIGHTS_UAT.RAW.transcription_topic_phrases;

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_phrases   TO ROLE GEN_DP4BI_DEV;
GRANT SELECT, REFERENCES ON TABLE transcription_topic_phrases   TO ROLE KYVOS_DP4BI_DEV_READ;
GRANT SELECT, REFERENCES ON TABLE transcription_topic_phrases  TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_phrases  TO ROLE PUREINSIGHTS_DEV_POC;
GRANT SELECT, REFERENCES ON TABLE transcription_topic_phrases   TO ROLE PUREINSIGHTS_PROD_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_phrases   TO ROLE PUREINSIGHTS_GEN_DP4BI_PRD;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON transcription_topic_phrases   TO ROLE PI_DATA_INGEST_PRD_ALERT_USER;


