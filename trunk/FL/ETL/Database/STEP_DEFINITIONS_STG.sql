--------------------------------------------------------
--  File created - Monday-April-22-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table STEP_DEFINITION_STG
--------------------------------------------------------

  CREATE TABLE "STEP_DEFINITION_STG" 
   (	"STEP_DEFINITION_ID" NUMBER(18,0), 
	"NAME" VARCHAR2(100 BYTE), 
	"DESCRIPTION" VARCHAR2(4000 BYTE), 
	"TIME_TO_COMPLETE" NUMBER(9,0), 
	"TIME_UNIT_CD" VARCHAR2(32 BYTE), 
	"FORWARDING_RULE_CD" VARCHAR2(32 BYTE), 
	"ESCALATION_RULE_CD" VARCHAR2(32 BYTE), 
	"PRIORITY_CD" VARCHAR2(32 BYTE), 
	"PERFORM_TIMEOUT_IND" NUMBER(1,0), 
	"STEP_TYPE_CD" VARCHAR2(32 BYTE), 
	"CREATED_BY" VARCHAR2(80 BYTE), 
	"CREATE_TS" DATE, 
	"UPDATED_BY" VARCHAR2(80 BYTE), 
	"UPDATE_TS" DATE, 
	"MANUAL_TASK_IND" NUMBER(1,0), 
	"SPRING_BEAN" VARCHAR2(256 BYTE), 
	"CORRELATION_PARTS" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645);
--------------------------------------------------------
--  DDL for Index XPKSTEP_DEFINITION_STG
--------------------------------------------------------

  CREATE UNIQUE INDEX "XPKSTEP_DEFINITION_STG" ON "STEP_DEFINITION_STG" ("STEP_DEFINITION_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645);
--------------------------------------------------------
--  Constraints for Table STEP_DEFINITION_STG
--------------------------------------------------------

  ALTER TABLE "STEP_DEFINITION_STG" ADD CONSTRAINT "XPKSTEP_DEFINITION_STG" PRIMARY KEY ("STEP_DEFINITION_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645) ENABLE;
  ALTER TABLE "STEP_DEFINITION_STG" MODIFY ("STEP_DEFINITION_ID" NOT NULL ENABLE);