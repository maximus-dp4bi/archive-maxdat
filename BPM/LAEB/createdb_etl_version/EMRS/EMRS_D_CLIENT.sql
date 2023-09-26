CREATE SEQUENCE  "EMRS_SEQ_CLIENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLIENT_ID" TO &role_name;

-- Create table
CREATE TABLE EMRS_D_CLIENT
 (  dp_client_id NUMBER not null,
    client_id NUMBER(18,0),
    clnt_clnt_client_id NUMBER(18,0),
    clnt_fname VARCHAR2(25),    
    clnt_lname VARCHAR2(40),    
    clnt_mi VARCHAR2(25),
    clnt_full_name VARCHAR2(100),
    clnt_gender_cd VARCHAR2(32),
    clnt_citizen VARCHAR2(32),
    clnt_ethnicity VARCHAR2(32),
    clnt_race VARCHAR2(32),
    clnt_dob DATE,
    clnt_dod DATE,
    clnt_tpl_present VARCHAR2(1),
    clnt_ssn VARCHAR2(30),
    clnt_national_id VARCHAR2(64),
    clnt_from_pacmis VARCHAR2(1),
    clnt_share_premium VARCHAR2(1),
    clnt_not_born VARCHAR2(1),
    clnt_hipaa_privacy_ind VARCHAR2(1),
    clnt_finet_vendor_nbr VARCHAR2(10),
    clnt_enroll_status VARCHAR2(32),
    clnt_enroll_status_date DATE,
    sched_auto_assign_date DATE,
    clnt_cin VARCHAR2(30),
    clnt_comment VARCHAR2(4000),       
    clnt_pseudo_id VARCHAR2(10),
    clnt_display_name VARCHAR2(80),
    ssnvl_id NUMBER(38,0),
    note_ref_id NUMBER(18,0),
    clnt_marital_cd VARCHAR2(32),
    clnt_status_cd VARCHAR2(32),
    clnt_expected_dob DATE,
    clnt_preg_term_date DATE,
    clnt_preg_term_reas_cd VARCHAR2(32),
    client_type_cd VARCHAR2(10),
    supplemental_nbr VARCHAR2(32),
    client_language VARCHAR2(32),
    state_language VARCHAR2(32),
    do_not_call_ind NUMBER(1,0),
    written_language VARCHAR2(32),
    suffix VARCHAR2(32),
    salutation_cd VARCHAR2(32),
    domestic_violence_ind NUMBER(1,0),
    english_fluency_cd VARCHAR2(32),
    english_literacy_cd VARCHAR2(32),
    tribe_cd VARCHAR2(32),
    clnt_generic_field1_date DATE,
    clnt_generic_field2_date DATE,
    clnt_generic_field3_num NUMBER(18,0),
    clnt_generic_field4_num NUMBER(18,0),
    clnt_generic_field5_txt VARCHAR2(256),
    clnt_generic_field6_txt VARCHAR2(256),
    clnt_generic_field7_txt VARCHAR2(256),
    clnt_generic_field8_txt VARCHAR2(256),
    clnt_generic_field9_txt VARCHAR2(256),
    clnt_generic_field10_txt VARCHAR2(256),
    clnt_generic_ref11_id NUMBER(18,0),
    clnt_generic_ref12_id NUMBER(18,0),
    dod_source_cd VARCHAR2(32),
    do_not_text_ind NUMBER(1,0),
    do_not_email_ind NUMBER(1,0),
    last_state_update_ts DATE,
    last_state_updated_by NUMBER(18,0),
    comparable_key VARCHAR2(2000),
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
create index IDX2_CLIENTNUM on EMRS_D_CLIENT (CLIENT_ID)
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
alter table EMRS_D_CLIENT
  add constraint CLIENT_PK primary key (DP_CLIENT_ID)
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
grant select on EMRS_D_CLIENT to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_CLIENT"
 BEFORE INSERT OR UPDATE
 ON emrs_d_client
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT.dp_client_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_client_id IS NULL THEN
        SElECT EMRS_SEQ_CLIENT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_client_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_CLIENT;
/

ALTER TRIGGER "BUIR_CLIENT" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CLIENT_SV
AS
WITH dme AS(
SELECT  *
FROM d_client_eligibility_me
WHERE sequence_num = 1),
ceg AS(
SELECT  e.CLIENT_ELIG_STATUS_ID
              , LAG(e.CLIENT_ELIG_STATUS_ID, 1) OVER (PARTITION BY e.client_id ORDER BY e.CLIENT_ELIG_STATUS_ID ASC) PRIOR_CLIENT_ELIG_STATUS_ID
              , e.CLIENT_ID
              , e.START_DATE
              , e.START_NDT
              , e.END_DATE
              , e.END_NDT
              , e.SUBPROGRAM_TYPE
              , e.MVX_CORE_REASON
              , e.PLAN_TYPE_CD
              , LAG(e.SUBPROGRAM_TYPE, 1) OVER (PARTITION BY e.client_id ORDER BY e.CLIENT_ELIG_STATUS_ID ASC) PRIOR_SUBPROGRAM_TYPE
              , LAG(e.MVX_CORE_REASON, 1) OVER (PARTITION BY e.client_id ORDER BY e.CLIENT_ELIG_STATUS_ID ASC) PRIOR_MVX_CORE_REASON
              , LAG(e.START_DATE, 1) OVER (PARTITION BY e.client_id ORDER BY e.CLIENT_ELIG_STATUS_ID ASC) PRIOR_START_DATE
              , LAG(e.END_DATE, 1) OVER (PARTITION BY e.client_id ORDER BY e.CLIENT_ELIG_STATUS_ID ASC) PRIOR_END_DATE
FROM emrs_d_client_eligibility e
WHERE end_date IS NULL),
ohc AS(
SELECT *
FROM emrs_d_other_health_care ohc 
WHERE (ohc.ohc_end_date > SYSDATE OR ohc.ohc_end_date IS NULL) )
SELECT /*+ parallel(10) */
    cl.client_id AS CLIENT_ID,
    cl.client_id AS CURRENT_CLIENT_ID,
    cl.clnt_cin AS CLNT_CIN ,
    cl.clnt_clnt_client_id AS CLNT_CLNT_CLIENT_ID ,
    cl.client_type_cd AS CLIENT_TYPE_CD ,
    cl.clnt_dob AS DATE_OF_BIRTH ,
    cl.clnt_expected_dob AS CLNT_EXPECTED_DOB ,
    cl.clnt_not_born AS CLNT_NOT_BORN ,
    'MA/MB' as MA_MB_019_75,
    EXTRACT(YEAR FROM (TRUNC(sysdate) - cl.clnt_dob) YEAR TO MONTH) AS AGE ,
    COALESCE(cl.clnt_citizen, '0') AS CITIZENSHIP_CODE,
    COALESCE(cl.clnt_ethnicity, 'X') AS CLNT_ETHNICITY ,
    COALESCE(cl.clnt_race, 'X') AS RACE_CODE ,
    COALESCE(cl.clnt_gender_cd, 'U') AS SEX ,
    COALESCE(cl.clnt_marital_cd, 'X') AS CLNT_MARITAL_CD ,
    cl.clnt_status_cd AS CLNT_STATUS_CD ,
    cl.clnt_fname AS FIRST_NAME ,
    SUBSTR(cl.clnt_mi,1,1) AS MIDDLE_INITIAL ,
    cl.clnt_lname AS LAST_NAME ,
    cl.suffix AS SUFFIX,
    cl.clnt_fname||
    CASE
      WHEN SUBSTR(cl.clnt_mi,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(cl.clnt_mi,1,1)||' '
    END ||cl.clnt_lname ||
    CASE  WHEN cl.suffix IS NULL
      THEN NULL
      ELSE ' '||cl.suffix
    END
    AS FULL_NAME,
    cl.clnt_ssn AS SOCIAL_SECURITY_NUMBER ,
    COALESCE(ce.PREGNANCY_FLAG, 0) AS PREGNANT_MEMBER ,
    CASE
      WHEN EXTRACT(YEAR FROM(TRUNC(sysdate) - cl.clnt_dob) YEAR TO MONTH) < 1
      THEN 'Y'
      ELSE 'N'
    END AS NEWBORN ,
    CASE
      WHEN EXTRACT(YEAR FROM(TRUNC(sysdate) - cl.clnt_dob) YEAR TO MONTH) < 21
      THEN 'C'
      ELSE 'A'
    END AS ADULT_OR_CHILD ,
    cl.clnt_dod AS DATE_OF_DEATH ,
    cl.dod_source_cd AS DATE_OF_DEATH_SOURCE,
    cl.clnt_from_pacmis AS CLNT_FROM_PACMIS ,
    cl.clnt_hipaa_privacy_ind AS CLNT_HIPAA_PRIVACY_IND ,
    cl.clnt_comment AS CLNT_COMMENT ,
    cl.note_ref_id AS NOTE_REF_ID ,
    cl.clnt_preg_term_date AS CLNT_PREG_TERM_DATE ,
    cl.clnt_preg_term_reas_cd AS CLNT_PREG_TERM_REAS_CD ,
    COALESCE(cl.state_language, 'AH') AS STATE_LANGUAGE ,
    COALESCE(cl.written_language, 'AH') AS WRITTEN_LANGUAGE ,
    cl.do_not_call_ind AS DO_NOT_CALL_IND ,
    cl.do_not_email_ind AS DO_NOT_EMAIL_IND ,
    cl.do_not_text_ind AS DO_NOT_TEXT_IND ,
    cl.domestic_violence_ind AS DOMESTIC_VIOLENCE_IND ,
    cl.english_fluency_cd AS ENGLISH_FLUENCY_CD ,
    cl.english_literacy_cd AS ENGLISH_LITERACY_CD ,
    CASE
      WHEN ohc.ohc_id IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS THIRD_PARTY_RESOURCES_AVAIL ,
    cl.clnt_generic_field3_num AS CLNT_GENERIC_FIELD3_NUM ,
    COALESCE(CAST(cl.clnt_generic_field4_num AS varchar(10)), 'UD') AS CLNT_GENERIC_FIELD4_NUM ,
    cl.clnt_generic_field5_txt AS CLNT_GENERIC_FIELD5_TXT ,
    cl.clnt_generic_field6_txt AS CLNT_GENERIC_FIELD6_TXT ,
    cl.clnt_generic_field7_txt AS CLNT_GENERIC_FIELD7_TXT ,
    cl.clnt_generic_field8_txt AS CLNT_GENERIC_FIELD8_TXT ,
    NULL AS CLIENT_REPORTED_SHCN ,
    NULL AS COVERAGE_TYPE ,
    NULL AS MANAGED_CARE_CANDIDATE ,
    NULL AS MANAGED_VIA_GEN_REV_FLAG ,
    NULL AS MANAGED_VIA_STATE_FUND_FLAG ,
    NULL AS MIGRANT_WORKER_FLAG ,
    NULL AS PLAN_REPORTED_SHCN,
    NULL AS RECEIVING_TANF_FLAG ,
    NULL AS RECEIVING_SSI_FLAG ,
    cl.sched_auto_assign_date AS SCHED_AUTO_ASSIGN_DATE ,
    NULL AS TRANSACTION_HOLD ,
    ceg.MVX_CORE_REASON AS MVX_CORE_REASON,
    ceg.PRIOR_MVX_CORE_REASON AS PRIOR_MVX_CORE_REASON,
    COALESCE(ceg.SUBPROGRAM_TYPE, 'UD') AS SUBPROGRAM_CODE,
    COALESCE(ceg.PRIOR_SUBPROGRAM_TYPE, 'UD') AS PRIOR_SUBPROGRAM_CODE,
    COALESCE(CASE WHEN SUBSTR(ceg.mvx_core_reason,1,3) = 'V10' THEN '06'
      ELSE ce.COA
    END, '0') AS COA,
    ce.AC_TC,
    ce.AID_CATEGORY AS AID_CATEGORY_CODE,
    ce.TYPE_CASE,
    ce.ME_START_DATE,
    ce.ME_START_ND,
    ce.ME_END_DATE,
    ce.ME_END_ND,
    COALESCE(CASE WHEN SUBSTR(ceg.PRIOR_MVX_CORE_REASON,1,3) = 'V10' THEN '06'
      ELSE ce.PRIOR_COA
    END, '0') AS PRIOR_COA,
    ce.PRIOR_AC || '/' || ce.PRIOR_TC AS PRIOR_AC_TC,
    ce.PRIOR_AC AS PRIOR_AID_CATEGORY_CODE,
    ce.PRIOR_TC AS PRIOR_TYPE_CASE,
    ce.PRIOR_START_DATE AS PRIOR_ME_START_DATE,
    ce.PRIOR_END_DATE AS PRIOR_ME_END_DATE,
    cl.record_date AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    cl.last_state_update_ts AS LAST_STATE_UPDATE_TS ,
    cl.last_state_updated_by AS LAST_STATE_UPDATED_BY ,
    cl.record_date AS RECORD_DATE ,
    cl.record_time AS RECORD_TIME ,
    cl.record_name AS RECORD_NAME ,
    cl.modified_date AS MODIFIED_DATE ,
    cl.modified_time AS MODIFIED_TIME ,
    cl.modified_name AS MODIFIED_NAME ,
    ceg.plan_type_cd AS plan_type
  FROM emrs_d_client cl
  /*LEFT JOIN (SELECT *
             FROM (SELECT ce.*, RANK() OVER(PARTITION BY ce.client_id,ce.sequence_num ORDER BY elig_segment_and_details_id DESC) rnk
             FROM D_CLIENT_ELIGIBILITY ce )
             WHERE rnk =1) ce ON (cl.client_id = ce.client_id AND ce.SEQUENCE_NUM =1)*/
  LEFT JOIN dme ce ON (cl.client_id = ce.client_id)         
  LEFT JOIN ceg ON (cl.client_id = ceg.client_id)
  LEFT JOIN ohc ON (ohc.client_id = cl.client_id);

GRANT SELECT ON EMRS_D_CLIENT_SV TO &role_name;


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CLIENT','ERRLOG_CLIENT');
  end;
/


-- Create table
create table EMRS_S_CLIENT_STG
(
    client_id NUMBER(18,0),
    clnt_clnt_client_id NUMBER(18,0),
    clnt_fname VARCHAR2(25 ),    
    clnt_lname VARCHAR2(40 ),    
    clnt_mi VARCHAR2(25 ),
    clnt_gender_cd VARCHAR2(32 ),
    clnt_citizen VARCHAR2(32 ),
    clnt_ethnicity VARCHAR2(32 ),
    clnt_race VARCHAR2(32 ),
    clnt_dob DATE,
    clnt_dod DATE,
    clnt_tpl_present VARCHAR2(1 ),
    clnt_ssn VARCHAR2(30 ),
    clnt_national_id VARCHAR2(64 ),
    clnt_from_pacmis VARCHAR2(1 ),
    clnt_share_premium VARCHAR2(1 ),
    clnt_not_born VARCHAR2(1 ),
    clnt_hipaa_privacy_ind VARCHAR2(1 ),
    clnt_finet_vendor_nbr VARCHAR2(10 ),
    clnt_enroll_status VARCHAR2(32 ),
    clnt_enroll_status_date DATE,
    sched_auto_assign_date DATE,
    clnt_cin VARCHAR2(30 ),
    clnt_comment VARCHAR2(4000 ),
    created_by VARCHAR2(80 ),
    creation_date DATE,
    last_updated_by VARCHAR2(80 ),
    last_update_date DATE,
    clnt_pseudo_id VARCHAR2(10 ),
    clnt_display_name VARCHAR2(80 ),
    ssnvl_id NUMBER(38,0),
    note_ref_id NUMBER(18,0),
    clnt_marital_cd VARCHAR2(32 ),
    clnt_status_cd VARCHAR2(32 ),
    clnt_expected_dob DATE,
    clnt_preg_term_date DATE,
    clnt_preg_term_reas_cd VARCHAR2(32 ),
    client_type_cd VARCHAR2(10 ),
    supplemental_nbr VARCHAR2(32 ),
    client_language VARCHAR2(32 ),
    state_language VARCHAR2(32 ),
    do_not_call_ind NUMBER(1,0),
    written_language VARCHAR2(32 ),
    suffix VARCHAR2(32 ),
    salutation_cd VARCHAR2(32 ),
    domestic_violence_ind NUMBER(1,0),
    english_fluency_cd VARCHAR2(32 ),
    english_literacy_cd VARCHAR2(32 ),
    tribe_cd VARCHAR2(32 ),
    clnt_generic_field1_date DATE,
    clnt_generic_field2_date DATE,
    clnt_generic_field3_num NUMBER(18,0),
    clnt_generic_field4_num NUMBER(18,0),
    clnt_generic_field5_txt VARCHAR2(256 ),
    clnt_generic_field6_txt VARCHAR2(256 ),
    clnt_generic_field7_txt VARCHAR2(256 ),
    clnt_generic_field8_txt VARCHAR2(256 ),
    clnt_generic_field9_txt VARCHAR2(256 ),
    clnt_generic_field10_txt VARCHAR2(256 ),
    clnt_generic_ref11_id NUMBER(18,0),
    clnt_generic_ref12_id NUMBER(18,0),
    dod_source_cd VARCHAR2(32 ),
    do_not_text_ind NUMBER(1,0),
    do_not_email_ind NUMBER(1,0),
    last_state_update_ts DATE,
    last_state_updated_by NUMBER(18,0),
    comparable_key VARCHAR2(2000)
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
grant select on EMRS_S_CLIENT_STG to &role_name;

create index STG_IDX2_CLIENTNUM on EMRS_S_CLIENT_STG (CLIENT_ID)
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


