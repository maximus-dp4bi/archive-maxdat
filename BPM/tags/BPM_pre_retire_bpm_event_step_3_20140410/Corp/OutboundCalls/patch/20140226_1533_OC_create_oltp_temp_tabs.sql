-- Create table
create table ETL_E_DIALER_RUN_STG
( job_id                     NUMBER(18) not null
, row_id                     NUMBER(18) not null
, error_count                INTEGER
, client_id                  NUMBER(18)
, case_id                    NUMBER(18)
, phone_ch                   VARCHAR2(32)
, phone_cm                   VARCHAR2(32)
, phone_hm                   VARCHAR2(32)
, language_cd                VARCHAR2(2)
, record_content             VARCHAR2(2000)
, lmreq_id                   NUMBER(18)
, error_text                 VARCHAR2(2000)
, etl_e_834_event_staging_id NUMBER(18)
, job_name        VARCHAR2(80)
, job_group       VARCHAR2(80)
, start_ts        DATE
, end_ts          DATE
, status_cd       VARCHAR2(32)
, create_ts       DATE
, created_by      VARCHAR2(80)
, update_ts       DATE
, updated_by      VARCHAR2(80)
, comments        VARCHAR2(4000)
, filename        VARCHAR2(1000)
, host_name       VARCHAR2(256)
, stage_create_ts            DATE not null
, stage_update_ts            DATE not null
)
tablespace MAXDAT_DATA;



-- Create/Recreate indexes 
create index  ETL_E_DIALER_RUN_STG_INDX1 on ETL_E_DIALER_RUN_STG (JOB_ID) tablespace MAXDAT_INDX;
create index  ETL_E_DIALER_RUN_STG_INDX2 on ETL_E_DIALER_RUN_STG (ROW_ID) tablespace MAXDAT_INDX;
create index  ETL_E_DIALER_RUN_STG_INDX3 on ETL_E_DIALER_RUN_STG (CLIENT_ID) tablespace MAXDAT_INDX;
create index  ETL_E_DIALER_RUN_STG_INDX4 on ETL_E_DIALER_RUN_STG (CASE_ID) tablespace MAXDAT_INDX;
create index  ETL_E_DIALER_RUN_STG_INDX5 on ETL_E_DIALER_RUN_STG (CREATE_TS) tablespace MAXDAT_INDX;


-- Grant/Revoke object privileges 
grant select on ETL_E_DIALER_RUN_STG to MAXDAT_READ_ONLY;



-- Trigger 
alter session set plsql_code_type = native;

CREATE OR REPLACE TRIGGER TRG_BIU_ETL_E_DIALER_RUN_STG
BEFORE INSERT OR UPDATE ON ETL_E_DIALER_RUN_STG
FOR EACH ROW
BEGIN
  IF INSERTING and :NEW.stage_create_ts IS NULL
  THEN :NEW.stage_create_ts := SYSDATE;    
  END IF;

  :NEW.stage_update_ts := SYSDATE;

END TRG_BIU_ETL_E_DIALER_RUN_STG;
/

alter session set plsql_code_type = interpreted;
