create or replace TABLE AUDIO_QUALITY (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE BILLABLE_USAGE (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE CONFIGURATION_OBJECTS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE CONVERSATIONS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE CONVERSATIONS_DETAIL (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);


create or replace TABLE CONVERSATIONS_SUMMARY (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE CONVERSATION_ATTRIBUTES (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);


create or replace TABLE DIALER_DETAIL (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE DIALER_PREVIEW_DETAIL (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE DIVISIONS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE EVALUATIONS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE EVALUATION_FORMS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE FLOW_OUTCOMES (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE GROUPS_MEMBERSHIP (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE LOCATIONS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE MYSQL_AUDITS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE PARTICIPANTS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE PRIMARY_PRESENCE (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE QUEUES_MEMBERSHIP (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE QUEUE_CONFIGURATION (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE ROUTING_STATUS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE SEGMENTS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE SESSIONS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE SESSION_SUMMARY (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE USER_DETAILS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE USER_LOCATIONS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE USER_ROLES (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE USER_SKILLS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE WFM_ACTIVITY_CODES (
	RAW VARIANT,
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE WFM_HISTORICAL_ACTUALS (
	RAW VARIANT,
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE WFM_HISTORICAL_EXCEPTIONS (
	RAW VARIANT,
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE WFM_SCHEDULE (
	RAW VARIANT,
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);

create or replace TABLE evaluation_calibrations (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	RAW VARIANT,
	INGESTIONDATETIME TIMESTAMP_NTZ(9)
);
