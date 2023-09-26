use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema STAGE;

create or replace table PI_TEAMS_MEMBERSHIP_HISTORY 
(
	PROJECTID 									VARCHAR(255),
	PROGRAMID 									VARCHAR(255),
	INGESTIONDATETIME 							TIMESTAMP_NTZ(9),
	TEAMID										VARCHAR(16777216),
	TEAMNAME									VARCHAR(16777216),
	USERID										VARCHAR(16777216),
	USERNAME									VARCHAR(16777216),
	DIVISIONID									VARCHAR(16777216),
	DIVISIONNAME								VARCHAR(16777216),
	RAW 										VARIANT,
	ROW_HASH 									NUMBER(19,0),
	SNOWFLAKE_INSERT_DATETIME 					TIMESTAMP_NTZ(9),
	SNOWFLAKE_UPDATE_DATETIME 					TIMESTAMP_NTZ(9),
	AS_OF_DATE 									DATE,
	INSERT_BY 									VARCHAR(500),
	CURRENT_USER_RECORD 						NUMBER(1,0)
);

GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO BI_PRODUCT_DEV;   
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO DATA_SUPPORT_ROLE;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO DA_LAB_ADMIN;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO DA_LAB_READ;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO MAX_DEV;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO PUBLIC;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON PI_TEAMS_MEMBERSHIP_HISTORY TO PUREINSIGHTS_DEV_READ;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON PI_TEAMS_MEMBERSHIP_HISTORY TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON PI_TEAMS_MEMBERSHIP_HISTORY TO PUREINSIGHTS_DEV_POC;