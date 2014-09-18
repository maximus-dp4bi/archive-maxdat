--------------------------------------------------------
--  File created - Thursday-February-13-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMRS_S_CLIENT_ELIGIBILITY_STG
--------------------------------------------------------

  CREATE TABLE "EMRS_S_CLIENT_ELIGIBILITY_STG" 
  ("CLIENT_PLAN_ELIGIBILITY_ID" NUMBER(22,0), 
  "CLIENT_NUMBER" NUMBER(22,0),
  "DATE_OF_VALIDITY_START" DATE, 
  "DATE_OF_VALIDITY_END" DATE, 
  "VERSION" NUMBER(22,0),
  "SOURCE_RECORD_ID" NUMBER(22,0),
  "PLAN_TYPE_CD" VARCHAR2(32),
  "SUB_PROGRAM_CODE" VARCHAR2(32), 
  "ELIGIBILITY_STATUS_CODE" VARCHAR2(32), 
  "PROGRAM_CD" VARCHAR2(32), 
  "UPD_CLIENT_PLAN_ELIG_ID" NUMBER(22,0)) ;
/
--------------------------------------------------------
--  DDL for Index IDX1_ELIGSTG
--------------------------------------------------------

  CREATE INDEX "IDX1_ELIGSTG" ON "EMRS_S_CLIENT_ELIGIBILITY_STG" ("SOURCE_RECORD_ID") ;
/
--------------------------------------------------------
--  DDL for Index IDX2_ELIGSTG
--------------------------------------------------------

  CREATE INDEX "IDX2_ELIGSTG" ON "EMRS_S_CLIENT_ELIGIBILITY_STG" ("CLIENT_NUMBER", "PLAN_TYPE_CD", "SUB_PROGRAM_CODE") ;
/
