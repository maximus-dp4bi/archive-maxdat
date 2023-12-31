
CREATE SEQUENCE  "EMRS_SEQ_BILLTRANS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_BILLTRANS_ID" TO "MAXDAT_READ_ONLY";


CREATE TABLE EMRS_F_BILLABLE_TRANSACTION
(DP_BILLABLE_TRANS_ID NUMBER NOT NULL
 ,TRANSACTION_DATE DATE NOT NULL
 ,MEDS_ACCEPT_DATE DATE NOT NULL
 ,ENROLLMENT_COUNT NUMBER
 ,DISENROLLMENT_COUNT NUMBER
 ,TRANSFER_COUNT NUMBER
 ,EDER_COUNT NUMBER
 ,OVER_COUNT NUMBER
 ,RECORD_DATE DATE
 ,MODIFIED_DATE DATE
 ,DATE_CREATED DATE
 ,DATE_UPDATED DATE
 ,UPDATED_BY VARCHAR2(80)
 ,CREATED_BY VARCHAR2(80)
 ) TABLESPACE MAXDAT_DATA;
 

ALTER TABLE "EMRS_F_BILLABLE_TRANSACTION" ADD CONSTRAINT "BILLTRANS_BILLTRANSID_PK" PRIMARY KEY ("DP_BILLABLE_TRANS_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX EMRSBILLTRANS_IDX01 ON EMRS_F_BILLABLE_TRANSACTION(TRANSACTION_DATE) TABLESPACE MAXDAT_INDX;
CREATE INDEX EMRSBILLTRANS_IDX02 ON EMRS_F_BILLABLE_TRANSACTION(MEDS_ACCEPT_DATE) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON "EMRS_F_BILLABLE_TRANSACTION" TO "MAXDAT_READ_ONLY";  

GRANT SELECT ON "EMRS_F_BILLABLE_TRANSACTION" TO "MAXDAT_READ_ONLY";
GRANT select, insert, update on EMRS_F_BILLABLE_TRANSACTION to MAXDAT_OLTP_SIU;
GRANT select, insert, update, delete on EMRS_F_BILLABLE_TRANSACTION to MAXDAT_OLTP_SIUD;
 
CREATE OR REPLACE TRIGGER "BUIR_F_BILLTRANS" 
 BEFORE INSERT OR UPDATE
 ON emrs_f_billable_transaction
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_F_BILLABLE_TRANSACTION.dp_billable_trans_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_billable_trans_id IS NULL THEN
      SElECT EMRS_SEQ_BILLTRANS_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_billable_trans_id       := v_seq_id;
    END IF;
    :NEW.date_created := sysdate;
    :NEW.created_by := user;
  END IF;
  
  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;
END BUIR_F_BILLTRANS;
/
ALTER TRIGGER "BUIR_F_BILLTRANS" ENABLE;
/

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_BILLABLE_TRANS_CREATE_DATE','D','2010/01/01 00:00:00','Max creation date for Billable Transaction Summary', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_BILLABLE_TRANS_UPDATE_DATE','D','2010/01/01 00:00:00','Max update date for Billable Transaction Summary', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_BILLABLE_TRANS_SOURCE_TABLE','V','dbo.BillableTransactionsSummary_DO_NOT_DELETE','Source Table name for Billable Transaction Summary', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL
VALUES ('EMRS_BILLABLE_TRANS_RUN_JOB','V','N','Flag to run/not run the Billable Transactions job', sysdate, sysdate);

commit;