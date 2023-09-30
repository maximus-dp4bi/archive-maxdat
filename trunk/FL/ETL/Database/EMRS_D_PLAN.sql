--------------------------------------------------------
--  File created - Tuesday-March-04-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMRS_D_PLAN
--------------------------------------------------------

  CREATE TABLE "EMRS_D_PLAN" ("PLAN_ID" NUMBER(38,0),
  "MANAGED_CARE_PROGRAM" VARCHAR2(50),
  "CSDA" VARCHAR2(32),
  "PLAN_CODE" VARCHAR2(32),
  "PLAN_NAME" VARCHAR2(64),
  "PLAN_ABBREVIATION" VARCHAR2(64),
  "PLAN_EFFECTIVE_DATE" DATE,
  "ADDRESS1" VARCHAR2(30),
  "ADDRESS2" VARCHAR2(30),
  "CITY" VARCHAR2(20),
  "STATE" VARCHAR2(2),
  "ZIP" VARCHAR2(10),
  "ACTIVE" VARCHAR2(1),
  "CONTACT_FIRST_NAME" VARCHAR2(30),
  "CONTACT_INITIAL" VARCHAR2(1),
  "CONTACT_LAST_NAME" VARCHAR2(30),
  "CONTACT_FULL_NAME" VARCHAR2(80),
  "CONTACT_PHONE" VARCHAR2(20),
  "CONTACT_EXTENSION" VARCHAR2(6),
  "MEMBER_CONTACT_PHONE" VARCHAR2(20),
  "ENROLLOK" VARCHAR2(1),
  "PLAN_ASSIGN" VARCHAR2(1),
  "RECORD_DATE" DATE,
  "RECORD_TIME" VARCHAR2(5),
  "RECORD_NAME" VARCHAR2(80),
  "SOURCE_RECORD_ID" NUMBER(22,0),
  "PLAN_TYPE_ID" NUMBER(22,0)) 

   COMMENT ON COLUMN "EMRS_D_PLAN"."PLAN_ID" IS 'Plan (PK)'
   COMMENT ON COLUMN "EMRS_D_PLAN"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program that Uses this Plan'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CSDA" IS 'Plan Service Delivery Area'
   COMMENT ON COLUMN "EMRS_D_PLAN"."PLAN_CODE" IS 'Plan Code'
   COMMENT ON COLUMN "EMRS_D_PLAN"."PLAN_NAME" IS 'Plan Name'
   COMMENT ON COLUMN "EMRS_D_PLAN"."PLAN_ABBREVIATION" IS 'Plan Name Abbreviation'
   COMMENT ON COLUMN "EMRS_D_PLAN"."PLAN_EFFECTIVE_DATE" IS 'Plan Effective Date'
   COMMENT ON COLUMN "EMRS_D_PLAN"."ADDRESS1" IS 'Plan Address1'
   COMMENT ON COLUMN "EMRS_D_PLAN"."ADDRESS2" IS 'Plan Address2'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CITY" IS 'Plan City'
   COMMENT ON COLUMN "EMRS_D_PLAN"."STATE" IS 'Plan State'
   COMMENT ON COLUMN "EMRS_D_PLAN"."ZIP" IS 'Plan Zip Code'
   COMMENT ON COLUMN "EMRS_D_PLAN"."ACTIVE" IS 'Plan Activated'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CONTACT_FIRST_NAME" IS 'MAXIMUS Contact First Name'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CONTACT_INITIAL" IS 'MAXIMUS Contact Middle Initial'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CONTACT_LAST_NAME" IS 'MAXIMUS Contact Last Name'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CONTACT_FULL_NAME" IS 'MAXIMUS Contact First, Last Name'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CONTACT_PHONE" IS 'MAXIMUS Contact Phone Number'
   COMMENT ON COLUMN "EMRS_D_PLAN"."CONTACT_EXTENSION" IS 'MAXIMUS Contact Phone Extension'
   COMMENT ON COLUMN "EMRS_D_PLAN"."MEMBER_CONTACT_PHONE" IS 'Member Contact Phone Number'
   COMMENT ON COLUMN "EMRS_D_PLAN"."ENROLLOK" IS 'OK To Enroll'
   COMMENT ON COLUMN "EMRS_D_PLAN"."PLAN_ASSIGN" IS 'Use In Assignment (Y;N)'
   COMMENT ON COLUMN "EMRS_D_PLAN"."RECORD_DATE" IS 'Record Creation Date'
   COMMENT ON COLUMN "EMRS_D_PLAN"."RECORD_TIME" IS 'Record Creation Time'
   COMMENT ON COLUMN "EMRS_D_PLAN"."RECORD_NAME" IS 'Record Created By'
/
--------------------------------------------------------
--  DDL for Index PLAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PLAN_PK" ON "EMRS_D_PLAN" ("PLAN_ID")
/
--------------------------------------------------------
--  DDL for Index PLAN_PLAN_COMB_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PLAN_PLAN_COMB_UK" ON "EMRS_D_PLAN" ("PLAN_CODE", "CSDA", "MANAGED_CARE_PROGRAM")
/
--------------------------------------------------------
--  Constraints for Table EMRS_D_PLAN
--------------------------------------------------------

  ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLAN_PLAN_COMB_UK" UNIQUE ("PLAN_CODE", "CSDA", "MANAGED_CARE_PROGRAM") ENABLE
  ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLAN_PK" PRIMARY KEY ("PLAN_ID") ENABLE
  ALTER TABLE "EMRS_D_PLAN" MODIFY ("PLAN_ID" NOT NULL ENABLE)
  ALTER TABLE "EMRS_D_PLAN" MODIFY ("MANAGED_CARE_PROGRAM" NOT NULL ENABLE)
  ALTER TABLE "EMRS_D_PLAN" MODIFY ("PLAN_CODE" NOT NULL ENABLE)
  ALTER TABLE "EMRS_D_PLAN" MODIFY ("PLAN_NAME" NOT NULL ENABLE)
/
--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_PLAN
--------------------------------------------------------

  ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLAN_TYPE_FK" FOREIGN KEY ("PLAN_TYPE_ID") REFERENCES "EMRS_D_PLAN_TYPE" ("PLAN_TYPE_ID") ENABLE
/
--------------------------------------------------------
--  DDL for Trigger BIR_PLANS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PLANS" 
 BEFORE INSERT
 ON emrs_d_plan
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN.plan_id%TYPE;
BEGIN
  IF :NEW.plan_id IS NULL THEN
    SElECT EMRS_SEQ_PLANS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.plan_id       := v_seq_id;
  END IF;
END BIR_PLANS;
ALTER TRIGGER "BIR_PLANS" ENABLE
/
