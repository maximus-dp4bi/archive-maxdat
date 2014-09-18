CREATE TABLE nyec_etl_sendinfotradpart
( SITP_ID                      NUMBER(18) NOT NULL
, APP_ID                       NUMBER(18) NOT NULL
, GWF_REQUEST_TYPE             VARCHAR2(1)
, GWF_RETRY_CALL               VARCHAR2(1)
, GWF_LTR_MAILED               VARCHAR2(1)
, ASF_RECEIVE_INFO_REQ         VARCHAR2(1) DEFAULT 'N'
, ASF_PROCESS_IMAGE            VARCHAR2(1) DEFAULT 'N'
, ASF_PERFORM_OUTBOUND_CALL    VARCHAR2(1) DEFAULT 'N'
, ASF_CREATE_NEW_CALL_REQ      VARCHAR2(1) DEFAULT 'N'
, ASF_MAIL_LETTER_REQ          VARCHAR2(1) DEFAULT 'N'
, ASF_CREATE_NEW_LETTER_REQ    VARCHAR2(1) DEFAULT 'N' 
, AGE_IN_BUSINESS_DAYS         NUMBER(18) NOT NULL
, AGE_IN_CALENDAR_DAYS         NUMBER(18) NOT NULL
, INSTANCE_COMPLETE_DT         DATE
, INSTANCE_STATUS              VARCHAR2(10) DEFAULT 'Active' NOT NULL
, CANCEL_DATE                  DATE
, INFO_REQ_CREATE_DT           DATE NOT NULL
, INFO_REQ_ID                  NUMBER(18) NOT NULL
, INFO_REQ_SOURCE              VARCHAR2(10) NOT NULL
, INFO_REQ_TYPE                VARCHAR2(40) NOT NULL
, INFO_REQ_GROUP               VARCHAR2(20) NOT NULL
, INFO_REQ_STATUS              VARCHAR2(20) NOT NULL
, CALL_FLAG                    VARCHAR2(1)
, CALL_RESULT                  VARCHAR2(1)
, CALL_STATUS_DT               DATE
, NEW_CALL_REQ_ID              NUMBER(18)
, LETTER_IMAGE_LINK_DT         DATE
, LETTER_REQ_DT                DATE
, LETTER_STATUS_DT             DATE
, NEW_LTR_REQ_ID               NUMBER(18)
, INFO_REQ_SENT_DT             DATE
, MAN_LETTER_FLAG              VARCHAR2(1)
, DISTRICT                     VARCHAR2(80)
, SEND_IEDR_DT                 DATE
, IEDR_ERROR_FLAG              VARCHAR2(1)
, INFO_REQ_CYCLE_END_DT        DATE
, INFO_REQ_CYCLE_START_DT      DATE
, INFO_REQ_CYCLE_BUS_DAYS      NUMBER(10)
, JEOPARDY_FLAG                VARCHAR2(1) 
, SLA_DAYS                     NUMBER(10)
, SLA_DAYS_TYPE                VARCHAR2(1)
, SLA_JEOPARDY_DT              DATE
, SLA_JEOPARDY_DAYS            NUMBER(10)
, SLA_TARGET_DAYS              NUMBER(10)
, TIMELINESS_STATUS            VARCHAR2(20) NOT NULL
, ASED_RECEIVE_INFO_REQ        DATE
, ASSD_RECEIVE_INFO_REQ        DATE
, ASED_PROCESS_IMAGE           DATE
, ASSD_PROCESS_IMAGE           DATE
, ASED_PERFORM_OUTBOUND_CALL   DATE
, ASSD_PERFORM_OUTBOUND_CALLM  DATE
, ASED_CREATE_NEW_CALL_REQ     DATE
, ASSD_CREATE_NEW_CALL_REQ     DATE
, ASED_MAIL_LETTER_REQ         DATE
, ASSD_MAIL_LETTER_REQ         DATE
, ASSD_CREATE_NEW_LETTER_REQ   DATE
, ASED_CREATE_NEW_LETTER_REQ   DATE
, STAGE_DONE_DATE              DATE 
, STG_EXTRACT_DATE             DATE NOT NULL
, STG_LAST_UPDATE_DATE         DATE NOT NULL )
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

/* Primary Key */
CREATE UNIQUE INDEX nyec_etl_sendinfotp_pk_idx ON nyec_etl_sendinfotradpart
(SITP_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;

ALTER TABLE nyec_etl_sendinfotradpart
  ADD CONSTRAINT nyec_etl_sendinfotp_pk
  PRIMARY KEY (SITP_ID);

/* Index for App ID */
CREATE INDEX nyec_etl_sendinfotp_idx2 ON nyec_etl_sendinfotradpart
(APP_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;

/* Check Constraints */
ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
CONSTRAINT nyec_etl_sendinfotp_C01
 CHECK (GWF_REQUEST_TYPE IN ('C', 'I',  'R', 'L'))
 ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C02
  CHECK (GWF_RETRY_CALL IN ('C', 'D', 'R'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C03
  CHECK (GWF_LTR_MAILED IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C04
  CHECK (ASF_RECEIVE_INFO_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C05
  CHECK (ASF_PROCESS_IMAGE IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C06
  CHECK (ASF_PERFORM_OUTBOUND_CALL IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C07
  CHECK (ASF_CREATE_NEW_CALL_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C08
  CHECK (ASF_MAIL_LETTER_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C09
  CHECK (ASF_CREATE_NEW_LETTER_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C10
  CHECK (INSTANCE_STATUS IN ( 'Active','Complete'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C11
  CHECK (INFO_REQ_SOURCE IN ('Letter Req ID','Event ID','DCN','IEDR','CIN'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C12
  CHECK (INFO_REQ_GROUP IN ('Letter','Material Request','Outbound Call','Image','Referral'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C13
  CHECK (CALL_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C14
  CHECK (CALL_RESULT IN ('V', 'T', 'E', 'B', 'F', 'H', 'I', 'R'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C15
  CHECK (MAN_LETTER_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C16
  CHECK (IEDR_ERROR_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C17
  CHECK (SLA_DAYS_TYPE IN ('B','C'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.nyec_etl_sendinfotradpart ADD 
 CONSTRAINT nyec_etl_sendinfotp_C18
  CHECK (JEOPARDY_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
/* Public Synonym for Table */
CREATE PUBLIC SYNONYM nyec_etl_sendinfotradpart FOR MAXDAT.nyec_etl_sendinfotradpart;

/* Grants for Table */
GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.nyec_etl_sendinfotradpart TO MAXDAT_OLTP_SIU;

GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.nyec_etl_sendinfotradpart TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.nyec_etl_sendinfotradpart TO MAXDAT_READ_ONLY;

/* Create Sequence, Public Synonym and Grants */
CREATE SEQUENCE SEQ_SITP
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE PUBLIC SYNONYM SEQ_SITP FOR MAXDAT.SEQ_SITP;

GRANT SELECT ON MAXDAT.SEQ_SITP TO MAXDAT_OLTP_SIU;

GRANT SELECT ON MAXDAT.SEQ_SITP TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.SEQ_SITP TO MAXDAT_READ_ONLY;

/* Trigger on Table */
CREATE OR REPLACE TRIGGER TRG_R_NYEC_ETL_SENDINFOTP 
  BEFORE INSERT OR
  UPDATE ON nyec_etl_sendinfotradpart FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :new.sitp_id IS NULL THEN
      SELECT seq_sitp.NEXTVAL 
        INTO :new.sitp_Id 
        FROM DUAL;
    END IF;
  --
    IF :new.stg_extract_date IS NULL THEN
      :new.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :new.stg_last_update_date := SYSDATE;
END;
