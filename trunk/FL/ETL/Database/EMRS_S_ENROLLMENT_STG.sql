--------------------------------------------------------
--  File created - Thursday-April-17-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMRS_S_ENROLLMENT_STG
--------------------------------------------------------

  CREATE TABLE "EMRS_S_ENROLLMENT_STG" 
  ("SOURCE_SELECTION_RECORD_ID" NUMBER(22,0),
  "SOURCE_CLIENT_ID" NUMBER(22,0),
  "SOURCE_CASE_ID" NUMBER(22,0),
  "SOURCE_NETWORK_ID" NUMBER(22,0),
  "PROGRAM_TYPE_CODE" VARCHAR2(32),
  "SUB_PROGRAM_CODE" VARCHAR2(32),
  "SOURCE_PLAN_CODE" VARCHAR2(32),
  "PLAN_TYPE_CODE" VARCHAR2(32),
  "SELECTION_REASON_CODE" VARCHAR2(32),
  "SELECTION_SOURCE_CODE" VARCHAR2(32),
  "ENROLLMENT_ACTION_STATUS_CODE" VARCHAR2(32),
  "MANAGED_CARE_START_DATE" DATE,
  "MANAGED_CARE_END_DATE" DATE,
  "NUMBER_COUNT" NUMBER(22,0),
  "COST_SHARE_START_DATE" DATE,
  "COST_SHARE_END_DATE" DATE,
  "CO_PAY_AMOUNT" NUMBER(22,3),
  "ENROLLMENT_FEE_ASSESSED" NUMBER(22,4),
  "ENROLLMENT_FEE_ASSESSED_DATE" DATE,
  "ENROLLMENT_FEE_PAID" NUMBER(22,4),
  "ENROLLMENT_FEE_PAID_DATE" DATE, 
  "MET_COST_SHARE_CAP_DATE" DATE,
  "ENROLLMENT_FEE_FREQUENCY" VARCHAR2(30),
  "CHIP_ANNUAL_ENROLL_DATE" DATE,
  "CERTIFICATION_DATE" DATE,
  "RISK_GROUP_CODE" VARCHAR2(32),
  "COVERAGE_CODE" VARCHAR2(32),
  "MEDICAID_RECERTIFICATION_DATE" DATE,
  "COUNTY_CODE" VARCHAR2(32),
  "CSDA_CODE" VARCHAR2(32),
  "PLAN_SERVICE_TYPE" VARCHAR2(32),
  "AID_CATEGORY_CODE" VARCHAR2(32),
  "CITIZENSHIP_STATUS_CODE" VARCHAR2(32),
  "LANGUAGE_CODE" VARCHAR2(32),
  "CREATE_TS" VARCHAR2(20), 
  "CREATE_TS_HRMIN" VARCHAR2(20),
  "CREATE_TS_SECOND" NUMBER(2,0),
  "ENROLLMENT_STATUS_CHANGE_DATE" DATE,
  "CHANGE_REASON_CODE" VARCHAR2(32),
  "IS_PROCESSED" VARCHAR2(1),
  "RECORD_STATUS" VARCHAR2(20),
  "STATUS_IN_GROUP_CODE" VARCHAR2(32),
  "PEOPLE_IN_FAMILY" NUMBER(22,0),
  "SOURCE_TABLE_NAME" VARCHAR2(30), 
  "ELIGIBILITY_RECEIPT_DATE" DATE, 
  "RACE_CODE" VARCHAR2(32), 
  "PROVIDER_TYPE_CODE" VARCHAR2(32), 
  "CREATED_BY" VARCHAR2(30),
  "UPDATED_BY" VARCHAR2(100), 
  "DATE_UPDATED" DATE);
/
--------------------------------------------------------
--  DDL for Index EMRS_S_ENROLLMENT_STG
--------------------------------------------------------

  CREATE UNIQUE INDEX "EMRS_S_ENROLLMENT_STG" ON "EMRS_S_ENROLLMENT_STG" ("SOURCE_SELECTION_RECORD_ID") ;
/
--------------------------------------------------------
--  Constraints for Table EMRS_S_ENROLLMENT_STG
--------------------------------------------------------

  ALTER TABLE "EMRS_S_ENROLLMENT_STG" MODIFY ("SOURCE_SELECTION_RECORD_ID" NOT NULL ENABLE);
/
--------------------------------------------------------
--  DDL for Trigger BIR_S_ENROLLMENT_STG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_S_ENROLLMENT_STG" 
   before insert on "EMRS_S_ENROLLMENT_STG" 
   for each row 
begin  
   if inserting then 
      if :NEW."SOURCE_SELECTION_RECORD_ID" is null then 
         select EMRS_SEQ_ENRL_STG_RECORD_ID.nextval into :NEW."SOURCE_SELECTION_RECORD_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BIR_S_ENROLLMENT_STG" ENABLE;
/