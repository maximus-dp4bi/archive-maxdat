-- 12/12 Made INFO_REQ_TYPE required
-- 01/03/13 SENDINFOTRADPART_PK indexed on MAXDAT_INDX tablespace
-- 01/08/13 Add LETTER_TYPES, and INSTANCE_TYPE_CODE
-- 01/10/13 Correct C11 check constraint
-- 01/11/13 Add ASPB_CREATE_NEW_LETTER_REQ
-- 01/18/13 Rename table from SENDINFOTRADPART_STG
-- 01/24/13 Trigger stamps ITM dates.
-- 01/30/13 Add SITP_ID
-- 02/04/13 Expand INFO_REQ_TYPE from 40 to 50
-- 02/05/13 Removed SLA calc fields; add STAGE_DONE_DATE

CREATE TABLE sendinfotradpart_bpm_stg
(INREQ_ID                     NUMBER(18) NOT NULL 
,ITM_INDICATOR                VARCHAR2(1)
,ITM_INSERT_TS                DATE
,ITM_UPDATE_TS                DATE
,SITP_ID                      NUMBER(18)
,INFO_REQ_SOURCE              VARCHAR2(20) NOT NULL
,INFO_REQ_ID                  NUMBER(18)   NOT NULL
,INFO_REQ_CREATE_DT           DATE         NOT NULL
,INFO_REQ_TYPE                VARCHAR2(50) NOT NULL
,INFO_REQ_GROUP               VARCHAR2(20)
,INFO_REQ_STATUS              VARCHAR2(20)
,GWF_REQUEST_TYPE             VARCHAR2(1)
,GWF_RETRY_CALL               VARCHAR2(1)
,GWF_LTR_MAILED               VARCHAR2(1)
,ASF_RECEIVE_INFO_REQ         VARCHAR2(1)
,ASF_PROCESS_IMAGE            VARCHAR2(1) DEFAULT 'N'
,ASF_PERFORM_OUTBOUND_CALL    VARCHAR2(1) DEFAULT 'N'
,ASF_CREATE_NEW_CALL_REQ      VARCHAR2(1) DEFAULT 'N'
,ASF_MAIL_LETTER_REQ          VARCHAR2(1) DEFAULT 'N'
,ASF_CREATE_NEW_LETTER_REQ    VARCHAR2(1) DEFAULT 'N' 
,STAGE_DONE_DATE              DATE 
,INSTANCE_COMPLETE_DT         DATE
,INSTANCE_STATUS              VARCHAR2(10) DEFAULT 'Active' NOT NULL
,CANCEL_DATE                  DATE
,CALL_FLAG                    VARCHAR2(1)
,CALL_RETRY_FLAG              VARCHAR2(1)
,CALL_SUCCESS_RESULT          VARCHAR2(40)
,CALL_RETRY_LIMIT             NUMBER(10)
,CALL_RETRY_CT                NUMBER(10)
,CALL_RESULT                  VARCHAR2(1)
,CASE_ID                      NUMBER(18)  
,APP_ID                       NUMBER(18)  
,APP_STATUS                   VARCHAR2(40)
,NO_CALL_IND                  VARCHAR2(1) 
,AUTH_END_DATE                DATE
,RFE_STATUS                   VARCHAR2(30)
,MI_EXISTS                    VARCHAR2(1) DEFAULT 'N' NOT NULL
,CALL_STATUS_DT               DATE
,EVENT_TYPE_CD                VARCHAR2(80)
,NEW_CALL_REQ_ID              NUMBER(18)
,LETTER_IMAGE_LINK_DT         DATE
,LETTER_REQ_DT                DATE
,LETTER_STATUS_DT             DATE
,NEW_LTR_REQ_ID               NUMBER(18)
,INFO_REQ_SENT_DT             DATE
,MAN_LETTER_FLAG              VARCHAR2(1) DEFAULT 'N'
,DISTRICT                     VARCHAR2(80)
,SEND_IEDR_DT                 DATE
,IEDR_ERROR_FLAG              VARCHAR2(1)
,INFO_REQ_CYCLE_END_DT        DATE
,INFO_REQ_CYCLE_START_DT      DATE
,SLA_DAYS                     NUMBER(10)
,SLA_DAYS_TYPE                VARCHAR2(1)
,SLA_JEOPARDY_DT              DATE
,SLA_JEOPARDY_DAYS            NUMBER(10)
,SLA_TARGET_DAYS              NUMBER(10)
, ASPB_CREATE_NEW_LETTER_REQ   VARCHAR2(100)
, ASPB_CREATE_NEW_CALL_REQ     VARCHAR2(100)
, ASPB_NEW_LETTER_REQ          VARCHAR2(100)
, ASED_CREATE_REFERRAL         VARCHAR2(100)
, ASPB_CREATE_REFERRAL         VARCHAR2(100)
, ASSD_CREATE_REFERRAL         VARCHAR2(100)
, ASPB_MAIL_LETTER_REQUEST     VARCHAR2(100)
, ASPB_PERFORM_OUTBOUND_CALL   VARCHAR2(100)
, ASPB_PROCESS_IMAGE           VARCHAR2(100)
, ASPB_RECEIVE_INFO_REQUEST    VARCHAR2(100)
, ASED_RECEIVE_INFO_REQ        DATE
, ASSD_RECEIVE_INFO_REQ        DATE
, ASED_PROCESS_IMAGE           DATE
, ASSD_PROCESS_IMAGE           DATE
, ASED_PERFORM_OUTBOUND_CALL   DATE
, ASSD_PERFORM_OUTBOUND_CALL   DATE
, ASED_CREATE_NEW_CALL_REQ     DATE
, ASSD_CREATE_NEW_CALL_REQ     DATE
, ASED_MAIL_LETTER_REQ         DATE
, ASSD_MAIL_LETTER_REQ         DATE
, ASSD_CREATE_NEW_LETTER_REQ   DATE
, ASED_CREATE_NEW_LETTER_REQ   DATE
,NEW_IND                      VARCHAR2(1) DEFAULT 'Y' NOT NULL
,APP_IN_PROCESS               VARCHAR2(1) DEFAULT 'Y' NOT NULL
,EVENT_STAGING_ID             NUMBER(18)
,ETL_L_DIALER_RESPONSE_ID     NUMBER(18)
,LETTER_TYPES                 VARCHAR2(5)
,INSTANCE_TYPE_CODE           VARCHAR2(40)
,APP_EXTRACT_COMPLETE_DT      DATE 
,STG_LAST_PROCESSED_DT        DATE
)
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

/* Primary Key 
CREATE UNIQUE INDEX sendinfotradpart_b_stg_pk_idx ON sendinfotradpart_bpm_stg
(INREQ_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;
*/
ALTER TABLE sendinfotradpart_bpm_stg
  ADD CONSTRAINT sendinfotradpart_bpm_stg_pk
  PRIMARY KEY (INREQ_ID)
  USING INDEX TABLESPACE MAXDAT_INDX;

/* Unique Index for Info Request */
CREATE UNIQUE INDEX sendinfotradpart_b_stg_uk_idx ON sendinfotradpart_bpm_stg
( INFO_REQ_SOURCE , INFO_REQ_ID )
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;

/* Check Constraints */
ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
CONSTRAINT sendinfotradpart_bpm_stg_i
 CHECK (ITM_INDICATOR IN ('I', 'U',  'D', NULL))
 ENABLE
 VALIDATE;
 
ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
CONSTRAINT sendinfotradpart_bpm_stg_C01
 CHECK (GWF_REQUEST_TYPE IN ('C', 'I',  'R', 'L'))
 ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C02
  CHECK (GWF_RETRY_CALL IN ('C', 'D', 'R'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C03
  CHECK (GWF_LTR_MAILED IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C04
  CHECK (ASF_RECEIVE_INFO_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C05
  CHECK (ASF_PROCESS_IMAGE IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C06
  CHECK (ASF_PERFORM_OUTBOUND_CALL IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C07
  CHECK (ASF_CREATE_NEW_CALL_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C08
  CHECK (ASF_MAIL_LETTER_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C09
  CHECK (ASF_CREATE_NEW_LETTER_REQ IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C10
  CHECK (INSTANCE_STATUS IN ( 'Active','Complete'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C11
  CHECK (INFO_REQ_SOURCE IN ('Letter Req','Event','DCN','IEDR','CIN'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C12
  CHECK (INFO_REQ_GROUP IN ('Letter','Material Request','Outbound Call','Image','Referral'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C13
  CHECK (CALL_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C14
  CHECK (CALL_RESULT IN ('V', 'T', 'E', 'B', 'F', 'H', 'I', 'R'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C15
  CHECK (MAN_LETTER_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C16
  CHECK (IEDR_ERROR_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C17
  CHECK (SLA_DAYS_TYPE IN ('B','C'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C19
  CHECK (NEW_IND IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.sendinfotradpart_bpm_stg ADD 
 CONSTRAINT sendinfotradpart_bpm_stg_C20
  CHECK (CALL_RETRY_FLAG IN ('Y','N'))
  ENABLE
 VALIDATE;
 
/* Public Synonym for Table */
CREATE PUBLIC SYNONYM sendinfotradpart_bpm_stg FOR MAXDAT.sendinfotradpart_bpm_stg;

/* Grants for Table */
GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.sendinfotradpart_bpm_stg TO MAXDAT_OLTP_SIU;

GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.sendinfotradpart_bpm_stg TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON sendinfotradpart_bpm_stg to MAXDAT_READ_ONLY;

/* Create Sequence, Public Synonym and Grants */
CREATE SEQUENCE SEQ_INREQ
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE PUBLIC SYNONYM SEQ_INREQ FOR MAXDAT.SEQ_INREQ;

GRANT SELECT ON MAXDAT.SEQ_INREQ TO MAXDAT_OLTP_SIU;

GRANT SELECT ON MAXDAT.SEQ_INREQ TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.SEQ_INREQ TO MAXDAT_READ_ONLY;

/* Trigger on Table */
CREATE OR REPLACE TRIGGER trg_biu_sendinfotp_b_stg 
BEFORE INSERT OR UPDATE ON sendinfotradpart_bpm_stg
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :n.inreq_id IS NULL THEN
      :n.inreq_id := seq_inreq.NEXTVAL;
    END IF;
    :n.itm_insert_ts := SYSDATE;
  END IF;
  :n.itm_update_ts := SYSDATE;
END trg_biu_sendinfotp_b_stg;
/