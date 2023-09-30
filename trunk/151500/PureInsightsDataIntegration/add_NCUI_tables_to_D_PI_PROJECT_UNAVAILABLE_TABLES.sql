use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

INSERT INTO PUBLIC.D_PI_PROJECT_UNAVAILABLE_TABLES
SELECT
	'741'					AS 	PROJECT_ID,
	'NC UI'					AS 	PROJECT_NAME,
	pt.table_name			AS 	TABLE_NAME,
	NULL					AS	END_UNAVAILABLE_DATE,
	current_timestamp()		AS	UPDATE_TIMESTAMP
FROM
	PUBLIC.D_PI_TABLES	pt
WHERE
	NOT EXISTS
	(
		SELECT 
			1
		FROM
			PUBLIC.D_PI_PROJECT_UNAVAILABLE_TABLES pat
		WHERE
			project_id = '741'
		AND table_name = pt.table_name
	)		
AND pt.active = TRUE;

SELECT * FROM PUBLIC.D_PI_PROJECT_UNAVAILABLE_TABLES WHERE project_id = '741';	

DELETE FROM PUBLIC.D_PI_PROJECT_UNAVAILABLE_TABLES WHERE project_id = '741' AND table_name NOT IN ('dialer_detail', 'dialer_preview_detail');