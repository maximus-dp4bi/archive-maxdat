use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_TABLE_VW COPY GRANTS
AS
SELECT 
	'TEST_PROJECT' AS projectname, 
	'TEST_TABLE' table_name, 
	1000 AS num_files, 
	20 AS num_in_progress, 
	650 AS num_complete, 
	0 AS num_failed
FROM 
	DUAL
UNION 
SELECT 
	'TEST_PROJECT' AS projectname, 
	'TEST_TABLE' table_name, 
	1000 AS num_files, 
	0 AS num_in_progress, 
	1000 AS num_complete, 
	8 AS num_failed
FROM 
	DUAL;

SELECT * FROM ADMIN_PI_FILES_TO_INGEST_CURRENT_SUMMARY_BY_PROJECT_TABLE_VW;
