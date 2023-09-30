CREATE SEQUENCE  "D_SEQ_CALLREC_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_CALLREC_ID" TO &role_name;

CREATE SEQUENCE  "D_SEQ_CALLRECLINK_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_CALLRECLINK_ID" TO &role_name;

CREATE SEQUENCE  "D_SEQ_EVENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_EVENT_ID" TO &role_name;

-- Create table
CREATE TABLE D_CALL_RECORD
 (  dp_call_record_id NUMBER not null, 
    call_record_id NUMBER(18,0),
    call_type_cd VARCHAR2(64),
    caller_type_cd VARCHAR2(64),
    call_tracking_number VARCHAR2(32),
    worker_id VARCHAR2(32),
    worker_username VARCHAR2(32),
    language_cd VARCHAR2(32),
    call_start_ts DATE,
    call_end_ts DATE,
    caller_phone VARCHAR2(16),
    ext_telephony_ref VARCHAR2(32),
    created_by VARCHAR2(32),
    create_ts DATE,
    updated_by VARCHAR2(32),
    update_ts DATE,
    note_ref_id NUMBER(18,0),
    caller_first_name VARCHAR2(50), 
    caller_last_name VARCHAR2(50),  
    call_start_ndt NUMBER(18,0),
    call_record_field1 VARCHAR2(80),
    call_record_field2 VARCHAR2(80),
    call_record_field3 VARCHAR2(80),
    call_record_field4 VARCHAR2(80),
    call_record_field5 VARCHAR2(80),
    parent_call_record_id NUMBER(18,0),
    call_record_generic_field1 DATE,
    call_record_generic_field2 DATE,
    call_record_generic_field3 NUMBER(18,0),
    call_record_generic_field4 NUMBER(18,0),
    call_record_generic_field5 VARCHAR2(256),
    call_record_generic_field6 VARCHAR2(256),
    call_record_generic_field7 VARCHAR2(256),
    call_record_generic_field8 VARCHAR2(256),
    call_record_generic_field9 VARCHAR2(256),
    call_record_generic_field10 VARCHAR2(256),
    medchat_topic VARCHAR2(128),
    medchat_status VARCHAR2(128),
    medchat_id VARCHAR2(128),
    dp_updated_by VARCHAR2(80),
    dp_created_by VARCHAR2(80),
    dp_date_created  DATE,
    dp_date_updated  DATE   
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
create index IDX2_CALLRECNUM on D_CALL_RECORD (CALL_RECORD_ID)
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
alter table D_CALL_RECORD
  add constraint CALLREC_PK primary key (DP_CALL_RECORD_ID)
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
grant select on D_CALL_RECORD to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_CALLRECORD"
 BEFORE INSERT OR UPDATE
 ON d_call_record
 FOR EACH ROW
DECLARE
    v_seq_id     D_CALL_RECORD.dp_call_record_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_call_record_id IS NULL THEN
        SElECT D_SEQ_CALLREC_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_call_record_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_CALLRECORD;
/

ALTER TRIGGER "BUIR_CALLRECORD" ENABLE;
/

CREATE TABLE D_CALL_RECORD_LINK(
    dp_call_record_link_id NUMBER NOT NULL,
    call_record_link_id	NUMBER(18,0),
    call_record_id	NUMBER(18,0),
    client_id	NUMBER(18,0),
    case_id	NUMBER(18,0),
    ext_client_num	VARCHAR2(50),
    ext_case_num	VARCHAR2(50),
    client_last_name	VARCHAR2(40),
    client_first_name	VARCHAR2(25),
    client_mi	VARCHAR2(25),
    ref_type	VARCHAR2(32),
    ref_id	NUMBER(18,0),
    create_ts	DATE,
    created_by	VARCHAR2(80),
    update_ts	DATE,
    updated_by	VARCHAR2(80),
    caller_ind	NUMBER(1,0),
    dp_updated_by VARCHAR2(80),
    dp_created_by VARCHAR2(80),
    dp_date_created  DATE,
    dp_date_updated  DATE   )
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
create index IDX2_CALLRECLINKNUM on D_CALL_RECORD_LINK (CALL_RECORD_LINK_ID)
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

create index IDX3_CALLRECLINKNUM on D_CALL_RECORD_LINK (CALL_RECORD_ID)
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
alter table D_CALL_RECORD_LINK
  add constraint CALLRECLINK_PK primary key (DP_CALL_RECORD_LINK_ID)
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
grant select on D_CALL_RECORD_LINK to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_CALLRECORDLINK"
 BEFORE INSERT OR UPDATE
 ON d_call_record_link
 FOR EACH ROW
DECLARE
    v_seq_id     D_CALL_RECORD_LINK.dp_call_record_link_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_call_record_link_id IS NULL THEN
        SElECT D_SEQ_CALLREC_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_call_record_link_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_CALLRECORDLINK;
/

ALTER TRIGGER "BUIR_CALLRECORDLINK" ENABLE;
/


create table D_EVENT
(dp_event_id NUMBER NOT NULL,
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
create index IDX2_EVENTNUM on D_EVENT (EVENT_ID)
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

create index IDX3_EVENTCASENUM on D_EVENT (CASE_ID)
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
  
create index IDX4_EVENTCLIENTNUM on D_EVENT (CLIENT_ID)
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
  
create index IDX5_EVENTCALLRECNUM on D_EVENT (CALL_RECORD_ID)
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
alter table D_EVENT
  add constraint EVENT_PK primary key (DP_EVENT_ID)
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
grant select on D_EVENT to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_EVENT"
 BEFORE INSERT OR UPDATE
 ON d_event
 FOR EACH ROW
DECLARE
    v_seq_id     D_EVENT.dp_event_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_event_id IS NULL THEN
        SElECT D_SEQ_EVENT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_event_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_EVENT;
/

ALTER TRIGGER "BUIR_EVENT" ENABLE;
/

CREATE OR REPLACE VIEW D_LA_EB_CALL_RECORDS_SV
AS
SELECT
  c.call_record_id call_record_id
, c.create_ts call_creation_date
, c.call_type_cd call_call_type_cd
, e.event_type_cd call_event_type_cd
, e.context call_action_cd
, e.comments call_action_desc
FROM D_CALL_RECORD c
JOIN D_EVENT e ON E.CALL_RECORD_ID = c.CALL_RECORD_ID
AND E.CONTEXT IN ('RENEWAL_COMPLETED',
                               'RENEWAL_INCOMPLETE_CALL_DISCONNECTED',
                               'RENEWAL_INCOMPLETE_MISSING_INFO',
                               'RENEWAL_INCOMPLETE_WILL_CALL_BACK',
                               'RENEWAL_INCOMPLETE_PROBLEM_WITH_STATE_SYSTEM',
                               'APPLICATION_COMPLETE_PLAN_SELECTED',
                               'APPLICATION_COMPLETE_NO_PLAN_SELECTED',
                               'APPLICATION_INCOMPLETE_CALL_DISCONNECTED',
                               'APPLICATION_INCOMPLETE_MISSING_INFO',
                               'APPLICATION_INCOMPLETE_WILL_CALL_BACK',
                               'APPLICATION_INCOMPLETE_PROBLEM_WITH_STATE_SYSTEM',
                               'UNABLE_TO_VERIFY_IDENTITY',
                               'GENERAL_INFORMATION',
                               'MAILING_ADDRESS_AND_OR_PHONE_NUMBER_CHANGE',
                               'MEMBER_REQUESTED_FORM_TO_BE_MAILED',
                               'NON_DEMOGRAPHIC_CHANGE_OR_CONCERN_REFERRED_TO_DHH',
                               'INQUERY_PLAN_INFO',
                               'INQUERY_PROVIDER_INFO',
                               'INQUERY_RENEWAL_INFO',
                               'INQUERY_CSCL_STATUS',
                               'INQUERY_GENERAL_INFO',
                               'INQUERY_MEDICAID_INFO',
                               'INQUERY_OTHER_PROGRAM_INFO',
                               'INQUERY_PLAN_AND_CUSTOMER_SERVICE_INFO',
                               'REFERRAL_TO_DHH',
                               'REFERRAL_TO_PLAN',
                              'REFERRAL_TO_HEALTHY_LOUISIANA',
                               'REFERRAL_TO_PROVIDER',
                               'LA_TRANSFER_CALL_BYH');

GRANT SELECT ON D_LA_EB_CALL_RECORDS_SV TO &role_name;

begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_CALL_RECORD','ERRLOG_CALLRECORD');
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_CALL_RECORD_LINK','ERRLOG_CALLRECORDLINK');
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_EVENT','ERRLOG_EVENT');
end;
/

-- Create table
create table S_CALL_RECORD_STG
(call_record_id NUMBER(18,0),
  call_type_cd VARCHAR2(64),
  caller_type_cd VARCHAR2(64),
  call_tracking_number VARCHAR2(32),
  worker_id VARCHAR2(32),
  worker_username VARCHAR2(32),
  language_cd VARCHAR2(32),
  call_start_ts DATE,
  call_end_ts DATE,
  caller_phone VARCHAR2(16),
  ext_telephony_ref VARCHAR2(32),
  created_by VARCHAR2(32),
  create_ts DATE,
  updated_by VARCHAR2(32),
  update_ts DATE,
  note_ref_id NUMBER(18,0),
  caller_first_name VARCHAR2(50), 
  caller_last_name VARCHAR2(50),  
  call_start_ndt NUMBER(18,0),
  call_record_field1 VARCHAR2(80),
  call_record_field2 VARCHAR2(80),
  call_record_field3 VARCHAR2(80),
  call_record_field4 VARCHAR2(80),
  call_record_field5 VARCHAR2(80),
  parent_call_record_id NUMBER(18,0),
  call_record_generic_field1 DATE,
  call_record_generic_field2 DATE,
  call_record_generic_field3 NUMBER(18,0),
  call_record_generic_field4 NUMBER(18,0),
  call_record_generic_field5 VARCHAR2(256),
  call_record_generic_field6 VARCHAR2(256),
  call_record_generic_field7 VARCHAR2(256),
  call_record_generic_field8 VARCHAR2(256),
  call_record_generic_field9 VARCHAR2(256),
  call_record_generic_field10 VARCHAR2(256),
  medchat_topic VARCHAR2(128),
  medchat_status VARCHAR2(128),
  medchat_id VARCHAR2(128)
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
grant select on S_CALL_RECORD_STG to &role_name;

create index STG_IDX2_CALLRECNUM on S_CALL_RECORD_STG (CALL_RECORD_ID)
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


create table S_CALL_RECORD_LINK_STG
(    call_record_link_id	NUMBER(18,0),
    call_record_id	NUMBER(18,0),
    client_id	NUMBER(18,0),
    case_id	NUMBER(18,0),
    ext_client_num	VARCHAR2(50),
    ext_case_num	VARCHAR2(50),
    client_last_name	VARCHAR2(40),
    client_first_name	VARCHAR2(25),
    client_mi	VARCHAR2(25),
    ref_type	VARCHAR2(32),
    ref_id	NUMBER(18,0),
    create_ts	DATE,
    created_by	VARCHAR2(80),
    update_ts	DATE,
    updated_by	VARCHAR2(80),
    caller_ind	NUMBER(1,0)
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
grant select on S_CALL_RECORD_LINK_STG to &role_name;

create index STG_IDX2_CALLRECLINKNUM on S_CALL_RECORD_LINK_STG (CALL_RECORD_LINK_ID)
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

create table S_EVENT_STG
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
  
grant select on S_EVENT_STG to &role_name;

create index STG_IDX2_EVENTNUM on S_EVENT_STG (EVENT_ID)
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
  
  