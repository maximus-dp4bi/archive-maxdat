--------------------------------------------------------
--  File created - Wednesday-May-29-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CORP_ETL_CONTROL
--------------------------------------------------------

  CREATE TABLE "CORP_ETL_CONTROL" 
  ("NAME" VARCHAR2(50),
  "VALUE_TYPE" VARCHAR2(1),
  "VALUE" VARCHAR2(100),
  "DESCRIPTION" VARCHAR2(400),
  "CREATED_TS" DATE,
  "UPDATED_TS" DATE);

   COMMENT ON COLUMN "CORP_ETL_CONTROL"."NAME" IS 'Named Variable which will have a value stored';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."VALUE_TYPE" IS 'Type of the named variable';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."VALUE" IS 'Holds the value for the named variable identifier - secondary lookup value';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."DESCRIPTION" IS 'Description of named variable';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."CREATED_TS" IS 'Date variable created';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."UPDATED_TS" IS 'Date Variable updated';
/
REM INSERTING into CORP_ETL_CONTROL
SET DEFINE OFF;
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('IR_LAST_ACCOUNT_ID','N','0','Used to fetch the new Account Renewal from OLTP.',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('ME_LAST_COV_RQST_ID','N','0','Used to fetch the new Membership Eligibility from OLTP.',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('HIGH_LIMIT_TASK_ID','N','999999999','Used to set task High limit, rarely used',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MW_LAST_TASK_ID','N','0','Used to fetch task records from OLTP for MW process',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS)
 values ('MW_IN_PROCESS','V','N','Used to determine if Schedule can start Stage update',sysdate,sysdate);
--------------------------------------------------------
--  DDL for Index CECTL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CECTL_PK" ON "CORP_ETL_CONTROL" ("NAME") ;
/
--------------------------------------------------------
--  Constraints for Table CORP_ETL_CONTROL
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_CONTROL" ADD CONSTRAINT "CECTL_PK" PRIMARY KEY ("NAME") ENABLE;
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("UPDATED_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("CREATED_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("VALUE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("VALUE_TYPE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("NAME" NOT NULL ENABLE);
/
