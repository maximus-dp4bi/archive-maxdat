USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

CREATE OR REPLACE TABLE user_languages CLONE DIALER_DETAIL;
TRUNCATE TABLE user_languages;

delete from pi_files_to_ingest where tablename = 'user_languages';

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON user_languages TO ROLE GEN_DP4BI_DEV;
GRANT SELECT, REFERENCES ON TABLE user_languages TO ROLE KYVOS_DP4BI_DEV_READ;
GRANT SELECT, REFERENCES ON TABLE user_languages TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON user_languages TO ROLE PUREINSIGHTS_DEV_POC;
GRANT SELECT, REFERENCES ON TABLE user_languages TO ROLE PUREINSIGHTS_UAT_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON user_languages TO ROLE PUREINSIGHTS_GEN_DP4BI_UAT;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON user_languages TO ROLE PI_DATA_INGEST_UAT_ALERT_USER;


