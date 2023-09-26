INSERT INTO CORP_ETL_CONTROL(NAME,VALUE_TYPE,VALUE, DESCRIPTION) VALUES ('QA_AUDIT_SKIP_ETL_RUN_CNTR','N',10,'Skip QA AUDIT ETL execution, "0" - Dont run ETL and "n" ( > 0), where n is number of times QA Audit ETL to be skipped.');
INSERT INTO CORP_ETL_CONTROL(NAME,VALUE_TYPE,VALUE, DESCRIPTION) VALUES ('QA_AUDIT_CUR_ETL_RUN_CNTR','N',1,'Number of times QA Audit ETL have been skipped since last run, variable to be reset when its value matches QA_AUDIT_SKIP_ETL_RUN_CNTR variable.');
INSERT INTO CORP_ETL_CONTROL(NAME,VALUE_TYPE,VALUE, DESCRIPTION) VALUES ('QA_AUDIT_REC_LOOK_BACK','N',100,'Used to set number of Audit records to look back and catch missing records ');
INSERT INTO CORP_ETL_CONTROL(NAME,VALUE_TYPE,VALUE, DESCRIPTION) VALUES ('QA_CALLCENTER_SKIP_ETL_RUN_CNTR','N',15,'Skip QA CallCenter ETL execution, "0" - Dont run ETL and "n" ( > 0), where n is number of times QA CallCenter ETL to be skipped.');
INSERT INTO CORP_ETL_CONTROL(NAME,VALUE_TYPE,VALUE, DESCRIPTION) VALUES ('QA_CALLCENTER_CUR_ETL_RUN_CNTR','N',1,'Number of times QA CallCenter ETL have been skipped since last run, variable to be reset when its value matches QA_CALLCENTER_SKIP_ETL_RUN_CNTR variable.');
INSERT INTO CORP_ETL_CONTROL(NAME,VALUE_TYPE,VALUE, DESCRIPTION) VALUES ('QA_CALLCENTER_REC_LOOK_BACK','N',100,'Used to set number of call center Audit records to look back and catch missing records.');

COMMIT;

ALTER TABLE D_QA_CHECKSHEETS ADD CALL_TYPE_ID NUMBER;
ALTER TABLE S_QA_AUDIT_RESULTS ADD CALL_SUBTYPE_ID NUMBER;
ALTER TABLE S_QA_AUDIT_RESULTS ADD CALL_PURPOSE VARCHAR2(100);
ALTER TABLE S_QA_AUDIT_RESULTS ADD CALL_DATE_TIME DATE;
ALTER TABLE S_QA_AUDIT_RESULTS ADD CALL_END_DATE_TIME DATE;

CREATE OR REPLACE VIEW S_QA_AUDIT_RESULTS_SV AS
SELECT QC_RESULTS_ID
      ,OPS_SPECIALIST_EMP_ID
      ,QC_SPECIALIST_EMP_ID
      ,START_TIME
      ,END_TIME
      ,SESSION_ID
      ,CHECKSHEET_ID
      ,CASE_NUMBER
      ,OUTCOME_ID
      ,CHECKSHEET_RECEIPT_DATE
      ,TASK_PROCESS_DATE
      ,CHECKSHEET_LAST_EDIT_DATE
      ,VOID
      ,VOID_REASON
      ,BATCH_TYPE
      ,BATCH_NUMBER
      ,TRANSACTION_NUMBER
      ,RATASK_TYPE
      ,TRANSACTION_TYPE
      ,PLAN_CODE
      ,CIN
      ,CALL_SUBTYPE_ID
      ,CALL_PURPOSE
      ,CALL_DATE_TIME
      ,CALL_END_DATE_TIME
  FROM S_QA_AUDIT_RESULTS
  WITH READ ONLY;

CREATE TABLE D_QA_CALL_TYPES
  (
    Call_Type_ID NUMBER NOT NULL,
    Description VARCHAR2(100),
    Active NUMBER,
    Reporting_Title VARCHAR2(100),
    Reporting_Footer VARCHAR2(100)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
grant select, insert, update on D_QA_CALL_TYPES to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_QA_CALL_TYPES to MAXDAT_OLTP_SIUD;
grant select on D_QA_CALL_TYPES to MAXDAT_READ_ONLY;  

CREATE TABLE D_QA_CALL_SUBTYPES
  (
    Call_SubType_ID NUMBER NOT NULL,
    Description VARCHAR2(100),
    Active NUMBER,
    Reporting_Title VARCHAR2(100),
    Reporting_Footer VARCHAR2(100),
    Mqmpr NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


grant select, insert, update on D_QA_CALL_SUBTYPES to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_QA_CALL_SUBTYPES to MAXDAT_OLTP_SIUD;
grant select on D_QA_CALL_SUBTYPES to MAXDAT_READ_ONLY;