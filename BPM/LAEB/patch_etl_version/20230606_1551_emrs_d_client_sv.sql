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
  
  GRANT SELECT ON EMRS_D_CLIENT_SV TO MAXDAT_LAEB_READ_ONLY;