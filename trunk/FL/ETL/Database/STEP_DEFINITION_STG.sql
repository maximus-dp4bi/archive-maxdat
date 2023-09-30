--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
DROP TABLE "STEP_DEFINITION_STG";
--------------------------------------------------------
--  DDL for Table STEP_DEFINITION_STG
--------------------------------------------------------

  CREATE TABLE "STEP_DEFINITION_STG" ("STEP_DEFINITION_ID" NUMBER(18,0), "NAME" VARCHAR2(100), "DESCRIPTION" VARCHAR2(4000), "TIME_TO_COMPLETE" NUMBER(9,0), "TIME_UNIT_CD" VARCHAR2(32), "FORWARDING_RULE_CD" VARCHAR2(32), "ESCALATION_RULE_CD" VARCHAR2(32), "PRIORITY_CD" VARCHAR2(32), "PERFORM_TIMEOUT_IND" NUMBER(1,0), "STEP_TYPE_CD" VARCHAR2(32), "CREATED_BY" VARCHAR2(80), "CREATE_TS" DATE, "UPDATED_BY" VARCHAR2(80), "UPDATE_TS" DATE, "MANUAL_TASK_IND" NUMBER(1,0), "SPRING_BEAN" VARCHAR2(256), "CORRELATION_PARTS" VARCHAR2(4000)) ;
/
--------------------------------------------------------
--  DDL for Index XPKSTEP_DEFINITION_STG
--------------------------------------------------------

  CREATE UNIQUE INDEX "XPKSTEP_DEFINITION_STG" ON "STEP_DEFINITION_STG" ("STEP_DEFINITION_ID") ;
/
--------------------------------------------------------
--  Constraints for Table STEP_DEFINITION_STG
--------------------------------------------------------

  ALTER TABLE "STEP_DEFINITION_STG" MODIFY ("STEP_DEFINITION_ID" NOT NULL ENABLE);
  ALTER TABLE "STEP_DEFINITION_STG" ADD CONSTRAINT "XPKSTEP_DEFINITION_STG" PRIMARY KEY ("STEP_DEFINITION_ID") ENABLE;
/
