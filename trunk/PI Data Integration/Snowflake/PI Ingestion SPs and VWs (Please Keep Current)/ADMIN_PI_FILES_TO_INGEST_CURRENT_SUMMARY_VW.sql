use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_VW COPY GRANTS
(
	NUM_FILES,
	NUM_IN_PROGRESS,
	NUM_COMPLETE,
	NUM_FAILED
)
AS
SELECT 	
	count(*) AS num_files,
	count(CASE WHEN status = 'IN PROGRESS' THEN 1 ELSE null END) num_in_progress,
	count(CASE WHEN status = 'COMPLETE' THEN 1 ELSE null END) num_complete,
	count(CASE WHEN status = 'FAILED' THEN 1 ELSE null END) num_failed
FROM  
	PI_FILES_TO_INGEST_CURRENT_VW	s
INNER JOIN d_pi_tables T ON (s.tablename = T.table_name AND T.active = TRUE AND T.ingest_type IS NOT NULL);

GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_VW TO ROLE PI_DATA_INGEST_UAT_ALERT_USER;
GRANT SELECT, REFERENCES ON ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_VW TO ROLE DATA_SUPPORT_ROLE;