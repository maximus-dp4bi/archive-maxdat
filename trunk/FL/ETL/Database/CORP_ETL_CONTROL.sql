--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
DROP TABLE "CORP_ETL_CONTROL" cascade constraints;
/
--------------------------------------------------------
--  DDL for Table CORP_ETL_CONTROL
--------------------------------------------------------

CREATE TABLE "CORP_ETL_CONTROL" ("NAME" VARCHAR2(50), "VALUE_TYPE" VARCHAR2(1), "VALUE" VARCHAR2(100), "DESCRIPTION" VARCHAR2(400), "CREATED_TS" DATE, "UPDATED_TS" DATE)
/
REM INSERTING into CORP_ETL_CONTROL
SET DEFINE OFF;
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('SMI_FEMSI_ID','N','1','Used to fetch the last Support Member Inquiry ID',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MAX_SMI_FEMSI_ID','N','1','The Max FEMSI ID that the next sequence will grab',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MAX_LETTERREQ_ID','N','1','The Max Letter ReqID that the next sequence will grab',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('SMI_LAST_CONTACT_ID','N','1','The Max Contact ID that the next sequence will grab',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MAX_MD_ID','N','1','The Max Monitor Disputes ID that the next sequence will grab',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MD_LAST_MD_ID','N','1','Used to fetch the last monitor disputes mdid processed',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('PL_LAST_LETTER_REQID','N','1','Used to fetch the last letter reqid processed',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('PA_LAST_APP_ID','N','1','Used to fetch the last appid processed',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MAX_APP_ID','N','1','The Max Application ID that the next sequence will grab',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('IR_LAST_ACCOUNT_ID','N','1','Used to fetch the new Account Renewal from OLTP.',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('ME_LAST_COV_RQST_ID','N','1','Used to fetch the new Membership Eligibility from OLTP.',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('HIGH_LIMIT_TASK_ID','N','999999999','Used to set task High limit, rarely used',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MW_LAST_TASK_ID','N','1','Used to fetch task records from OLTP for MW process',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MW_IN_PROCESS','V','N','Used to determine if Schedule can start Stage update',sysdate,sysdate);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('PMFX_DCN_ID','N','1','Used to fetch the new DCN from OLTP for ProcessMailFaxDoc workbook',sysdate,sysdate);
/
--------------------------------------------------------
--  Constraints for Table CORP_ETL_CONTROL
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("UPDATED_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("CREATED_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("VALUE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("VALUE_TYPE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("NAME" NOT NULL ENABLE);
/
