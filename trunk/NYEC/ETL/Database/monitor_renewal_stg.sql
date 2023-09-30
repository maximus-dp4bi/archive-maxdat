CREATE TABLE monitor_renewal_stg
( APP_ID    NUMBER  NOT NULL 
, AGE_IN_BUSINESS_DAYS NUMBER(10) DEFAULT 0 NOT NULL
, AGE_IN_CALENDAR_DAYS NUMBER(10) DEFAULT 0 NOT NULL
, APP_STATUS           VARCHAR2(40)
, APP_STATUS_DT        DATE
, INSTANCE_COMPLETE_DT DATE
, INSTANCE_STATUS      VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL
, REN_FILE_RECEIPT_DT  DATE
, SHELL_CREATE_DT      DATE
, SHELL_CREATED_BY     VARCHAR2(80) DEFAULT 'DOH'
, REN_RECEIPT_DT       DATE
, AUTH_CHG_DT          DATE
, AUTH_END_DT          DATE
, NEW_AUTH_END_DT      DATE
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
, APP_IN_PROCESS       VARCHAR2(1) DEFAULT 'Y' NOT NULL
, APP_EXTRACT_COMPLETE_DT DATE 
, STG_LAST_PROCESSED_DT DATE  )
;

/* Primary Key */
CREATE UNIQUE INDEX monitor_renewal_stg_pk_idx ON monitor_renewal_stg
(APP_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;

ALTER TABLE monitor_renewal_stg
  ADD CONSTRAINT monitor_renewal_stg_pk
  PRIMARY KEY (APP_ID);

/* Public Synonym for Table */
--CREATE PUBLIC SYNONYM monitor_renewal_stg FOR MAXDAT.monitor_renewal_stg;

/* Grants for Table */
--GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.monitor_renewal_stg TO MAXDAT_OLTP_SIU;
--GRANT SELECT, INSERT, UPDATE, DELETE ON MAXDAT.monitor_renewal_stg TO MAXDAT_OLTP_SIUD;
--GRANT SELECT ON monitor_renewal_stg to MAXDAT_READ_ONLY;
 