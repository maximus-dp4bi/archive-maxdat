CREATE OR REPLACE VIEW EMRS_D_CLIENT_SV
AS
  SELECT cl.dod_source_cd AS DATE_OF_DEATH_SOURCE ,
    cl.clnt_client_id AS SOURCE_RECORD_ID ,
    'Y' AS CURRENT_FLAG ,
    cl.clnt_client_id AS CURRENT_CLIENT_ID ,
    cl.clnt_clnt_client_id AS CLNT_CLNT_CLIENT_ID ,
    cl.clnt_ethnicity AS CLNT_ETHNICITY ,
    cl.clnt_tpl_present AS CLNT_TPL_PRESENT ,
    cl.clnt_national_id AS CLNT_NATIONAL_ID ,
    cl.clnt_from_pacmis AS CLNT_FROM_PACMIS ,
    cl.clnt_share_premium AS CLNT_SHARE_PREMIUM ,
    cl.clnt_not_born AS CLNT_NOT_BORN ,
    cl.clnt_hipaa_privacy_ind AS CLNT_HIPAA_PRIVACY_IND ,
    cl.clnt_finet_vendor_nbr AS CLNT_FINET_VENDOR_NBR ,
    cl.clnt_enroll_status AS CLNT_ENROLL_STATUS ,
    cl.clnt_enroll_status_date AS CLNT_ENROLL_STATUS_DATE ,
    cl.sched_auto_assign_date AS SCHED_AUTO_ASSIGN_DATE ,
    cl.clnt_cin AS CLNT_CIN ,
    cl.clnt_comment AS CLNT_COMMENT ,
    cl.clnt_pseudo_id AS CLNT_PSEUDO_ID ,
    cl.ssnvl_id AS SSNVL_ID ,
    cl.note_ref_id AS NOTE_REF_ID ,
    cl.clnt_marital_cd AS CLNT_MARITAL_CD ,
    cl.clnt_status_cd AS CLNT_STATUS_CD ,
    cl.clnt_expected_dob AS CLNT_EXPECTED_DOB ,
    cl.clnt_preg_term_date AS CLNT_PREG_TERM_DATE ,
    cl.clnt_preg_term_reas_cd AS CLNT_PREG_TERM_REAS_CD ,
    cl.client_type_cd AS CLIENT_TYPE_CD ,
    cl.supplemental_nbr AS SUPPLEMENTAL_NBR ,
    cl.state_language AS STATE_LANGUAGE ,
    cl.do_not_call_ind AS DO_NOT_CALL_IND ,
    cl.written_language AS WRITTEN_LANGUAGE ,
    cl.suffix AS SUFFIX ,
    cl.salutation_cd AS SALUTATION_CD ,
    cl.domestic_violence_ind AS DOMESTIC_VIOLENCE_IND ,
    cl.english_fluency_cd AS ENGLISH_FLUENCY_CD ,
    cl.english_literacy_cd AS ENGLISH_LITERACY_CD ,
    cl.tribe_cd AS TRIBE_CD ,
    cl.clnt_generic_field1_date AS CLNT_GENERIC_FIELD1_DATE ,
    cl.clnt_generic_field2_date AS CLNT_GENERIC_FIELD2_DATE ,
    cl.clnt_generic_field3_num AS CLNT_GENERIC_FIELD3_NUM ,
    cl.clnt_generic_field4_num AS CLNT_GENERIC_FIELD4_NUM ,
    cl.clnt_generic_field5_txt AS CLNT_GENERIC_FIELD5_TXT ,
    cl.clnt_generic_field6_txt AS CLNT_GENERIC_FIELD6_TXT ,
    cl.clnt_generic_field7_txt AS CLNT_GENERIC_FIELD7_TXT ,
    cl.clnt_generic_field8_txt AS CLNT_GENERIC_FIELD8_TXT ,
    cl.clnt_generic_field9_txt AS CLNT_GENERIC_FIELD9_TXT ,
    cl.clnt_generic_field10_txt AS CLNT_GENERIC_FIELD10_TXT ,
    cl.clnt_generic_ref11_id AS CLNT_GENERIC_REF11_ID ,
    cl.clnt_generic_ref12_id AS CLNT_GENERIC_REF12_ID ,
    cl.do_not_text_ind AS DO_NOT_TEXT_IND ,
    cl.do_not_email_ind AS DO_NOT_EMAIL_IND ,
    cl.last_state_update_ts AS LAST_STATE_UPDATE_TS ,
    cl.last_state_updated_by AS LAST_STATE_UPDATED_BY ,
    cl.comparable_key AS COMPARABLE_KEY ,
    EXTRACT(YEAR FROM(TRUNC(sysdate) - clnt_dob) YEAR TO MONTH) AS AGE ,
    clnt_client_id AS CLIENT_NUMBER ,
    'MEDICAID' AS MANAGED_CARE_PROGRAM ,
    cl.clnt_fname||
    CASE
      WHEN SUBSTR(cl.clnt_mi,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(cl.clnt_mi,1,1)||' '
    END ||cl.clnt_lname AS FULL_NAME ,
    cl.clnt_fname AS FIRST_NAME ,
    SUBSTR(cl.clnt_mi,1,1) AS MIDDLE_INITIAL ,
    cl.clnt_lname AS LAST_NAME ,
    cl.clnt_dod AS DATE_OF_DEATH ,
    NULL AS COVERAGE_TYPE ,
    NULL AS ENROLLMENT_STATUS ,
    NULL AS TRANSACTION_HOLD ,
    NULL AS MANAGED_CARE_CANDIDATE ,
    NULL AS BASE_PLAN ,
    cl.clnt_race AS RACE ,
    cl.clnt_gender_cd AS SEX ,
    cl.clnt_dob AS DATE_OF_BIRTH ,
    NULL AS PHONE ,
    cl.clnt_ssn AS SOCIAL_SECURITY_NUMBER ,
    NULL AS ADD1 ,
    NULL AS ADD2 ,
    NULL AS CITY ,
    NULL AS ST ,
    NULL AS ZIP ,
    '0' AS COUNTY ,
    NULL AS SSN_RAILROAD_CLAIM_NUMBER ,
    cl.creation_date AS RECORD_DATE ,
    TO_CHAR(cl.creation_date,'HH24MI') AS RECORD_TIME ,
    cl.created_by AS RECORD_NAME ,
    cl.last_update_date AS MODIFIED_DATE ,
    TO_CHAR(cl.last_update_date,'HH24MI') AS MODIFIED_TIME ,
    cl.last_updated_by AS MODIFIED_NAME ,
    1 AS VERSION ,
    cl.creation_date AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    cl.creation_date AS DATE_CREATED ,
    cl.created_by AS CREATED_BY ,
    cl.last_updated_by AS UPDATED_BY ,
    cl.last_update_date AS DATE_UPDATED ,
    NULL AS PREGNANT_MEMBER ,
    CASE
      WHEN EXTRACT(YEAR FROM(TRUNC(sysdate) - clnt_dob) YEAR TO MONTH) < 1
      THEN 'Y'
      ELSE 'N'
    END AS NEWBORN ,
    CASE
      WHEN EXTRACT(YEAR FROM(TRUNC(sysdate) - clnt_dob) YEAR TO MONTH) < 19
      THEN 'C'
      ELSE 'A'
    END AS ADULT_OR_CHILD ,
    CASE
      WHEN (SELECT COUNT(1)
        FROM eb.other_health_care ohc
        WHERE ohc.ohc_client_id = cl.clnt_client_id
        AND (ohc.ohc_end_date > SYSDATE
        OR ohc.ohc_end_date IS NULL)) > 0
      THEN 'Y'
      ELSE 'N'
    END AS THIRD_PARTY_RESOURCES_AVAIL ,
    NULL AS MIGRANT_WORKER_FLAG ,
    NULL AS MANAGED_VIA_GEN_REV_FLAG ,
    NULL AS MANAGED_VIA_STATE_FUND_FLAG ,
    NULL AS RECEIVING_TANF_FLAG ,
    NULL AS RECEIVING_SSI_FLAG ,
    NULL AS CLIENT_REPORTED_SHCN ,
    NULL AS PLAN_REPORTED_SHCN
  FROM eb.client cl;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_SV TO EB_MAXDAT_REPORTS;