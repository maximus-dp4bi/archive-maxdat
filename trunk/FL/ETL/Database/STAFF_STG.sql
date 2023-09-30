--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
DROP TABLE "STAFF_STG";
--------------------------------------------------------
--  DDL for Table STAFF_STG
--------------------------------------------------------

  CREATE TABLE "STAFF_STG" 
 ("STAFF_ID" NUMBER(18,0),
 "EXT_STAFF_NUMBER" VARCHAR2(80),
 "DOB" DATE,
 "SSN" VARCHAR2(30),
 "FIRST_NAME" VARCHAR2(50),
 "FIRST_NAME_CANON" VARCHAR2(50),
 "FIRST_NAME_SOUND_LIKE" VARCHAR2(64),
 "GENDER_CD" VARCHAR2(32),
 "START_DATE" DATE,
 "END_DATE" DATE,
 "PHONE_NUMBER" VARCHAR2(20),
 "LAST_NAME" VARCHAR2(50),
 "LAST_NAME_CANON" VARCHAR2(50),
 "LAST_NAME_SOUND_LIKE" VARCHAR2(64),
 "CREATED_BY" VARCHAR2(80),
 "CREATE_TS" DATE,
 "UPDATED_BY" VARCHAR2(80),
 "UPDATE_TS" DATE,
 "MIDDLE_NAME" VARCHAR2(25),
 "MIDDLE_NAME_CANON" VARCHAR2(20),
 "MIDDLE_NAME_SOUND_LIKE" VARCHAR2(64),
 "EMAIL" VARCHAR2(80),
 "FAX_NUMBER" VARCHAR2(32),
 "NOTE_REFID" NUMBER(18,0),
 "DEPLOYMENT_STAFF_NUM" VARCHAR2(80),
 "DEFAULT_GROUP_ID" NUMBER(18,0),
 "STAFF_TYPE_CD" VARCHAR2(20),
 "UNIQUE_STAFF_ID" VARCHAR2(80),
 "VOID_IND" NUMBER(1,0) DEFAULT 0) ;
/
--------------------------------------------------------
--  Constraints for Table STAFF_STG
--------------------------------------------------------

  ALTER TABLE "STAFF_STG" MODIFY ("STAFF_ID" NOT NULL ENABLE);
/
