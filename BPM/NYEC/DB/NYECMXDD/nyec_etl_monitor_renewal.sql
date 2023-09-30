CREATE TABLE nyec_etl_monitor_renewal
( CEMR_ID              NUMBER(18) NOT NULL
, APP_ID               NUMBER(18) NOT NULL
, AGE_IN_BUSINESS_DAYS NUMBER(10) NOT NULL
, AGE_IN_CALENDAR_DAYS NUMBER(10) NOT NULL
, INSTANCE_COMPLETE_DT DATE
, INSTANCE_STATUS      VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL
, REN_FILE_RECEIPT_DT  DATE
, SHELL_CREATE_DT      DATE
, SHELL_CREATED_BY     VARCHAR2(80)
, REN_RECEIPT_DT       DATE
, AUTH_CHG_DT          DATE
, AUTH_END_DT          DATE
, CANCEL_DT            DATE
, CLOSE_DT             DATE
, CLOCKDOWN_INDICATOR  VARCHAR2(1) DEFAULT 'N' NOT NULL
, STATE_CASE_IDEN      VARCHAR2(20)
, NOTICE_1_TYPE        VARCHAR2(20)
, NOTICE_1_DUE_DT      DATE
, NOTICE_1_CREATE_DT   DATE
, NOTICE_1_COMPLETE_DT DATE
, NOTICE_1_SOURCE_ID   NUMBER(18)
, NOTICE_2_TYPE        VARCHAR2(20)
, NOTICE_2_DUE_DT      DATE
, NOTICE_2_CREATE_DT   DATE
, NOTICE_2_COMPLETE_DT DATE
, NOTICE_2_SOURCE_ID   NUMBER(18)
, NOTICE_3_TYPE        VARCHAR2(20)
, NOTICE_3_DUE_DT      DATE
, NOTICE_3_CREATE_DT   DATE
, NOTICE_3_COMPLETE_DT DATE
, NOTICE_3_SOURCE_ID   NUMBER(18)
, GWF_FILE_PROC_RES    VARCHAR2(1)
, GWF_EXCEPT_RES       VARCHAR2(1)
, STAGE_DONE_DATE      DATE 
, STG_EXTRACT_DATE     DATE NOT NULL
, STG_LAST_UPDATE_DATE DATE NOT NULL )
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
CREATE UNIQUE INDEX nyec_etl_monitor_renewal_pk_idx ON nyec_etl_monitor_renewal
(CEMR_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;

ALTER TABLE nyec_etl_monitor_renewal
  ADD CONSTRAINT nyec_etl_monitor_renewal_pk
  PRIMARY KEY (CEMR_ID);

/* Index for App ID */
CREATE INDEX nyec_etl_monitor_renewal_idx ON nyec_etl_monitor_renewal
(APP_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;

/* Check Constraints */
ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C01
 CHECK (SHELL_CREATED_BY IN ('DOH','JIRA','RELOAD'))
 ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C02
  CHECK (INSTANCE_STATUS IN ('ACTIVE','COMPLETE'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C03
  CHECK (CLOCKDOWN_INDICATOR IN ('Y','N'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C04
  CHECK (NOTICE_1_TYPE IN ('Call','Letter','Other'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C05
  CHECK (NOTICE_2_TYPE IN ('Call','Letter','Other'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C06
  CHECK (NOTICE_3_TYPE IN ('Call','Letter','Other'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C07
  CHECK (GWF_FILE_PROC_RES IN ('P','F'))
  ENABLE
 VALIDATE;
 
 ALTER TABLE MAXDAT.NYEC_ETL_MONITOR_RENEWAL ADD 
 CONSTRAINT NYEC_ETL_MONITOR_RENEWAL_C08
  CHECK (GWF_EXCEPT_RES IN ('D','R','M'))
  ENABLE
 VALIDATE;

/* Public Synonym for Table */
CREATE PUBLIC SYNONYM nyec_etl_monitor_renewal FOR MAXDAT.nyec_etl_monitor_renewal;

/* Grants for Table */
GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.nyec_etl_monitor_renewal TO MAXDAT_OLTP_SIU;

GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.nyec_etl_monitor_renewal TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON nyec_etl_process_app_mi to MAXDAT_READ_ONLY

/* Create Sequence, Public Synonym and Grants */
CREATE SEQUENCE SEQ_CEMR
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE PUBLIC SYNONYM SEQ_CEMR FOR MAXDAT.SEQ_CEMR;

GRANT SELECT ON MAXDAT.SEQ_CEMR TO MAXDAT_OLTP_SIU;

GRANT SELECT ON MAXDAT.SEQ_CEMR TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.SEQ_CEMR TO MAXDAT_READ_ONLY;

/* Trigger on Table */
CREATE OR REPLACE TRIGGER TRG_R_NYEC_ETL_MONITOR_RENEWAL 
  BEFORE INSERT OR
  UPDATE ON nyec_etl_monitor_renewal FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :new.cemr_id IS NULL THEN
      SELECT seq_cemr.NEXTVAL 
        INTO :new.cemr_Id 
        FROM DUAL;
    END IF;
  --
    IF :new.stg_extract_date IS NULL THEN
      :new.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :new.stg_last_update_date := SYSDATE;
END;
