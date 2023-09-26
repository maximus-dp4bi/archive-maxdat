  CREATE TABLE "CC_S_TMP_NICE_AGENT" (
  "FIRST_NAME" VARCHAR2(64 BYTE),
  "LAST_NAME" VARCHAR2(64 BYTE),
  "LOGIN_ID" NUMBER(*,0),
  "HIRE_DATE" DATE,
  "TERMINATION_DATE" DATE,
  "JOB_TITLE" VARCHAR2(255 BYTE), 
  "AGENT_GROUP" VARCHAR2(255 BYTE),
  "LANGUAGE" VARCHAR2(255 BYTE),
  "AGENT_GROUP_ID" NUMBER, 
  "EMPLOYEE_TYPE" VARCHAR2(4 BYTE), 
  "TIER" VARCHAR2(30 BYTE), 
  "CONVERSION_DATE" DATE, 
  "GROUP_START_DATE" DATE,
  "SUFFIX" VARCHAR2(20 BYTE), 
  "MODIFY_DATE" DATE, 
  "MODIFY_USER" VARCHAR2(20 BYTE),
  "SENIORITY_EFFECTIVE_DATE" DATE,
  "DELETE_DATE" DATE, "NATIONAL_ID" VARCHAR2(20 BYTE))
/
  CREATE TABLE "CC_S_TMP_NICE_AGENT_ACTUALS" 
   (	"LOGIN_ID" NUMBER, 
	"LAST_NAME" VARCHAR2(64 BYTE), 
	"FIRST_NAME" VARCHAR2(64 BYTE), 
	"ACD_LOGIN_ID" VARCHAR2(256 BYTE), 
	"HIRE_DATE" DATE, 
	"TERMINATION_DATE" DATE, 
	"ACTIVTY_NAME" VARCHAR2(64 BYTE), 
	"START_DATETIME" DATE, 
	"END_DATETIME" DATE, 
	"DURATION_SEC" NUMBER, 
	"ACTIVTY_ID" VARCHAR2(20 BYTE)
   ) 
/
CREATE TABLE "CC_S_TMP_NICE_AGENT_SCHEDULES" 
   (	"AGENT_LOGIN" NUMBER(*,0), 
	"ACTIVITY_NAME" VARCHAR2(64 BYTE), 
	"DATE_UPDATED" DATE, 
	"START_DATETIME" DATE, 
	"END_DATETIME" DATE, 
	"ACTIVITY_ID" VARCHAR2(32 BYTE), 
	"AGENT_ID" VARCHAR2(32 BYTE), 
	"ACTIVITY_KEY" NUMBER
   )
/
CREATE TABLE "CC_S_TMP_NICE_EVENT" 
   (	"ACTIVITY_ID" NUMBER(*,0), 
	"C_OID" VARCHAR2(32 BYTE), 
	"UPDATE_DATE" DATE, 
	"AVAIL" VARCHAR2(1 BYTE), 
	"IN_OFFICE" VARCHAR2(1 BYTE), 
	"NAME" VARCHAR2(64 BYTE), 
	"OPEN" VARCHAR2(1 BYTE), 
	"OVERTIME" VARCHAR2(1 BYTE), 
	"PAID" VARCHAR2(1 BYTE), 
	"PERSONAL" VARCHAR2(1 BYTE), 
	"TYPE" VARCHAR2(1 BYTE), 
	"USES_SEAT" VARCHAR2(1 BYTE), 
	"WORK" VARCHAR2(1 BYTE), 
	"PRIORITY" NUMBER(*,0)
   )
/

CREATE TABLE "CC_S_TMP_NICE_SUP_TO_STAFF" 
   (	"STAFF_ID" NUMBER, 
	"PRIORITY" NUMBER, 
	"EFFECTIVE_DATE" DATE, 
	"END_DATE" DATE, 
	"SUPERVISOR_ID" NUMBER
   ) 
/
   ALTER table CC_S_AGENT add "EMPLOYEE_TYPE" VARCHAR2(4 BYTE), 
	"TIER" VARCHAR2(30 BYTE), 
	"CONVERSION_DATE" DATE, 
	"GROUP_START_DATE" DATE
   COMMENT ON COLUMN "CC_S_AGENT"."EMPLOYEE_TYPE" IS 'EMPLOYEE_TYPE" IS ''Temp/Perm';
   COMMENT ON COLUMN "CC_S_AGENT"."TIER" IS 'Agent level ie. CSR I, CSR II, CSR III';
   COMMENT ON COLUMN "CC_S_AGENT"."CONVERSION_DATE" IS 'Date from Temp to Perm';
   COMMENT ON COLUMN "CC_S_AGENT"."GROUP_START_DATE" IS 'Start date with the Group training to floor.';
   
/
 ALTER table CC_D_AGENT add "EMPLOYEE_TYPE" VARCHAR2(4 BYTE), 
							"TIER" VARCHAR2(30 BYTE), 
							"CONVERSION_DATE" DATE, 
							"GROUP_START_DATE" DATE
   COMMENT ON COLUMN "CC_D_AGENT"."EMPLOYEE_TYPE" IS 'EMPLOYEE_TYPE" IS ''Temp/Perm';
   COMMENT ON COLUMN "CC_D_AGENT"."TIER" IS 'Agent level ie. CSR I, CSR II, CSR III';
   COMMENT ON COLUMN "CC_D_AGENT"."CONVERSION_DATE" IS 'Date from Temp to Perm';
   COMMENT ON COLUMN "CC_D_AGENT"."GROUP_START_DATE" IS 'Start date with the Group training to floor.';