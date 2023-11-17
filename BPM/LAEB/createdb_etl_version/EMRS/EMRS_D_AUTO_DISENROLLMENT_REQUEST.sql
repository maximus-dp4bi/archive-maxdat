CREATE SEQUENCE  "D_SEQ_AUTO_DISENROLL_REQ_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_AUTO_DISENROLL_REQ_ID" TO MAXDAT_LAEB_READ_ONLY;

CREATE TABLE emrs_d_auto_disenrollment_request
(dp_auto_disenroll_req_id NUMBER NOT NULL,
auto_disenrollment_request_id NUMBER(18,0),
client_id NUMBER(18,0),
requested_date DATE,
auto_disenroll_requestor_cd VARCHAR2(32),
auto_disenroll_rsn_cd VARCHAR2(32),
auto_disenroll_src_cd VARCHAR2(32),
current_mco_id VARCHAR2(256),
requested_mco_id VARCHAR2(256),
note_ref_id NUMBER(18,0),
received_date DATE,
effective_date DATE,
disposition_cd VARCHAR2(32),
end_date DATE,
result_cd VARCHAR2(32),
submitter_name VARCHAR2(80),
submitter_number VARCHAR2(80),
ad_incident_header_id NUMBER(18,0),
auto_disenroll_status_cd VARCHAR2(80),
ad_process_ts DATE,
ad_request_notes_1 VARCHAR2(4000),
ad_request_notes_2 VARCHAR2(4000),
dcfs_info_flag VARCHAR2(1),
plan_type_cd VARCHAR2(255),
record_name VARCHAR2(80),
record_date DATE,
record_time VARCHAR2(10),
modified_name VARCHAR2(80),
modified_date DATE,
modified_time VARCHAR2(10),
dp_updated_by VARCHAR2(80),
dp_created_by VARCHAR2(80),
dp_date_created  DATE,
dp_date_updated  DATE)
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


create index IDX_AUTO_DISENROLL_01 on emrs_d_auto_disenrollment_request (CLIENT_ID)
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
  
create index IDX_AUTO_DISENROLL_02 on emrs_d_auto_disenrollment_request (AUTO_DISENROLL_RSN_CD)
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
  
create index IDX_AUTO_DISENROLL_03 on emrs_d_auto_disenrollment_request (AUTO_DISENROLL_SRC_CD)
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

create index IDX_AUTO_DISENROLL_04 on emrs_d_auto_disenrollment_request (AUTO_DISENROLL_STATUS_CD)
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
  
create index IDX_AUTO_DISENROLL_05 on emrs_d_auto_disenrollment_request (DISPOSITION_CD)
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

create index IDX_AUTO_DISENROLL_06 on emrs_d_auto_disenrollment_request (CURRENT_MCO_ID)
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

create index IDX_AUTO_DISENROLL_07 on emrs_d_auto_disenrollment_request (ad_request_notes_1)
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

create unique index XPKAD_AUTO_DISENROLLMENT_RQST on emrs_d_auto_disenrollment_request (AUTO_DISENROLLMENT_REQUEST_ID)
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

grant select on emrs_d_auto_disenrollment_request to MAXDAT_LAEB_READ_ONLY;

CREATE OR REPLACE TRIGGER "BUIR_EMRS_AUTODISENROLL"
 BEFORE INSERT OR UPDATE
 ON emrs_d_auto_disenrollment_request
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_AUTO_DISENROLLMENT_REQUEST.dp_auto_disenroll_req_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_auto_disenroll_req_id IS NULL THEN
        SElECT D_SEQ_AUTO_DISENROLL_REQ_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_auto_disenroll_req_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_EMRS_AUTODISENROLL;
/

ALTER TRIGGER "BUIR_EMRS_AUTODISENROLL" ENABLE;
/

create table s_auto_disenrollment_request_stg
(auto_disenrollment_request_id NUMBER(18,0),
client_id NUMBER(18,0),
requested_date DATE,
auto_disenroll_requestor_cd VARCHAR2(32),
auto_disenroll_rsn_cd VARCHAR2(32),
auto_disenroll_src_cd VARCHAR2(32),
current_mco_id VARCHAR2(256),
requested_mco_id VARCHAR2(256),
note_ref_id NUMBER(18,0),
received_date DATE,
effective_date DATE,
disposition_cd VARCHAR2(32),
end_date DATE,
result_cd VARCHAR2(32),
submitter_name VARCHAR2(80),
submitter_number VARCHAR2(80),
ad_incident_header_id NUMBER(18,0),
auto_disenroll_status_cd VARCHAR2(80),
ad_process_ts DATE,
ad_request_notes_1 VARCHAR2(4000),
ad_request_notes_2 VARCHAR2(4000),
dcfs_info_flag VARCHAR2(1),
plan_type_cd VARCHAR2(255),
create_ts DATE,
created_by VARCHAR2(80),
update_ts DATE,
updated_by VARCHAR2(80))
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
  
grant select on s_auto_disenrollment_request_stg to MAXDAT_LAEB_READ_ONLY;

create index STG_IDX1_AUTODISENROLL on s_auto_disenrollment_request_stg (auto_disenrollment_request_id)
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
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_AUTO_DISENROLLMENT_REQUEST','ERRLOG_AUTODISENROLL_REQ');
end;
/  
