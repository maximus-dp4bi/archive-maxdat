use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

GRANT USAGE ON PROCEDURE PUREINSIGHTS_DEV.STAGE.S_PI_PRIMARY_PRESENCE_LOAD(VARCHAR, BOOLEAN, BOOLEAN) TO PI_DATA_INGEST_DEV_ALERT_USER WITH GRANT OPTION;

DELETE FROM 
	PUBLIC.D_PI_INGESTION_SPS 
WHERE 	
	sp_name = 'S_PI_PRIMARY_PRESENCE_LOAD'
AND	schema_name = 'STAGE';

INSERT INTO
	PUBLIC.D_PI_INGESTION_SPS	
	(
		sp_name,
		schema_name,
		active,
		update_timestamp
	)
VALUES
	(	'S_PI_PRIMARY_PRESENCE_LOAD',	
		'STAGE',
		TRUE,
		current_timestamp()
	);
