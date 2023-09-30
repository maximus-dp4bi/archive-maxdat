USE ROLE SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema RAW;

CREATE OR REPLACE TABLE wfm_service_goal_templates  CLONE DIALER_DETAIL;
TRUNCATE TABLE wfm_service_goal_templates;

delete from pi_files_to_ingest where tablename = 'wfm_service_goal_templates';

GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON wfm_service_goal_templates  TO ROLE GEN_DP4BI_DEV;
GRANT SELECT, REFERENCES ON TABLE wfm_service_goal_templates  TO ROLE KYVOS_DP4BI_DEV_READ;
GRANT SELECT, REFERENCES ON TABLE wfm_service_goal_templates TO ROLE MAX_QA;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON wfm_service_goal_templates TO ROLE PUREINSIGHTS_DEV_POC;
GRANT SELECT, REFERENCES ON TABLE wfm_service_goal_templates  TO ROLE PUREINSIGHTS_DEV_READ;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON wfm_service_goal_templates  TO ROLE PUREINSIGHTS_GEN_DP4BI_DEV;
GRANT UPDATE, TRUNCATE, SELECT, REFERENCES, REBUILD, INSERT, DELETE ON wfm_service_goal_templates TO ROLE PI_DATA_INGEST_DEV_ALERT_USER;


