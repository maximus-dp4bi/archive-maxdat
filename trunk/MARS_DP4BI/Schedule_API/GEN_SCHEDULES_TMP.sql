create or replace TABLE STAGE.GEN_SCHEDULES_TMP (
    PROJECTID VARCHAR,
    PROJECTNAME VARCHAR,
	SCHEDULE_ID VARCHAR,
    SCHEDULE_NAME VARCHAR,
    DIVISION_ID VARCHAR,
    DIVISION_NAME VARCHAR,
    SCHEDULE_DESCRIPTION VARCHAR, -- it is not appearing in the payload when preview it
    SCHEDULE_VERSION VARCHAR,
    SCHEDULE_DATE_CREATED VARCHAR,
	SCHEDULE_DATE_MODIFIED VARCHAR,
	SCHEDULE_STATE VARCHAR,
	SCHEDULE_START_DATE VARCHAR,
    SCHEDULE_END_DATE VARCHAR,
    SCHEDULE_RRULE VARCHAR,
    SCHEDULE_REFERENCED_TYPE VARCHAR,
	ROW_HASH VARCHAR,
    SF_DATETIME_INS TIMESTAMP_NTZ,
    primary key (PROJECTID, SCHEDULE_ID, SF_DATETIME_INS)
);