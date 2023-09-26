CREATE SEQUENCE  "EMRS_SEQ_OHC_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_OHC_ID" TO &role_name;

CREATE TABLE emrs_d_other_health_care(
    dp_ohc_id NUMBER NOT NULL,
    ohc_id NUMBER(18,0),
    case_id NUMBER(18,0),
    client_id NUMBER(18,0),
    ohc_insurance_company VARCHAR2(128),
    ohc_plan_type_cd VARCHAR2(32 ),
    ohc_insurance_phone_nbr VARCHAR2(15),
    ohc_policy_nbr VARCHAR2(128),
    ohc_source_cd VARCHAR2(32),
    ohc_start_date DATE,
    ohc_end_date DATE,
    ohc_premium_cost NUMBER(10,2),
    ohc_type_cd VARCHAR2(32),
    ohc_service_type_cd VARCHAR2(32),
    ohc_insured_relationship_cd VARCHAR2(32),
    ohc_subscriber_lname VARCHAR2(25),
    ohc_subscriber_fname VARCHAR2(25),
    ohc_subscriber_city VARCHAR2(30),
    ohc_subscriber_state VARCHAR2(2),
    ohc_subscriber_ssn VARCHAR2(9),
    ohc_group_nbr VARCHAR2(15),
    ohc_employer_name VARCHAR2(55),
    ohc_insurance_address_1 VARCHAR2(55),
    ohc_insurance_address_2 VARCHAR2(55),
    ohc_insurance_city VARCHAR2(30),
    ohc_insurance_state VARCHAR2(2),
    ohc_insurance_zip VARCHAR2(32),
    ohc_generic_field1_date DATE,
    ohc_generic_field2_date DATE,
    ohc_generic_field3_num NUMBER(18,0),
    ohc_generic_field4_num NUMBER(18,0),
    ohc_generic_field5_txt VARCHAR2(256),
    ohc_generic_field6_txt VARCHAR2(256),
    ohc_generic_field7_txt VARCHAR2(256),
    ohc_generic_field8_txt VARCHAR2(256),
    ohc_clone_ref_id NUMBER(18,0),
    record_name VARCHAR2(80 BYTE),
    record_date DATE,
    record_time VARCHAR2(10),
    modified_name VARCHAR2(80),
    modified_date DATE,
    modified_time VARCHAR2(10),
    date_created DATE,
    created_by VARCHAR2(80),
    date_updated DATE,
    updated_by VARCHAR2(80)) 
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

create index IDX2_OHCNUM on EMRS_D_OTHER_HEALTH_CARE (OHC_ID)
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
alter table EMRS_D_OTHER_HEALTH_CARE
  add constraint OHC_PK primary key (DP_OHC_ID)
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
    maxextents unlimited  )
;

grant select on EMRS_D_OTHER_HEALTH_CARE to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_OHC"
 BEFORE INSERT OR UPDATE
 ON emrs_d_other_health_care
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_OTHER_HEALTH_CARE.dp_ohc_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_ohc_id IS NULL THEN
        SElECT EMRS_SEQ_OHC_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_ohc_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_OHC;
/

ALTER TRIGGER "BUIR_OHC" ENABLE;
/

CREATE TABLE emrs_s_other_health_care_stg(
ohc_id NUMBER(18,0),
ohc_case_id NUMBER(18,0),
ohc_client_id NUMBER(18,0),
ohc_insurance_company VARCHAR2(128),
ohc_plan_type_cd VARCHAR2(32 ),
ohc_insurance_phone_nbr VARCHAR2(15),
ohc_policy_nbr VARCHAR2(128),
ohc_source_cd VARCHAR2(32),
ohc_start_date DATE,
ohc_end_date DATE,
ohc_premium_cost NUMBER(10,2),
ohc_type_cd VARCHAR2(32),
ohc_create_ts DATE,
ohc_created_by VARCHAR2(80),
ohc_update_ts DATE,
ohc_updated_by VARCHAR2(80),
ohc_service_type_cd VARCHAR2(32),
ohc_insured_relationship_cd VARCHAR2(32),
ohc_subscriber_lname VARCHAR2(25),
ohc_subscriber_fname VARCHAR2(25),
ohc_subscriber_city VARCHAR2(30),
ohc_subscriber_state VARCHAR2(2),
ohc_subscriber_ssn VARCHAR2(9),
ohc_group_nbr VARCHAR2(15),
ohc_employer_name VARCHAR2(55),
ohc_insurance_address_1 VARCHAR2(55),
ohc_insurance_address_2 VARCHAR2(55),
ohc_insurance_city VARCHAR2(30),
ohc_insurance_state VARCHAR2(2),
ohc_insurance_zip VARCHAR2(32),
ohc_generic_field1_date DATE,
ohc_generic_field2_date DATE,
ohc_generic_field3_num NUMBER(18,0),
ohc_generic_field4_num NUMBER(18,0),
ohc_generic_field5_txt VARCHAR2(256),
ohc_generic_field6_txt VARCHAR2(256),
ohc_generic_field7_txt VARCHAR2(256),
ohc_generic_field8_txt VARCHAR2(256),
ohc_clone_ref_id NUMBER(18,0)) 
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
  
grant select on EMRS_S_OTHER_HEALTH_CARE_STG to &role_name;  

begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_OTHER_HEALTH_CARE','ERRLOG_OHC');
  end;
/
