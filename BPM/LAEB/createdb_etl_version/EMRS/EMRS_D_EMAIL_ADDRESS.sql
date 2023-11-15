CREATE SEQUENCE  "EMRS_SEQ_EMAIL_ADDRESS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_EMAIL_ADDRESS_ID" TO MAXDAT_LAEB_READ_ONLY;

CREATE TABLE emrs_d_email_address(
dp_email_address_id NUMBER not null,
email_id NUMBER(18,0),
email_begin_date DATE,
email_type_cd VARCHAR2(2),
email_end_date DATE,
client_id NUMBER(18,0),
email_address VARCHAR2(128),
email_dolk_id VARCHAR2(32),
email_case_id NUMBER(18,0),
status_cd VARCHAR2(32),
email_bad_date DATE,
email_bad_date_satisfied DATE,
contact_method_ind NUMBER(1,0),
comparable_key VARCHAR2(2000),
email_begin_ndt NUMBER(18,0),
email_end_ndt NUMBER(18,0),
start_ndt NUMBER(18,0),
end_ndt NUMBER(18,0),
record_name VARCHAR2(80),
record_date DATE,
record_time VARCHAR2(10),
modified_name VARCHAR2(80),
modified_date DATE,
modified_time VARCHAR2(10),
updated_by VARCHAR2(80),
date_updated DATE,
created_by VARCHAR2(80),
date_created DATE)
TABLESPACE MAXDAT_LAEB_DATA
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
  
create index IDX1_EMAILADDRCLIENTNUM on emrs_d_email_address (CLIENT_ID)
  tablespace MAXDAT_LAEB_DATA
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
  
create index IDX2_EMAILADDRCLIENTNUM on emrs_d_email_address (EMAIL_CASE_ID)
  tablespace MAXDAT_LAEB_DATA
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
alter table emrs_d_email_address
  add constraint EMAILADDRESS_PK primary key (dp_email_address_id)
  using index 
  tablespace MAXDAT_LAEB_DATA
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
grant select on emrs_d_email_address to MAXDAT_LAEB_READ_ONLY;  

CREATE OR REPLACE TRIGGER "BUIR_EMAIL_ADDR"
 BEFORE INSERT OR UPDATE
 ON emrs_d_email_address
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_EMAIL_ADDRESS.dp_email_address_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_email_address_id IS NULL THEN
        SElECT EMRS_SEQ_EMAIL_ADDRESS_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_email_address_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_EMAIL_ADDR;
/

ALTER TRIGGER "BUIR_EMAIL_ADDR" ENABLE;
/

begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_EMAIL_ADDRESS','ERRLOG_EMAIL_ADDRESS');
  end;
/


-- Create table
create table EMRS_S_EMAIL_ADDRESS_STG
(email_id NUMBER(18,0),
email_begin_date DATE,
email_type_cd VARCHAR2(2),
email_end_date DATE,
client_id NUMBER(18,0),
email_address VARCHAR2(128),
email_dolk_id VARCHAR2(32),
email_case_id NUMBER(18,0),
status_cd VARCHAR2(32),
email_bad_date DATE,
email_bad_date_satisfied DATE,
contact_method_ind NUMBER(1,0),
comparable_key VARCHAR2(2000),
email_begin_ndt NUMBER(18,0),
email_end_ndt NUMBER(18,0),
start_ndt NUMBER(18,0),
end_ndt NUMBER(18,0),
created_by VARCHAR2(80),
creation_date DATE,
last_updated_by VARCHAR2(80),
last_update_date DATE
 )
tablespace MAXDAT_LAEB_DATA
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
grant select on EMRS_S_EMAIL_ADDRESS_STG to MAXDAT_LAEB_READ_ONLY;

create index STG_IDX1_EMAILADDRESSNUM on EMRS_S_EMAIL_ADDRESS_STG (email_id)
  tablespace MAXDAT_LAEB_DATA
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