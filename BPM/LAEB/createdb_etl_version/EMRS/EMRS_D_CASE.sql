CREATE SEQUENCE  "EMRS_SEQ_CASES_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CASES_ID" TO &role_name;


create table EMRS_D_CASE
(
  dp_case_id              NUMBER not null,
  case_id NUMBER(18,0),
  case_cin  VARCHAR2(30),
  client_id NUMBER(18,0),
  family_number NUMBER(18,0),
  case_status_date  DATE,
  case_educated_ind VARCHAR2(1),
  case_educated_date  DATE,
  case_need_translator_ind  VARCHAR2(1),
  case_phone  VARCHAR2(15),
  case_phone_reminder_use VARCHAR2(1),
  case_educated_by  VARCHAR2(40),
  case_staff_id NUMBER(18,0),
  case_language_cd VARCHAR2(32),
  case_how_educated_cd VARCHAR2(32),
  case_status VARCHAR2(2),
  case_head_fname VARCHAR2(25),
  case_head_lname VARCHAR2(40),
  case_head_mi VARCHAR2(25),
  case_head_ssn VARCHAR2(30),
  case_head_full_name VARCHAR2(100),
  case_team VARCHAR2(1),
  case_load NUMBER(6,0),  
  fmnb_id NUMBER(18,0),
  load_type VARCHAR2(32),
  case_spoken_language_cd VARCHAR2(32),
  note_ref_id NUMBER(18,0),
  anniversary_dt DATE,
  state_staff_id_ext VARCHAR2(32),
  case_generic_field1_date DATE,
  case_generic_field2_date DATE,
  case_generic_field3_num NUMBER(18,0),
  case_generic_field4_num NUMBER(18,0),
  case_generic_field5_txt VARCHAR2(256),
  case_generic_field6_txt VARCHAR2(256),
  case_generic_field7_txt VARCHAR2(256),
  case_generic_field8_txt VARCHAR2(256),
  case_generic_field9_txt VARCHAR2(256),
  case_generic_field10_txt VARCHAR2(256),
  case_generic_ref11_id NUMBER(18,0),
  case_generic_ref12_id NUMBER(18,0),
  last_state_update_ts DATE,
  last_state_updated_by NUMBER(18,0),
  pref_contact_method_cd VARCHAR2(32),
  modified_date           DATE,
  modified_name           VARCHAR2(50),
  modified_time           VARCHAR2(10),
  record_date             DATE,
  record_time             VARCHAR2(10),
  record_name             VARCHAR2(80),
  updated_by              VARCHAR2(20),
  created_by              VARCHAR2(80),
  date_created            DATE,
  date_updated            DATE
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
create index IDX2_CASENUM on EMRS_D_CASE (CASE_ID)
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

create index IDX2_CASEHOHNUM on EMRS_D_CASE (CLIENT_ID)
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
alter table EMRS_D_CASE
  add constraint CASE_PK primary key (DP_CASE_ID)
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
--grant select, insert, update on EMRS_D_CASE to MAXDAT_OLTP_SIU;
--grant select, insert, update, delete on EMRS_D_CASE to MAXDAT_OLTP_SIUD;
grant select on EMRS_D_CASE to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_CASE"
 BEFORE INSERT OR UPDATE
 ON emrs_d_case
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CASE.dp_case_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_case_id IS NULL THEN
        SElECT EMRS_SEQ_CASES_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_case_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;
  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;


END BUIR_CASE;
/


ALTER TRIGGER "BUIR_CASE" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CASE_SV
AS
 SELECT 
    c.case_id AS CASE_ID,
    c.case_id AS CURRENT_CASE_ID , 
    'Y' AS CURRENT_FLAG , 
    c.case_cin AS CASE_CIN ,
    c.client_id AS CLNT_CLIENT_ID ,
    COALESCE(c.case_status, '0') AS CASE_STATUS ,
    c.case_status_date AS CASE_STATUS_DATE ,
    c.case_head_ssn AS CASE_HEAD_SSN ,
    c.case_head_fname AS CASE_HEAD_FNAME,
    SUBSTR(c.case_head_mi,1,1) AS CASE_HEAD_MI ,
    c.case_head_lname AS CASE_HEAD_LNAME,
    c.case_head_full_name AS CASE_HEAD_FULL_NAME,
    c.case_phone AS PHONE ,
    c.family_number AS FAMILY_NUMBER ,
    c.record_date AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    c.case_educated_ind AS CASE_EDUCATED_IND ,
    c.case_need_translator_ind AS CASE_NEED_TRANSLATOR_IND ,
    c.case_phone_reminder_use AS CASE_PHONE_REMINDER_USE ,
    COALESCE(c.case_language_cd, 'AH') AS CASE_LANGUAGE_CD ,
    c.case_how_educated_cd AS CASE_HOW_EDUCATED_CD ,
    COALESCE(c.case_spoken_language_cd, 'AH') AS CASE_SPOKEN_LANGUAGE_CD ,
    c.note_ref_id AS NOTE_REF_ID ,
    c.anniversary_dt AS ANNIVERSARY_DT ,
    c.last_state_update_ts AS LAST_STATE_UPDATE_TS ,
    c.last_state_updated_by AS LAST_STATE_UPDATED_BY,
    c.modified_date AS MODIFIED_DATE ,
    c.modified_time AS MODIFIED_TIME ,
    c.modified_name AS MODIFIED_NAME ,
    c.record_date AS RECORD_DATE ,
    c.record_time AS RECORD_TIME ,
    c.record_name AS RECORD_NAME 
  FROM emrs_d_case c;

GRANT SELECT ON "EMRS_D_CASE_SV" TO &role_name;


create table EMRS_S_CASES_STG
(
  case_id NUMBER(18,0),
  case_cin  VARCHAR2(30),
  family_number NUMBER(18,0),
  case_status_date  DATE,
  case_educated_ind VARCHAR2(1),
  case_educated_date  DATE,
  case_need_translator_ind  VARCHAR2(1),
  case_phone  VARCHAR2(15),
  case_phone_reminder_use VARCHAR2(1),
  case_educated_by  VARCHAR2(40),
  case_staff_id NUMBER(18,0),
  created_by VARCHAR2(80),
  creation_date DATE,
  last_updated_by VARCHAR2(80),
  last_update_date DATE,
  case_language_cd VARCHAR2(32),
  case_how_educated_cd VARCHAR2(32),
  case_status VARCHAR2(2),
  case_head_fname VARCHAR2(25),
  case_head_lname VARCHAR2(40),
  case_head_mi VARCHAR2(25),
  case_head_ssn VARCHAR2(30),
  case_team VARCHAR2(1),
  case_load NUMBER(6,0),
  clnt_client_id NUMBER(18,0),
  fmnb_id NUMBER(18,0),
  load_type VARCHAR2(32),
  case_spoken_language_cd VARCHAR2(32),
  note_ref_id NUMBER(18,0),
  anniversary_dt DATE,
  state_staff_id_ext VARCHAR2(32),
  case_generic_field1_date DATE,
  case_generic_field2_date DATE,
  case_generic_field3_num NUMBER(18,0),
  case_generic_field4_num NUMBER(18,0),
  case_generic_field5_txt VARCHAR2(256),
  case_generic_field6_txt VARCHAR2(256),
  case_generic_field7_txt VARCHAR2(256),
  case_generic_field8_txt VARCHAR2(256),
  case_generic_field9_txt VARCHAR2(256),
  case_generic_field10_txt VARCHAR2(256),
  case_generic_ref11_id NUMBER(18,0),
  case_generic_ref12_id NUMBER(18,0),
  last_state_update_ts DATE,
  last_state_updated_by NUMBER(18,0),
  pref_contact_method_cd VARCHAR2(32)
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

create index STG_IDX2_CASENUM on EMRS_S_CASES_STG (CASE_ID)
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
--grant select, insert, update on EMRS_S_CASES_STG to MAXDAT_OLTP_SIU;
--grant select, insert, update, delete on EMRS_S_CASES_STG to MAXDAT_OLTP_SIUD;
grant select on EMRS_S_CASES_STG to &role_name;

begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CASE','ERRLOG_CASE');
  end;
  /
  
