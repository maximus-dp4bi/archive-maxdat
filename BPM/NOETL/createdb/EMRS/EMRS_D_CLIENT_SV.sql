CREATE OR REPLACE VIEW EMRS_D_CLIENT_SV
AS
  SELECT
    cl.clnt_client_id AS CLIENT_ID,    
    cl.clnt_client_id AS CURRENT_CLIENT_ID,
    cl.clnt_cin AS CLNT_CIN ,
    cl.clnt_clnt_client_id AS CLNT_CLNT_CLIENT_ID ,
    cl.client_type_cd AS CLIENT_TYPE_CD ,
    cl.clnt_dob AS DATE_OF_BIRTH ,
    cl.clnt_expected_dob AS CLNT_EXPECTED_DOB ,
    cl.clnt_not_born AS CLNT_NOT_BORN ,
    EXTRACT(YEAR FROM(TRUNC(sysdate) - cl.clnt_dob) YEAR TO MONTH) AS AGE ,
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
    END ||cl.clnt_lname AS FULL_NAME ,
    cl.clnt_ssn AS SOCIAL_SECURITY_NUMBER ,
    CASE 
        WHEN cl2.clnt_expected_dob < sysdate
        THEN 'Y' 
        ELSE 'N' 
    END AS PREGNANT_MEMBER ,
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
    cl.creation_date AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    cl.last_state_update_ts AS LAST_STATE_UPDATE_TS ,
    cl.last_state_updated_by AS LAST_STATE_UPDATED_BY ,
    cl.creation_date AS RECORD_DATE ,
    TO_CHAR(cl.creation_date,'HH24MI') AS RECORD_TIME ,
    cl.created_by AS RECORD_NAME ,
    cl.last_update_date AS MODIFIED_DATE ,
    TO_CHAR(cl.last_update_date,'HH24MI') AS MODIFIED_TIME ,
    cl.last_updated_by AS MODIFIED_NAME 
  FROM EB.client cl  
  LEFT JOIN EB.client cl2 ON (cl2.clnt_clnt_client_id = cl.clnt_client_id)
  LEFT JOIN EB.other_health_care ohc ON (ohc.ohc_client_id = cl.clnt_client_id AND (ohc.ohc_end_date > SYSDATE OR ohc.ohc_end_date IS NULL));
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_SV TO MAXDAT_REPORTS;
