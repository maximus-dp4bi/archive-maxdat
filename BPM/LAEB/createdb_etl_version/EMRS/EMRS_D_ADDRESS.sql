CREATE SEQUENCE  "EMRS_SEQ_ADDRESS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ADDRESS_ID" TO &role_name;

-- Create table
CREATE TABLE EMRS_D_ADDRESS
 (  dp_address_id NUMBER not null,      
    addr_id NUMBER(18,0),
    client_id NUMBER(18,0),    
    case_id NUMBER(18,0),
    addr_street_1 VARCHAR2(55),
    addr_street_2 VARCHAR2(55),
    addr_city VARCHAR2(30),
    addr_state_cd VARCHAR2(20),
    addr_zip VARCHAR2(32),
    addr_zip_four VARCHAR2(4),
    addr_type_cd VARCHAR2(32),
    addr_begin_date DATE,
    addr_end_date DATE,
    addr_country VARCHAR2(20),
    addr_attn VARCHAR2(55),
    addr_house_code VARCHAR2(10),
    addr_bar_code VARCHAR2(50),
    addr_origin_cd VARCHAR2(2),
    addr_staff_id NUMBER(38,0),
    addr_ctlk_id VARCHAR2(32),
    addr_dolk_id VARCHAR2(32),
    addr_prov_id NUMBER(38,0),
    addr_payc_id NUMBER(38,0),
    addr_verified VARCHAR2(1),
    addr_verified_date DATE,
    advy_id NUMBER(38,0),
    addr_bad_date DATE,
    addr_bad_date_satisfied DATE,    
    start_ndt NUMBER(18,0),
    end_ndt NUMBER(18,0),
    comparable_key VARCHAR2(2000),
    addr_bad_date_1 DATE,
    record_name VARCHAR2(80),
    record_date DATE,
    record_time VARCHAR2(10),
    modified_name VARCHAR2(80),
    modified_date DATE,
    modified_time VARCHAR2(10),
    updated_by VARCHAR2(80),
    date_updated DATE,
    created_by VARCHAR2(80),
    date_created DATE,
    case_residence_flag VARCHAR2(1),
    case_mailing_flag VARCHAR2(1),
    client_residence_flag VARCHAR2(1),
    client_mailing_flag VARCHAR2(1)
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
create index IDX2_ADDRESSNUM on EMRS_D_ADDRESS (ADDR_ID)
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
  
create index IDX3_ADDRCLIENTNUM on EMRS_D_ADDRESS (CLIENT_ID)
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
  
create index IDX4_ADDRCASENUM on EMRS_D_ADDRESS (CASE_ID)
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
alter table EMRS_D_ADDRESS
  add constraint ADDRESS_PK primary key (DP_ADDRESS_ID)
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
grant select on EMRS_D_ADDRESS to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_ADDR"
 BEFORE INSERT OR UPDATE
 ON emrs_d_address
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ADDRESS.dp_address_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_address_id IS NULL THEN
        SElECT EMRS_SEQ_ADDRESS_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_address_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_ADDR;
/

ALTER TRIGGER "BUIR_ADDR" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CSCL_RES_ADDR_SV
AS
 SELECT 
    addr.addr_id AS ADDRESS_ID ,
    addr.case_id AS CASE_NUMBER ,
    addr.client_id AS CLIENT_ID ,
    COALESCE(addr.addr_type_cd, 'UD') AS ADDR_TYPE_CD ,
    addr.addr_attn AS ADDR_ATTN ,
    addr.addr_house_code AS ADDR_HOUSE_CODE ,
    addr.addr_street_1 AS ADDR_STREET_1 ,
    addr.addr_street_2 AS ADDR_STREET_2 ,
    addr.addr_city AS ADDR_CITY ,
    addr.addr_state_cd AS ADDR_STATE_CD ,
    addr.addr_zip AS ADDR_ZIP ,
    addr.addr_zip_four AS ADDR_ZIP_FOUR ,
    addr.addr_country AS ADDR_COUNTRY ,
    addr.addr_begin_date AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(addr.addr_end_date, TO_DATE('12/31/2050','mm/dd/yyyy')) AS SOURCE_ADDR_END_DATE,
    addr.start_ndt AS START_NDT ,
    addr.end_ndt AS END_NDT ,
    addr.addr_bar_code AS ADDR_BAR_CODE ,
    addr.addr_origin_cd AS ADDR_ORIGIN_CD ,
    addr.addr_staff_id AS ADDR_STAFF_ID ,
    addr.addr_ctlk_id AS ADDR_CTLK_ID ,
    addr.addr_dolk_id AS ADDR_DOLK_ID ,
    addr.addr_prov_id AS ADDR_PROV_ID ,
    addr.addr_payc_id AS ADDR_PAYC_ID ,
    addr.addr_verified AS ADDR_VERIFIED ,
    addr.addr_verified_date AS ADDR_VERIFIED_DATE ,
    addr.advy_id AS ADVY_ID ,
    addr.addr_bad_date AS ADDR_BAD_DATE ,
    addr.addr_bad_date_satisfied AS ADDR_BAD_DATE_SATISFIED ,
    addr.comparable_key AS COMPARABLE_KEY ,
    addr.record_date AS RECORD_DATE ,
    addr.record_time AS RECORD_TIME ,
    addr.record_name AS RECORD_NAME ,
    addr.modified_date AS MODIFIED_DATE ,
    addr.modified_time MODIFIED_TIME ,
    addr.modified_name AS MODIFIED_NAME 
  FROM emrs_d_address addr ;
  
GRANT SELECT ON EMRS_D_CSCL_RES_ADDR_SV TO &role_name;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_RES_ADDR_SV
AS
  SELECT 
    addr.addr_id AS ADDRESS_ID ,
    addr.case_id AS CASE_NUMBER ,
    addr.client_id AS CLIENT_ID ,
    COALESCE(addr.addr_type_cd, 'UD') AS ADDR_TYPE_CD ,
    addr.addr_attn AS ADDR_ATTN ,
    addr.addr_house_code AS ADDR_HOUSE_CODE ,
    addr.addr_street_1 AS ADDR_STREET_1 ,
    addr.addr_street_2 AS ADDR_STREET_2 ,
    addr.addr_city AS ADDR_CITY ,
    addr.addr_state_cd AS ADDR_STATE_CD ,
    addr.addr_zip AS ADDR_ZIP ,
    addr.addr_zip_four AS ADDR_ZIP_FOUR ,
    addr.addr_country AS ADDR_COUNTRY ,
    addr.addr_begin_date AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(addr.addr_end_date, TO_DATE('12/31/2050','mm/dd/yyyy')) AS SOURCE_ADDR_END_DATE,
    addr.start_ndt AS START_NDT ,
    addr.end_ndt AS END_NDT ,
    addr.addr_bar_code AS ADDR_BAR_CODE ,
    addr.addr_origin_cd AS ADDR_ORIGIN_CD ,
    addr.addr_staff_id AS ADDR_STAFF_ID ,
    addr.addr_ctlk_id AS ADDR_CTLK_ID ,
    addr.addr_dolk_id AS ADDR_DOLK_ID ,
    addr.addr_prov_id AS ADDR_PROV_ID ,
    addr.addr_payc_id AS ADDR_PAYC_ID ,
    addr.addr_verified AS ADDR_VERIFIED ,
    addr.addr_verified_date AS ADDR_VERIFIED_DATE ,
    addr.advy_id AS ADVY_ID ,
    addr.addr_bad_date AS ADDR_BAD_DATE ,
    addr.addr_bad_date_satisfied AS ADDR_BAD_DATE_SATISFIED ,
    addr.comparable_key AS COMPARABLE_KEY ,
    addr.record_date AS RECORD_DATE ,
    addr.record_time AS RECORD_TIME ,
    addr.record_name AS RECORD_NAME ,
    addr.modified_date AS MODIFIED_DATE ,
    addr.modified_time MODIFIED_TIME ,
    addr.modified_name AS MODIFIED_NAME 
  FROM emrs_d_address addr;

GRANT SELECT ON EMRS_D_SELECTION_RES_ADDR_SV TO &role_name;
  


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_ADDRESS','ERRLOG_ADDRESS');
  end;
/


-- Create table
create table EMRS_S_ADDRESS_STG
( addr_id NUMBER(18,0),
  addr_street_1 VARCHAR2(55),
  addr_street_2 VARCHAR2(55),
  addr_city VARCHAR2(30),
  addr_state_cd VARCHAR2(20),
  addr_zip VARCHAR2(32),
  addr_zip_four VARCHAR2(4),
  addr_type_cd VARCHAR2(32),
  addr_begin_date DATE,
  addr_end_date DATE,
  addr_country VARCHAR2(20),
  clnt_client_id NUMBER(18,0),
  addr_attn VARCHAR2(55),
  addr_house_code VARCHAR2(10),
  addr_bar_code VARCHAR2(50),
  addr_origin_cd VARCHAR2(2),
  addr_staff_id NUMBER(38,0),
  addr_ctlk_id VARCHAR2(32),
  addr_dolk_id VARCHAR2(32),
  addr_prov_id NUMBER(38,0),
  addr_payc_id NUMBER(38,0),
  addr_verified VARCHAR2(1),
  addr_verified_date DATE,
  advy_id NUMBER(38,0),
  addr_bad_date DATE,
  addr_bad_date_satisfied DATE,
  created_by VARCHAR2(80),
  creation_date DATE,
  last_updated_by VARCHAR2(80),
  last_update_date DATE,
  addr_case_id NUMBER(18,0),
  start_ndt NUMBER(18,0),
  end_ndt NUMBER(18,0),
  comparable_key VARCHAR2(2000),
  addr_bad_date_1 DATE
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
grant select on EMRS_S_ADDRESS_STG to &role_name;

create index STG_IDX2_ADDRESSNUM on EMRS_S_ADDRESS_STG (ADDR_ID)
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


