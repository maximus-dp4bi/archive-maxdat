--------------------------------------------------------
--  File created - Thursday-February-13-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMRS_S_CLIENT_STATUS_STG
--------------------------------------------------------

  CREATE TABLE "EMRS_S_CLIENT_STATUS_STG" 
   (	"CLIENT_ENROLL_STATUS_ID" NUMBER(22,0), 
	"CLIENT_NUMBER" NUMBER(22,0), 
	"DATE_OF_VALIDITY_START" DATE, 
	"DATE_OF_VALIDITY_END" DATE, 
	"VERSION" NUMBER(22,0), 
	"SOURCE_RECORD_ID" NUMBER(22,0), 
	"PLAN_TYPE_CD" VARCHAR2(32), 
	"ENROLL_STATUS_CD" VARCHAR2(32), 
	"PROGRAM_CD" VARCHAR2(32), 
	"UPD_CLIENT_ENROLL_STATUS_ID" NUMBER(22,0)
   ) ;
/
--------------------------------------------------------
--  DDL for Index IDX1_ENRLSTATUSSTG
--------------------------------------------------------

  CREATE INDEX "IDX1_ENRLSTATUSSTG" ON "EMRS_S_CLIENT_STATUS_STG" ("SOURCE_RECORD_ID") 
  ;
/
--------------------------------------------------------
--  DDL for Index IDX2_ENRLSTATUSSTG
--------------------------------------------------------

  CREATE INDEX "IDX2_ENRLSTATUSSTG" ON "EMRS_S_CLIENT_STATUS_STG" ("CLIENT_NUMBER", "PLAN_TYPE_CD") 
  ;
/
