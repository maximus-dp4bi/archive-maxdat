--------------------------------------------------------
--  DDL for Table EMRS_D_CASE
--------------------------------------------------------

  CREATE TABLE "EMRS_D_CASE" 
   (	"CASE_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(50), 
	"CASE_NUMBER" NUMBER(22,0), 
	"CSDA_CODE" VARCHAR2(32), 
	"FIRST_NAME" VARCHAR2(30), 
	"MIDDLE_INITIAL" VARCHAR2(1), 
	"LAST_NAME" VARCHAR2(30), 
	"FULL_NAME" VARCHAR2(80), 
	"PHONE" VARCHAR2(20), 
	"MAILING_ADDRESS1" VARCHAR2(55), 
	"MAILING_ADDRESS2" VARCHAR2(55), 
	"MAILING_CITY" VARCHAR2(30), 
	"MAILING_STATE" VARCHAR2(2), 
	"MAILING_ZIP" VARCHAR2(9), 
	"CASE_SEARCH_ELEMENT" VARCHAR2(9), 
	"GUARDIAN_FULL_NAME" VARCHAR2(80), 
	"RECORD_DATE" DATE, 
	"RECORD_TIME" VARCHAR2(5), 
	"RECORD_NAME" VARCHAR2(80), 
	"MODIFIED_DATE" DATE, 
	"MODIFIED_TIME" VARCHAR2(5), 
	"MODIFIED_NAME" VARCHAR2(80), 
	"VERSION" NUMBER(*,0), 
	"DATE_OF_VALIDITY_START" DATE, 
	"DATE_OF_VALIDITY_END" DATE, 
	"CREATED_BY" VARCHAR2(18), 
	"DATE_CREATED" DATE, 
	"UPDATED_BY" VARCHAR2(18), 
	"DATE_UPDATED" DATE, 
	"SOURCE_RECORD_ID" NUMBER(18,0), 
	"CURRENT_CASE_ID" NUMBER(18,0), 
	"CURRENT_FLAG" VARCHAR2(1) DEFAULT 'N', 
	"FAMILY_NUMBER" NUMBER(18,0), 
	"CASE_STATUS_DATE" DATE, 
	"CASE_EDUCATED_IND" VARCHAR2(1), 
	"CASE_EDUCATED_DATE" DATE, 
	"CASE_NEED_TRANSLATOR_IND" VARCHAR2(1), 
	"CASE_PHONE_REMINDER_USE" VARCHAR2(1), 
	"CASE_EDUCATED_BY" VARCHAR2(40), 
	"CASE_STAFF_ID" NUMBER(18,0), 
	"CASE_LANGUAGE_CD" VARCHAR2(32), 
	"CASE_HOW_EDUCATED_CD" VARCHAR2(32), 
	"CASE_STATUS" VARCHAR2(2), 
	"CASE_HEAD_SSN" VARCHAR2(30), 
	"CASE_TEAM" VARCHAR2(1), 
	"CASE_LOAD" NUMBER(6,0), 
	"CLNT_CLIENT_ID" NUMBER(18,0), 
	"FMNB_ID" NUMBER(18,0), 
	"LOAD_TYPE" VARCHAR2(32), 
	"CASE_SPOKEN_LANGUAGE_CD" VARCHAR2(32), 
	"NOTE_REF_ID" NUMBER(18,0), 
	"ANNIVERSARY_DT" DATE, 
	"STATE_STAFF_ID_EXT" VARCHAR2(32), 
	"CASE_GENERIC_FIELD1_DATE" DATE, 
	"CASE_GENERIC_FIELD2_DATE" DATE, 
	"CASE_GENERIC_FIELD3_NUM" NUMBER(18,0), 
	"CASE_GENERIC_FIELD4_NUM" NUMBER(18,0), 
	"CASE_GENERIC_FIELD5_TXT" VARCHAR2(256), 
	"CASE_GENERIC_FIELD6_TXT" VARCHAR2(256), 
	"CASE_GENERIC_FIELD7_TXT" VARCHAR2(256), 
	"CASE_GENERIC_FIELD8_TXT" VARCHAR2(256), 
	"CASE_GENERIC_FIELD9_TXT" VARCHAR2(256), 
	"CASE_GENERIC_FIELD10_TXT" VARCHAR2(256), 
	"CASE_GENERIC_REF11_ID" NUMBER(18,0), 
	"CASE_GENERIC_REF12_ID" NUMBER(18,0), 
	"LAST_STATE_UPDATE_TS" DATE, 
	"LAST_STATE_UPDATED_BY" NUMBER(18,0), 
	"CASE_CIN" VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_CASE"."CASE_ID" IS 'Case ID (PK)';
   COMMENT ON COLUMN "EMRS_D_CASE"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program that Uses This CSDA';
   COMMENT ON COLUMN "EMRS_D_CASE"."CASE_NUMBER" IS 'Case Number';
   COMMENT ON COLUMN "EMRS_D_CASE"."CSDA_CODE" IS 'Care Service Delivery Area ID';
   COMMENT ON COLUMN "EMRS_D_CASE"."FIRST_NAME" IS 'HOH First Name';
   COMMENT ON COLUMN "EMRS_D_CASE"."MIDDLE_INITIAL" IS 'HOH Middle Initial';
   COMMENT ON COLUMN "EMRS_D_CASE"."LAST_NAME" IS 'HOH Last Name';
   COMMENT ON COLUMN "EMRS_D_CASE"."FULL_NAME" IS 'HOH Full Name';
   COMMENT ON COLUMN "EMRS_D_CASE"."PHONE" IS 'Phone Number';
   COMMENT ON COLUMN "EMRS_D_CASE"."MAILING_ADDRESS1" IS 'Case Address 1';
   COMMENT ON COLUMN "EMRS_D_CASE"."MAILING_ADDRESS2" IS 'Case Address 2';
   COMMENT ON COLUMN "EMRS_D_CASE"."MAILING_CITY" IS 'Case City';
   COMMENT ON COLUMN "EMRS_D_CASE"."MAILING_STATE" IS 'Case State';
   COMMENT ON COLUMN "EMRS_D_CASE"."MAILING_ZIP" IS 'Case ZIP';
   COMMENT ON COLUMN "EMRS_D_CASE"."CASE_SEARCH_ELEMENT" IS 'Case Search Element (Last3 +Zip3)';
   COMMENT ON COLUMN "EMRS_D_CASE"."GUARDIAN_FULL_NAME" IS 'HOH Full Name';
   COMMENT ON COLUMN "EMRS_D_CASE"."RECORD_DATE" IS 'Record Creation Date';
   COMMENT ON COLUMN "EMRS_D_CASE"."RECORD_TIME" IS 'Record Creation Time';
   COMMENT ON COLUMN "EMRS_D_CASE"."RECORD_NAME" IS 'Record Creation Name';
   COMMENT ON COLUMN "EMRS_D_CASE"."MODIFIED_DATE" IS 'Record Modification Date';
   COMMENT ON COLUMN "EMRS_D_CASE"."MODIFIED_TIME" IS 'Record Modification Time';
   COMMENT ON COLUMN "EMRS_D_CASE"."MODIFIED_NAME" IS 'Record Modification Name';
   COMMENT ON COLUMN "EMRS_D_CASE"."VERSION" IS 'Type-2 SCD Version Number';
   COMMENT ON COLUMN "EMRS_D_CASE"."DATE_OF_VALIDITY_START" IS 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_CASE"."DATE_OF_VALIDITY_END" IS 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_CASE"."CREATED_BY" IS 'Warehouse Load Created By';
   COMMENT ON COLUMN "EMRS_D_CASE"."DATE_CREATED" IS 'Warehouse Load Creation Date';
   COMMENT ON COLUMN "EMRS_D_CASE"."UPDATED_BY" IS 'Warehouse Load Updated By';
   COMMENT ON COLUMN "EMRS_D_CASE"."DATE_UPDATED" IS 'Warehouse Load Date Updated';