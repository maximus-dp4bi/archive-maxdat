CREATE SEQUENCE  "D_SEQ_DIGITAL_EVENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_DIGITAL_EVENT_ID" TO MAXDAT_LAEB_READ_ONLY;

create table D_DIGITAL_EVENT
(dp_digital_event_id NUMBER NOT NULL,
  event_id NUMBER(18,0),
  event_type_cd VARCHAR2(32),
  context VARCHAR2(1000),
  comments VARCHAR2(2500),
  create_ts DATE,
  created_by VARCHAR2(80),
  update_ts DATE,
  updated_by VARCHAR2(80),
  ref_type VARCHAR2(32),
  ref_id NUMBER(18,0),
  event_level NUMBER(8,0),
  image_repo_ref_id NUMBER(18,0),
  effective_date DATE,
  case_id NUMBER(18,0),
  client_id NUMBER(18,0),
  call_record_id NUMBER(18,0),
  task_instance_id NUMBER(18,0),
  cscl_id NUMBER(18,0),
  disabled_ind NUMBER,
  generic_field1_date DATE,
  generic_field2_date DATE,
  generic_field3_num NUMBER(18,0),
  generic_field4_num NUMBER(18,0),
  generic_field5_txt VARCHAR2(256),
  generic_field6_txt VARCHAR2(256),
  generic_field7_txt VARCHAR2(256),
  generic_field8_txt VARCHAR2(256),
  generic_field9_txt VARCHAR2(256),
  generic_field10_txt VARCHAR2(256),
  dp_updated_by VARCHAR2(80),
  dp_created_by VARCHAR2(80),
  dp_date_created  DATE,
  dp_date_updated  DATE )
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
  
-- Create/Recreate indexes 
create index IDX2_DGTLEVENTNUM on D_DIGITAL_EVENT (EVENT_ID)
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

create index IDX3_DGTLEVENTCASENUM on D_DIGITAL_EVENT (CASE_ID)
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
  
create index IDX4_DGTLEVENTCLIENTNUM on D_DIGITAL_EVENT (CLIENT_ID)
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
  
create index IDX5_DGTLEVENTTYPE on D_DIGITAL_EVENT (EVENT_TYPE_CD)
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

create index IDX6_DGTLEVENTCTS on D_DIGITAL_EVENT (CREATE_TS)
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
alter table D_DIGITAL_EVENT
  add constraint DGTL_EVENT_PK primary key (DP_DIGITAL_EVENT_ID)
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
grant select on D_DIGITAL_EVENT to MAXDAT_LAEB_READ_ONLY;

CREATE OR REPLACE TRIGGER "BUIR_DIGITAL_EVENT"
 BEFORE INSERT OR UPDATE
 ON d_digital_event
 FOR EACH ROW
DECLARE
    v_seq_id     D_DIGITAL_EVENT.dp_digital_event_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_digital_event_id IS NULL THEN
        SElECT D_SEQ_DIGITAL_EVENT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_digital_event_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_DIGITAL_EVENT;
/

ALTER TRIGGER "BUIR_DIGITAL_EVENT" ENABLE;
/

create table S_DIGITAL_EVENT_STG
(event_id NUMBER(18,0),
event_type_cd VARCHAR2(32),
context VARCHAR2(1000),
comments VARCHAR2(2500),
create_ts DATE,
created_by VARCHAR2(80),
update_ts DATE,
updated_by VARCHAR2(80),
ref_type VARCHAR2(32),
ref_id NUMBER(18,0),
event_level NUMBER(8,0),
image_repo_ref_id NUMBER(18,0),
effective_date DATE,
case_id NUMBER(18,0),
client_id NUMBER(18,0),
call_record_id NUMBER(18,0),
task_instance_id NUMBER(18,0),
cscl_id NUMBER(18,0),
disabled_ind NUMBER,
generic_field1_date DATE,
generic_field2_date DATE,
generic_field3_num NUMBER(18,0),
generic_field4_num NUMBER(18,0),
generic_field5_txt VARCHAR2(256),
generic_field6_txt VARCHAR2(256),
generic_field7_txt VARCHAR2(256),
generic_field8_txt VARCHAR2(256),
generic_field9_txt VARCHAR2(256),
generic_field10_txt VARCHAR2(256))
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
  
grant select on S_DIGITAL_EVENT_STG to MAXDAT_LAEB_READ_ONLY;

create index STG_IDX1_DGTLEVENTNUM on S_DIGITAL_EVENT_STG (EVENT_ID)
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

begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_DIGITAL_EVENT','ERRLOG_DIGITAL_EVENT');
end;
/  