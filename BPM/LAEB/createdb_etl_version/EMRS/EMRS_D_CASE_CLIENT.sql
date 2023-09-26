CREATE SEQUENCE  "EMRS_SEQ_CASECLIENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CASECLIENT_ID" TO &role_name;

-- Create table
CREATE TABLE EMRS_D_CASE_CLIENT
 (  dp_case_client_id NUMBER not null,
    case_client_id	NUMBER(18,0),
    case_id	NUMBER(18,0),
    client_id	NUMBER(18,0),    
    cscl_status_begin_date	DATE,
    cscl_close_reason	VARCHAR2(240),
    cscl_relationship_cd	VARCHAR2(32),
    cscl_elig_determination_date	DATE,
    cscl_medical_ind	VARCHAR2(1),
    cscl_status_end_date	DATE,
    cscl_byb_temp_id	VARCHAR2(32),
    cscl_appl_client_id	NUMBER(18,0),
    cscl_actual_term_date	DATE, 
    cscl_pacmis_status_cd	VARCHAR2(32),
    cscl_legacy	VARCHAR2(1),
    rhsp	VARCHAR2(1),
    rhga	VARCHAR2(1),
    cscl_status_cd	VARCHAR2(2),
    cscl_adlk_id	VARCHAR2(32),
    cscl_res_addr_id	NUMBER(18,0),
    cscl_elig_begin_dt	DATE,
    cscl_elig_end_dt	DATE,
    anniversary_dt	DATE,
    program_cd	VARCHAR2(32),
    program_status_cd	VARCHAR2(32),
    elig_begin_nd	NUMBER(8,0),
    elig_end_nd	NUMBER(8,0),
    episode_id	NUMBER(18,0),
    cscl_generic_field1_date	DATE,
    cscl_generic_field2_date	DATE,
    cscl_generic_field3_num	NUMBER(18,0),
    cscl_generic_field4_num	NUMBER(18,0),
    cscl_generic_field5_txt	VARCHAR2(256),
    cscl_generic_field6_txt	VARCHAR2(256),
    cscl_generic_field7_txt	VARCHAR2(256),
    cscl_generic_field8_txt	VARCHAR2(256),
    cscl_generic_field9_txt	VARCHAR2(256),
    cscl_generic_field10_txt	VARCHAR2(256),
    cscl_generic_ref11_id	NUMBER(18,0),
    cscl_generic_ref12_id	NUMBER(18,0),
    status_begin_ndt	NUMBER(18,0),
    status_end_ndt	NUMBER(18,0),
    change_notes	VARCHAR2(1024),
    record_name VARCHAR2(80),
    record_date DATE,
    record_time VARCHAR2(10),
    modified_name VARCHAR2(80),
    modified_date DATE,
    modified_time VARCHAR2(10),
    updated_by VARCHAR2(80),
    date_updated DATE,
    created_by VARCHAR2(80),
    date_created DATE
)
tablespace &tablespace_name
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
-- Create/Recreate indexes 
create index IDX2_CSCLNUM on EMRS_D_CASE_CLIENT (CASE_CLIENT_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create index IDX3_CSCLNUM on EMRS_D_CASE_CLIENT (CLIENT_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
create index IDX4_CSCLNUM on EMRS_D_CASE_CLIENT (CASE_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table EMRS_D_CASE_CLIENT
  add constraint CSCL_PK primary key (DP_CASE_CLIENT_ID)
  using index 
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
 
-- Grant/Revoke object privileges 
grant select on EMRS_D_CASE_CLIENT to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_CSCL"
 BEFORE INSERT OR UPDATE
 ON emrs_d_case_client
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CASE_CLIENT.dp_case_client_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_case_client_id IS NULL THEN
        SElECT EMRS_SEQ_CASECLIENT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_case_client_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_CSCL;
/

ALTER TRIGGER "BUIR_CSCL" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CASE_CLIENT_SV
AS
  SELECT 
    case_client_id AS CASE_CLIENT_ID,
    case_id AS CASE_ID,
    client_id AS CLIENT_ID,
    anniversary_dt AS ANNIVERSARY_DT,
    cscl_elig_begin_dt AS CSCL_ELIG_BEGIN_DT,
    cscl_elig_end_dt AS CSCL_ELIG_END_DT,
    elig_begin_nd AS ELIG_BEGIN_ND,
    elig_end_nd AS ELIG_END_ND,
    cscl_elig_determination_date AS CSCL_ELIG_DETERMINATION_DATE,
    cscl_status_cd AS CSCL_STATUS_CD,
    cscl_status_begin_date AS CSCL_STATUS_BEGIN_DATE,
    cscl_status_end_date AS CSCL_STATUS_END_DATE,
    status_begin_ndt AS STATUS_BEGIN_NDT,
    status_end_ndt AS STATUS_END_NDT,
    cscl_close_reason AS CSCL_CLOSE_REASON,
    COALESCE(cscl_relationship_cd, '0') AS CSCL_RELATIONSHIP_CD,
    cscl_medical_ind AS CSCL_MEDICAL_IND,
    COALESCE(cscl_adlk_id, '0') AS CSCL_ADLK_ID,
    COALESCE(cscl_res_addr_id, 0) AS CSCL_RES_ADDR_ID,
    program_cd AS MANAGED_CARE_PROGRAM,
    change_notes AS CHANGE_NOTES,
    cscl_appl_client_id AS CSCL_APPL_CLIENT_ID,
    cscl_byb_temp_id AS CSCL_BYB_TEMP_ID,
    cscl_actual_term_date AS  CSCL_ACTUAL_TERM_DATE,
    cscl_legacy AS CSCL_LEGACY,
    cscl_pacmis_status_cd AS CSCL_PACMIS_STATUS_CD,
    episode_id AS EPISODE_ID,
    program_status_cd AS PROGRAM_STATUS_CD,
    rhsp AS RHSP,
    rhga AS RHGA,
    modified_date AS MODIFIED_DATE,
    modified_time AS MODIFIED_TIME,
    modified_name AS MODIFIED_NAME,
    record_date AS RECORD_DATE,
    record_time AS RECORD_TIME,
    record_name AS RECORD_NAME
  FROM emrs_d_case_client ;
  
GRANT SELECT ON EMRS_D_CASE_CLIENT_SV TO &role_name;


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CASE_CLIENT','ERRLOG_CSCL');
  end;
/


-- Create table
create table EMRS_S_CASE_CLIENT_STG
(
    cscl_id	NUMBER(18,0),
    cscl_case_id	NUMBER(18,0),
    cscl_clnt_client_id	NUMBER(18,0),    
    cscl_status_begin_date	DATE,
    cscl_close_reason	VARCHAR2(240),
    cscl_relationship_cd	VARCHAR2(32),
    cscl_elig_determination_date	DATE,
    cscl_medical_ind	VARCHAR2(1),
    cscl_status_end_date	DATE,
    cscl_byb_temp_id	VARCHAR2(32),
    cscl_appl_client_id	NUMBER(18,0),
    cscl_actual_term_date	DATE,
    created_by	VARCHAR2(80),
    creation_date	DATE,
    last_updated_by	VARCHAR2(80),
    last_update_date	DATE,
    cscl_pacmis_status_cd	VARCHAR2(32),
    cscl_legacy	VARCHAR2(1),
    rhsp	VARCHAR2(1),
    rhga	VARCHAR2(1),
    cscl_status_cd	VARCHAR2(2),
    cscl_adlk_id	VARCHAR2(32),
    cscl_res_addr_id	NUMBER(18,0),
    cscl_elig_begin_dt	DATE,
    cscl_elig_end_dt	DATE,
    anniversary_dt	DATE,
    program_cd	VARCHAR2(32),
    program_status_cd	VARCHAR2(32),
    elig_begin_nd	NUMBER(8,0),
    elig_end_nd	NUMBER(8,0),
    episode_id	NUMBER(18,0),
    cscl_generic_field1_date	DATE,
    cscl_generic_field2_date	DATE,
    cscl_generic_field3_num	NUMBER(18,0),
    cscl_generic_field4_num	NUMBER(18,0),
    cscl_generic_field5_txt	VARCHAR2(256),
    cscl_generic_field6_txt	VARCHAR2(256),
    cscl_generic_field7_txt	VARCHAR2(256),
    cscl_generic_field8_txt	VARCHAR2(256),
    cscl_generic_field9_txt	VARCHAR2(256),
    cscl_generic_field10_txt	VARCHAR2(256),
    cscl_generic_ref11_id	NUMBER(18,0),
    cscl_generic_ref12_id	NUMBER(18,0),
    status_begin_ndt	NUMBER(18,0),
    status_end_ndt	NUMBER(18,0),
    change_notes	VARCHAR2(1024)   
)
tablespace &tablespace_name
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
  
-- Grant/Revoke object privileges 
grant select on EMRS_S_CASE_CLIENT_STG to &role_name;

create index STG_IDX2_CSCLNUM on EMRS_S_CASE_CLIENT_STG (CSCL_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


