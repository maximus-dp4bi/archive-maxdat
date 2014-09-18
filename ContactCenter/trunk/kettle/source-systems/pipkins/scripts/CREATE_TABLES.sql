--------------------------------------------------------
--  DDL for Table STAFF
--------------------------------------------------------
  CREATE TABLE "STAFF" 
   (	"STAFF_ID" NUMBER(*,0), 
	"NATIONAL_ID" VARCHAR2(250 BYTE), 
	"LAST_NAME" VARCHAR2(50 BYTE), 
	"FIRST_NAME" VARCHAR2(50 BYTE), 
	"MIDDLE_NAME" VARCHAR2(50 BYTE), 
	"SUFFIX" VARCHAR2(50 BYTE), 
	"HIRE_DATE" DATE, 
	"TERMINATION_DATE" DATE, 
	"SCHEDULE_TYPE" NUMBER(*,0), 
	"DELETE_DATE" DATE, 
	"SENIORITY_EFFECTIVE_DATE" DATE DEFAULT null, 
	"OWNER_USER" NUMBER(*,0), 
	"MODIFY_USER" NUMBER(*,0), 
	"OWNER_DATE" DATE, 
	"MODIFY_DATE" DATE, 
	"EMAIL_ADDRESS" VARCHAR2(250 BYTE), 
	"COMMAND_SCRIPT" VARCHAR2(4000 BYTE), 
	"MESSAGE_BUFFER" VARCHAR2(4000 BYTE), 
	"SECONDARY_ID" VARCHAR2(250 BYTE), 
	"ADDRESS" VARCHAR2(2000 BYTE), 
	"WORK_PHONE" VARCHAR2(28 BYTE), 
	"HOME_PHONE" VARCHAR2(28 BYTE), 
	"TERMINATION_POLICY_ID" NUMBER(*,0), 
	"TERMINATION_REASON" VARCHAR2(2000 BYTE), 
	"PIP_ADDRESS" VARCHAR2(250 BYTE), 
	"TEXT_ADDRESS" VARCHAR2(250 BYTE), 
	"CELL_PHONE" VARCHAR2(28 BYTE)
   );

--------------------------------------------------------
--  DDL for Table EVENT
--------------------------------------------------------
  CREATE TABLE "EVENT" 
   (	"EVENT_ID" NUMBER(*,0), 
	"NAME" VARCHAR2(250 BYTE), 
	"EVENT_TYPE_GROUP_ID" NUMBER(*,0), 
	"EVENT_TYPE_ID" NUMBER(*,0), 
	"TOLERANCE_FOR_TIMECLOCK" DATE, 
	"DELETE_DATE" DATE, 
	"TOLERANCE_FOR_ADHERING" DATE, 
	"DESCRIPTION" VARCHAR2(250 BYTE), 
	"OWNER_USER" NUMBER(*,0), 
	"MODIFY_USER" NUMBER(*,0), 
	"OWNER_DATE" DATE, 
	"MODIFY_DATE" DATE, 
	"WORK_CLASSIFICATION_ID" NUMBER(38,0)
   );
   
--------------------------------------------------------
--  DDL for Table TASK
--------------------------------------------------------
CREATE TABLE "TASK"
	( "STAFF_ID" NUMBER(*,0),
	"SCHEDULE_INSTANCE_ID" NUMBER(*,0),
	"TASK_START" DATE,
	"SCENARIO_GROUP_ID" NUMBER(*,0),
	"TASK_END" DATE,
	"TASK_CATEGORY_ID" NUMBER(*,0),
	"DURATION" NUMBER(*,0),
	"EVENT_ID" NUMBER(*,0),
	"SUPERVISOR" NUMBER(*,0),
	"TASK_EDIT_ID" NUMBER(*,0),
	"EDIT_STATE" NUMBER(*,0),
	"TASK_MODIFICATION_REQUEST_REF" NUMBER(*,0),
	"ALT_TASK_EDIT_ID" NUMBER(*,0)
	);

--------------------------------------------------------
--  DDL for Table SUPERVISOR_TO_STAFF
--------------------------------------------------------
CREATE TABLE "SUPERVISOR_TO_STAFF"
	( "STAFF_ID" NUMBER(*,0),
	"SUPERVISOR" NUMBER(*,0),
	"PRIORITY" NUMBER(*,0),
	"EFFECTIVE_DATE" DATE,
	"END_DATE" DATE,
	"SUPERVISOR_ID" NUMBER(*,0)
	);

--------------------------------------------------------
--  DDL for Table OFFICE
--------------------------------------------------------
CREATE TABLE "OFFICE"
	(
	  OFFICE_ID NUMBER(*, 0) NOT NULL 
	, LOCALE_ID NUMBER(*, 0) 
	, TIMEZONE_ID NUMBER(*, 0) NOT NULL 
	, NAME VARCHAR2(50 BYTE) NOT NULL 
	, DESCRIPTION VARCHAR2(250 BYTE) 
	, DELETE_DATE DATE 
	, OWNER_USER NUMBER(*, 0) NOT NULL 
	, MODIFY_USER NUMBER(*, 0) 
	, OWNER_DATE DATE NOT NULL 
	, MODIFY_DATE DATE 
	, CONSTRAINT XPKOFFICE PRIMARY KEY 
	  (
		OFFICE_ID 
	  )
	  ENABLE 
	);

--------------------------------------------------------
-- DDL for Table STAFF_TO_OFFICE
--------------------------------------------------------
CREATE TABLE "STAFF_TO_OFFICE"
	(
	  EFFECTIVE_DATE DATE NOT NULL 
	, STAFF_ID NUMBER(*, 0) NOT NULL 
	, OFFICE_ID NUMBER(*, 0) NOT NULL 
	, END_DATE DATE 
	, CONSTRAINT XPKSTAFF_TO_OFFICE PRIMARY KEY 
	  (
		OFFICE_ID 
	  , STAFF_ID 
	  , EFFECTIVE_DATE 
	  )
	  ENABLE 
	);
	
-------------------------------------------------------
--  DDL for Table TIMEZONE
-------------------------------------------------------
CREATE TABLE "TIMEZONE"
	(
	  TIMEZONE_ID NUMBER(*, 0) NOT NULL 
	, STD_NAME VARCHAR2(50 BYTE) NOT NULL 
	, NAME VARCHAR2(50 BYTE) NOT NULL 
	, START_TIME DATE 
	, DST_OBSERVED NUMBER(*, 0) NOT NULL 
	, STD_OFFSET FLOAT(126) NOT NULL 
	, DST_OFFSET FLOAT(126) 
	, START_MONTH NUMBER(*, 0) 
	, START_WEEK NUMBER(*, 0) 
	, START_WEEK_DAY NUMBER(*, 0) 
	, END_TIME DATE 
	, END_MONTH NUMBER(*, 0) 
	, END_WEEK NUMBER(*, 0) 
	, END_WEEK_DAY NUMBER(*, 0) 
	, DST_NAME VARCHAR2(50 BYTE) 
	, SHIFT_YEAR1 NUMBER(*, 0) 
	, SHIFT_YEAR1_START_TIME DATE 
	, SHIFT_YEAR1_START_MONTH NUMBER(*, 0) 
	, SHIFT_YEAR1_START_WEEK NUMBER(*, 0) 
	, SHIFT_YEAR1_START_WEEK_DAY NUMBER(*, 0) 
	, SHIFT_YEAR1_END_TIME DATE 
	, SHIFT_YEAR1_END_MONTH NUMBER(*, 0) 
	, SHIFT_YEAR1_END_WEEK NUMBER(*, 0) 
	, SHIFT_YEAR1_END_WEEK_DAY NUMBER(*, 0) 
	, DOTNET_NAME VARCHAR2(50 BYTE) 
	, DISPLAY_FLAG NUMBER(38, 0) 
	, CONSTRAINT XPKTIMEZONE PRIMARY KEY 
	  (
		TIMEZONE_ID 
	  )
	  ENABLE 
	);

-------------------------------------------------------
--  DDL for Table STAFF_GROUP_TO_STAFF
-------------------------------------------------------
CREATE TABLE "STAFF_GROUP_TO_STAFF"
	( STAFF_ID NUMBER(*,0) NOT NULL
	, STAFF_GROUP_ID NUMBER(*,0) NOT NULL
	, END_DATE DATE
	, START_DATE DATE NOT NULL
	);
	
-------------------------------------------------------
--  DDL for Table STAFF_GROUP
-------------------------------------------------------
CREATE TABLE "STAFF_GROUP"
(
  STAFF_GROUP_ID NUMBER(*, 0) NOT NULL 
, PFUSER_ID NUMBER(*, 0) 
, NAME VARCHAR2(50 BYTE) NOT NULL 
, CATEGORY NUMBER(*, 0) NOT NULL 
, DESCRIPTION VARCHAR2(250 BYTE) 
, OWNER_USER NUMBER(*, 0) NOT NULL 
, MODIFY_USER NUMBER(*, 0) 
, OWNER_DATE DATE NOT NULL 
, MODIFY_DATE DATE 
, DELETE_DATE DATE 
, CONSTRAINT XPKSTAFF_GROUP PRIMARY KEY 
  (
    STAFF_GROUP_ID 
  )
  ENABLE 
);