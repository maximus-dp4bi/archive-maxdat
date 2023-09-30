CREATE SEQUENCE  "D_SEQ_LETTER_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_LETTER_ID" TO &role_name;

CREATE SEQUENCE  "D_SEQ_LETTERLINK_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_LETTERLINK_ID" TO &role_name;

-- Create table
CREATE TABLE D_LETTER_REQUEST
 (  dp_letter_request_id NUMBER not null,      
    letter_request_id NUMBER(18,0),
    case_id NUMBER(18,0),
    lmdef_id NUMBER(18,0),
    requested_on DATE,
    request_type VARCHAR2(2),
    produced_by VARCHAR2(2),
    language_cd VARCHAR2(32),
    driver_type VARCHAR2(4),
    status_cd VARCHAR2(32),
    rep_lmreq_id NUMBER(18,0),
    sent_on DATE,
    created_by VARCHAR2(80),
    create_ts DATE,
    updated_by VARCHAR2(80),
    update_ts DATE,
    printed_on DATE,
    staff_id_printed_by NUMBER(18,0),
    note_refid NUMBER(18,0),
    return_date DATE,
    return_reason_cd VARCHAR2(32),   
    parent_lmreq_id NUMBER(18,0),
    reprint_parent_lmreq_id NUMBER(18,0),
    lmact_cd VARCHAR2(32),
    ldis_cd VARCHAR2(32),    
    authorized_lmreq_id NUMBER(18,0),
    error_codes VARCHAR2(4000),
    nmbr_requested NUMBER(18,0),
    program_type_cd VARCHAR2(32),
    material_request_id NUMBER(18,0),
    mailing_address_id NUMBER(18,0),
    response_due_date DATE,
    mailed_date DATE,
    reject_reason_cd VARCHAR2(32),
    status_err_src VARCHAR2(32),
    letter_out_generation_num NUMBER(38,0),
    portal_view_ind NUMBER(1,0),
    is_digital_ind NUMBER(1,0),
    dp_updated_by VARCHAR2(80),
    dp_date_updated DATE,
    dp_created_by VARCHAR2(80),
    dp_date_created DATE)
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
create index IDX2_LETTERREQNUM on D_LETTER_REQUEST (letter_request_id)
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
  
create index IDX3_LETTERREQ_CASENUM on D_LETTER_REQUEST (CASE_ID)
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
  
create index IDX4_LETTERREQ_LMDEFID on D_LETTER_REQUEST (LMDEF_ID)
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
  
create index IDX5_LETTERREQ_ADDRID on D_LETTER_REQUEST (mailing_address_id)
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
alter table D_LETTER_REQUEST
  add constraint LETTER_PK primary key (dp_letter_request_id)
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
grant select on D_LETTER_REQUEST to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_LETTERREQ"
 BEFORE INSERT OR UPDATE
 ON d_letter_request
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_REQUEST.dp_letter_request_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_letter_request_id IS NULL THEN
        SElECT D_SEQ_LETTER_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_letter_request_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_LETTERREQ;
/

ALTER TRIGGER "BUIR_LETTERREQ" ENABLE;
/

CREATE TABLE D_LETTER_REQUEST_LINK
 (  dp_letter_link_id NUMBER not null,   
    lmlink_id NUMBER(18,0),
    letter_request_id NUMBER(18,0),
    reference_type VARCHAR2(40),
    reference_id NUMBER(18,0),
    created_by VARCHAR2(80),
    create_ts DATE,
    updated_by VARCHAR2(80),    
    update_ts DATE,
    additional_reference_type VARCHAR2(30),
    additional_reference_id NUMBER(18,0),
    client_id NUMBER(18,0),
    client_enroll_status_id NUMBER(18,0),
    dp_updated_by VARCHAR2(80),
    dp_date_updated DATE,
    dp_created_by VARCHAR2(80),
    dp_date_created DATE)
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
create index IDX2_LETTERLINKNUM on D_LETTER_REQUEST_LINK (lmlink_id)
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
  
create index IDX3_LETTERREQ_NUM on D_LETTER_REQUEST_LINK (letter_request_id)
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
alter table D_LETTER_REQUEST_LINK
  add constraint LETTERLINK_PK primary key (dp_letter_link_id)
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
grant select on D_LETTER_REQUEST_LINK to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_LETTERLINK"
 BEFORE INSERT OR UPDATE
 ON d_letter_request_link
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_REQUEST_LINK.dp_letter_link_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_letter_link_id IS NULL THEN
        SElECT D_SEQ_LETTERLINK_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_letter_link_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_LETTERLINK;
/

ALTER TRIGGER "BUIR_LETTERLINK" ENABLE;
/

begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_LETTER_REQUEST','ERRLOG_LETTER');
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_LETTER_REQUEST_LINK','ERRLOG_LTRLINK');
end;
/
-- Create table
create table S_LETTER_REQUEST_STG
(
    lmreq_id NUMBER(18,0),
    case_id NUMBER(18,0),
    lmdef_id NUMBER(18,0),
    requested_on DATE,
    request_type VARCHAR2(2),
    produced_by VARCHAR2(2),
    language_cd VARCHAR2(32),
    driver_type VARCHAR2(4),
    status_cd VARCHAR2(32),
    rep_lmreq_id NUMBER(18,0),
    sent_on DATE,
    created_by VARCHAR2(80),
    create_ts DATE,
    updated_by VARCHAR2(80),
    update_ts DATE,
    printed_on DATE,
    staff_id_printed_by NUMBER(18,0),
    note_refid NUMBER(18,0),
    return_date DATE,
    return_reason_cd VARCHAR2(32),   
    parent_lmreq_id NUMBER(18,0),
    reprint_parent_lmreq_id NUMBER(18,0),
    lmact_cd VARCHAR2(32),
    ldis_cd VARCHAR2(32),    
    authorized_lmreq_id NUMBER(18,0),
    error_codes VARCHAR2(4000),
    nmbr_requested NUMBER(18,0),
    program_type_cd VARCHAR2(32),
    material_request_id NUMBER(18,0),
    mailing_address_id NUMBER(18,0),
    response_due_date DATE,
    mailed_date DATE,
    reject_reason_cd VARCHAR2(32),
    status_err_src VARCHAR2(32),
    letter_out_generation_num NUMBER(38,0),
    portal_view_ind NUMBER(1,0),
    is_digital_ind NUMBER(1,0) )
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
grant select on S_LETTER_REQUEST_STG to &role_name;

create index STG_IDX2_LETTERNUM on S_LETTER_REQUEST_STG (LMREQ_ID)
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

create table S_LETTER_LINK_STG
(
  lmlink_id NUMBER(18,0),
  letter_request_id NUMBER(18,0),
  reference_type VARCHAR2(40),
  reference_id NUMBER(18,0),
  created_by VARCHAR2(80),
  create_ts DATE,
  updated_by VARCHAR2(80),    
  update_ts DATE,
  additional_reference_type VARCHAR2(30),
  additional_reference_id NUMBER(18,0),
  client_id NUMBER(18,0),
  client_enroll_status_id NUMBER(18,0) )
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
grant select on S_LETTER_LINK_STG to &role_name;

create index STG_IDX2_LETTERLINKNUM on S_LETTER_LINK_STG (LMLINK_ID)
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

CREATE OR REPLACE VIEW D_LE_LTR_REJECT_BY_DAY_SV
AS
select LR.letter_request_id LETTER_REQUEST_ID
   , LR.sent_on SENT_DATE
   , LD.name LETTER_CODE
   , LD.description LETTER_DESCRIPTION
   , LR.reject_reason_cd REJECT_REASON_CODE
   , LRL.client_id CLIENT_ID
   , CSI.client_cin MEDICAID_ID
   , CSI.first_name FIRST_NAME
   , CSI.last_name LAST_NAME
   , AD.addr_street_1 ADDRESS_STREET_1
   , AD.addr_street_2 ADDRESS_STREET_2
   , AD.addr_city ADDRESS_CITY
   , AD.addr_state_cd ADDRESS_STATE_CODE
   , AD.addr_zip ADDRESS_ZIPCODE
   , ERR.reject_reason REJECT_REASON_DESCRIPTION
   , LR.requested_on LETTER_REQUEST_DATE
   , ELS.letter_status LETTER_STATUS
   , LR.update_ts LETTER_STATUS_DATE
from d_letter_request LR
   left join d_letter_definition LD 
      on LR.lmdef_id = LD.lmdef_id
   left join d_letter_request_link LRL
      on LR.letter_request_id = LRL.letter_request_id
   left join emrs_d_client_supplementary_info CSI
      on CSI.client_id = LRL.client_id
   left join emrs_d_address AD
      on LR.mailing_address_id = AD.addr_id
   left join d_letter_reject_reason ERR
      on LR.reject_reason_cd = ERR.reject_reason_code
   left join d_letter_status ELS
      on LR.STATUS_CD = ELS.letter_status_code
where (LR.sent_on >= (SELECT (TRUNC (SYSDATE) - 180)  FROM DUAL) and 
   LR.STATUS_CD = 'REJ');    
  
GRANT SELECT ON D_LE_LTR_REJECT_BY_DAY_SV TO &role_name;
