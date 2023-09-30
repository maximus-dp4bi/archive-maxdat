CREATE SEQUENCE  "EMRS_SEQ_ELIG_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ELIG_ID" TO &role_name;


create table EMRS_D_CLIENT_ELIGIBILITY
(
  dp_client_elig_status_id NUMBER not null, 
  client_elig_status_id NUMBER(18,0),
  client_id NUMBER(18,0),
  plan_type_cd VARCHAR2(32),
  elig_status_cd VARCHAR2(32),
  start_date DATE,
  end_date DATE,
  program_cd VARCHAR2(32),
  sub_status_codes VARCHAR2(256),
  reasons VARCHAR2(256),
  mvx_core_reason VARCHAR2(256),
  debug VARCHAR2(2000),
  start_ndt NUMBER(18,0),
  end_ndt NUMBER(18,0),
  disposition_cd VARCHAR2(32),
  subprogram_type VARCHAR2(32),
  modified_date DATE,
  modified_name VARCHAR2(50),
  modified_time VARCHAR2(10),
  record_date   DATE,
  record_time   VARCHAR2(10),
  record_name   VARCHAR2(80),
  updated_by    VARCHAR2(20),
  created_by    VARCHAR2(80),
  date_created  DATE,
  date_updated  DATE
)
TABLESPACE &tablespace_name
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
create index IDX2_ELIGNUM on EMRS_D_CLIENT_ELIGIBILITY (client_elig_status_id)
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

create index IDX2_ELIGCLIENTNUM on EMRS_D_CLIENT_ELIGIBILITY (CLIENT_ID)
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

alter table EMRS_D_CLIENT_ELIGIBILITY
  add constraint CLIENTELIG_PK primary key (dp_client_elig_status_id)
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

grant select on EMRS_D_CLIENT_ELIGIBILITY to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_ELIGIBILITY"
 BEFORE INSERT OR UPDATE
 ON emrs_d_client_eligibility
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_ELIGIBILITY.dp_client_elig_status_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_client_elig_status_id IS NULL THEN
        SElECT EMRS_SEQ_ELIG_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_client_elig_status_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;
  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;


END BUIR_ELIGIBILITY;
/


ALTER TRIGGER "BUIR_ELIGIBILITY" ENABLE;
/


create table EMRS_S_ELIGIBILITY_STG
(client_elig_status_id NUMBER(18,0),
  plan_type_cd VARCHAR2(32),
  elig_status_cd VARCHAR2(32),
  start_date DATE,
  end_date DATE,
  create_ts DATE,
  created_by VARCHAR2(80),
  update_ts DATE,
  updated_by VARCHAR2(80),
  client_id NUMBER(18,0),
  program_cd VARCHAR2(32),
  sub_status_codes VARCHAR2(256),
  reasons VARCHAR2(256),
  mvx_core_reason VARCHAR2(256),
  debug VARCHAR2(2000),
  start_ndt NUMBER(18,0),
  end_ndt NUMBER(18,0),
  disposition_cd VARCHAR2(32),
  subprogram_type VARCHAR2(32)
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

create index STG_IDX2_ELIGNUM on EMRS_S_ELIGIBILITY_STG (client_elig_status_id)
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
grant select on EMRS_S_ELIGIBILITY_STG to &role_name;

begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CLIENT_ELIGIBILITY','ERRLOG_ELIG');
end;
 /

CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_ELIG_SV
AS
  SELECT
    client_elig_status_id AS CLIENT_PLAN_ELIGIBILITY_ID ,
    client_id AS CLIENT_ID ,     
    elig_status_cd AS CURRENT_ELIGIBILITY_STATUS_CD ,
    COALESCE(elig_status_cd, '0') AS ELIGIBILITY_STATUS_CODE ,
    COALESCE(plan_type_cd, '0') AS PLAN_TYPE ,
    program_cd AS MANAGED_CARE_PROGRAM,
    CASE
      WHEN end_date IS NULL
      THEN 'Y'
      ELSE 'N'
    END AS CURRENT_FLAG ,
    subprogram_type AS SUB_PROGRAM_CODE ,
    start_date AS START_DATE,
    end_date AS END_DATE,
    start_date AS DATE_OF_VALIDITY_START ,
    COALESCE(end_date, TO_DATE('12/31/2050','mm/dd/yyyy')) AS DATE_OF_VALIDITY_END ,
    RECORD_DATE ,
    RECORD_NAME ,
    MODIFIED_DATE ,
    MODIFIED_NAME 
  FROM emrs_d_client_eligibility;

grant select on EMRS_D_CLIENT_PLAN_ELIG_SV to &role_name;

            
