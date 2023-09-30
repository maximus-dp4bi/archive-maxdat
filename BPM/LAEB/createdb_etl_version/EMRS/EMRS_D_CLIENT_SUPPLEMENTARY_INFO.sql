CREATE SEQUENCE  "EMRS_SEQ_CLIENTSUPP_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLIENTSUPP_ID" TO &role_name;

-- Create table
CREATE TABLE EMRS_D_CLIENT_SUPPLEMENTARY_INFO
 (  dp_client_supp_info_id NUMBER not null, 
    client_id	NUMBER(18,0),
    case_client_id	NUMBER(18,0),
    case_id	NUMBER(18,0),
    case_cin	VARCHAR2(30),
    hoh_id	NUMBER(18,0),
    case_status	VARCHAR2(2),
    case_client_status	VARCHAR2(2),
    last_name	VARCHAR2(40),
    last_name_canon	VARCHAR2(40),
    last_name_soundlike	VARCHAR2(64),
    first_name	VARCHAR2(25),
    first_name_canon	VARCHAR2(25),
    first_name_soundlike	VARCHAR2(64),
    middle_initial	VARCHAR2(25),
    client_cin	VARCHAR2(30),
    ssn	VARCHAR2(30),
    gender_cd	VARCHAR2(32),
    dob	DATE,
    dob_num	NUMBER(8,0),
    client_type_cd	VARCHAR2(10),
    addr_id	NUMBER(18,0),
    addr_type_cd	VARCHAR2(32),
    addr_county	VARCHAR2(32),
    addr_zip	VARCHAR2(32),
    addr_zip_four	VARCHAR2(4),
    addr_attn	VARCHAR2(55),
    addr_street_1	VARCHAR2(55),
    addr_street_2	VARCHAR2(55),
    addr_city	VARCHAR2(30),
    addr_bad_date	DATE,
    addr_bad_date_satisfied	DATE,
    case_created_by	VARCHAR2(80),
    case_create_ts	DATE,
    case_updated_by	VARCHAR2(80),
    case_update_ts	DATE,
    program_cd	VARCHAR2(32),
    addr_state_cd	VARCHAR2(20),
    addr_country	VARCHAR2(20),
    clnt_generic_field1_date	DATE,
    clnt_generic_field2_date	DATE,
    clnt_generic_field3_num	NUMBER(18,0),
    clnt_generic_field4_num	NUMBER(18,0),
    clnt_generic_field5_txt	VARCHAR2(256),
    clnt_generic_field6_txt	VARCHAR2(256),
    clnt_generic_field7_txt	VARCHAR2(256),
    clnt_generic_field8_txt	VARCHAR2(256),
    clnt_generic_field9_txt	VARCHAR2(256),
    clnt_generic_field10_txt	VARCHAR2(256),
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
create index IDX2_CLIENTSINUM on EMRS_D_CLIENT_SUPPLEMENTARY_INFO (CASE_CLIENT_ID)
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
  
create index IDX3_CLIENTSINUM on EMRS_D_CLIENT_SUPPLEMENTARY_INFO (CLIENT_ID)
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
  
create index IDX4_CLIENTSINUM on EMRS_D_CLIENT_SUPPLEMENTARY_INFO (CASE_ID)
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
alter table EMRS_D_CLIENT_SUPPLEMENTARY_INFO
  add constraint CLIENTSUPP_PK primary key (DP_CLIENT_SUPP_INFO_ID)
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
grant select on EMRS_D_CLIENT_SUPPLEMENTARY_INFO to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_CSI"
 BEFORE INSERT OR UPDATE
 ON emrs_d_client_supplementary_info
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_SUPPLEMENTARY_INFO.dp_client_supp_info_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_client_supp_info_id IS NULL THEN
        SElECT EMRS_SEQ_CLIENTSUPP_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_client_supp_info_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_CSI;
/

ALTER TRIGGER "BUIR_CSI" ENABLE;
/

CREATE OR REPLACE VIEW D_CLIENT_SUPPLEMENTARY_INFO_SV
AS
SELECT client_id
      ,case_client_id
      ,case_id
      ,case_cin
      ,hoh_id
      ,case_status
      ,case_client_status
      ,last_name
      ,last_name_canon
      ,last_name_soundlike
      ,first_name
      ,first_name_canon
      ,first_name_soundlike
      ,middle_initial
      ,client_cin
      ,ssn
      ,gender_cd
      ,dob
      ,dob_num
      ,client_type_cd
      ,addr_id
      ,addr_type_cd
      ,addr_county
      ,addr_zip
      ,addr_zip_four
      ,addr_attn
      ,addr_street_1
      ,addr_street_2
      ,addr_city
      ,addr_bad_date
      ,addr_bad_date_satisfied
      ,record_name AS created_by
      ,record_date AS create_ts
      ,modified_name AS updated_by
      ,modified_date AS update_ts
      ,case_created_by
      ,case_create_ts
      ,case_updated_by
      ,case_update_ts
      ,program_cd
      ,addr_state_cd
      ,addr_country
      ,clnt_generic_field1_date
      ,clnt_generic_field2_date
      ,clnt_generic_field3_num
      ,clnt_generic_field4_num
      ,clnt_generic_field5_txt
      ,clnt_generic_field6_txt
      ,clnt_generic_field7_txt
      ,clnt_generic_field8_txt
      ,clnt_generic_field9_txt
      ,clnt_generic_field10_txt
FROM emrs_d_client_supplementary_info;

GRANT SELECT ON D_CLIENT_SUPPLEMENTARY_INFO_SV TO &role_name;


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CLIENT_SUPPLEMENTARY_INFO','ERRLOG_CLIENTSUPPINFO');
  end;
/


-- Create table
create table EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG
(
    client_id	NUMBER(18,0),
    case_client_id	NUMBER(18,0),
    case_id	NUMBER(18,0),
    case_cin	VARCHAR2(30),
    hoh_id	NUMBER(18,0),
    case_status	VARCHAR2(2),
    case_client_status	VARCHAR2(2),
    last_name	VARCHAR2(40),
    last_name_canon	VARCHAR2(40),
    last_name_soundlike	VARCHAR2(64),
    first_name	VARCHAR2(25),
    first_name_canon	VARCHAR2(25),
    first_name_soundlike	VARCHAR2(64),
    middle_initial	VARCHAR2(25),
    client_cin	VARCHAR2(30),
    ssn	VARCHAR2(30),
    gender_cd	VARCHAR2(32),
    dob	DATE,
    dob_num	NUMBER(8,0),
    client_type_cd	VARCHAR2(10),
    addr_id	NUMBER(18,0),
    addr_type_cd	VARCHAR2(32),
    addr_county	VARCHAR2(32),
    addr_zip	VARCHAR2(32),
    addr_zip_four	VARCHAR2(4),
    addr_attn	VARCHAR2(55),
    addr_street_1	VARCHAR2(55),
    addr_street_2	VARCHAR2(55),
    addr_city	VARCHAR2(30),
    addr_bad_date	DATE,
    addr_bad_date_satisfied	DATE,
    created_by	VARCHAR2(80),
    create_ts	DATE,
    updated_by	VARCHAR2(80),
    update_ts	DATE,
    case_created_by	VARCHAR2(80),
    case_create_ts	DATE,
    case_updated_by	VARCHAR2(80),
    case_update_ts	DATE,
    program_cd	VARCHAR2(32),
    addr_state_cd	VARCHAR2(20),
    addr_country	VARCHAR2(20),
    clnt_generic_field1_date	DATE,
    clnt_generic_field2_date	DATE,
    clnt_generic_field3_num	NUMBER(18,0),
    clnt_generic_field4_num	NUMBER(18,0),
    clnt_generic_field5_txt	VARCHAR2(256),
    clnt_generic_field6_txt	VARCHAR2(256),
    clnt_generic_field7_txt	VARCHAR2(256),
    clnt_generic_field8_txt	VARCHAR2(256),
    clnt_generic_field9_txt	VARCHAR2(256),
    clnt_generic_field10_txt	VARCHAR2(256)      
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
--grant select, insert, update on EMRS_S_CLIENT_STG to MAXDAT_OLTP_SIU;
--grant select, insert, update, delete on EMRS_S_CLIENT_STG to MAXDAT_OLTP_SIUD;
grant select on EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG to &role_name;

create index STG_IDX2_CLIENTSUPP on EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG (CASE_CLIENT_ID)
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


