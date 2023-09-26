DROP VIEW MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV
AS
SELECT 
    cscl_id AS CASE_CLIENT_ID,
    cscl_case_id AS CASE_ID,
    cscl_clnt_client_id AS CLIENT_ID,
    anniversary_dt AS ANNIVERSARY_DT,
    cscl_elig_begin_dt AS CSCL_ELIG_BEGIN_DT,
    cscl_elig_end_dt AS CSCL_ELIG_END_DT,
    elig_begin_nd AS ELIG_BEGIN_ND,
    elig_end_nd AS ELIG_END_ND,
    cscl_elig_determination_date AS CSCL_ELIG_DETERMINATION_DATE,
    cscl_status_cd AS CSCL_STATUS_CD,
    cscl_status_begin_date AS CSCL_STATUS_BEGIN_DATE,
    cscl_status_end_date AS CSCL_STATUS_END_DATE,
    status_begin_ndt AS STATUS_BEGIN_NDT,
    status_end_ndt AS STATUS_END_NDT,
    cscl_close_reason AS CSCL_CLOSE_REASON,
    COALESCE(cscl_relationship_cd, '0') AS CSCL_RELATIONSHIP_CD,
    cscl_medical_ind AS CSCL_MEDICAL_IND,
    COALESCE(cscl_adlk_id, '0') AS CSCL_ADLK_ID,
    COALESCE(cscl_res_addr_id, 0) AS CSCL_RES_ADDR_ID,
    program_cd AS MANAGED_CARE_PROGRAM,
    change_notes AS CHANGE_NOTES,
    cscl_appl_client_id AS CSCL_APPL_CLIENT_ID,
    cscl_byb_temp_id AS CSCL_BYB_TEMP_ID,
    cscl_actual_term_date AS  CSCL_ACTUAL_TERM_DATE,
    cscl_legacy AS CSCL_LEGACY,
    cscl_pacmis_status_cd AS CSCL_PACMIS_STATUS_CD,
    episode_id AS EPISODE_ID,
    program_status_cd AS PROGRAM_STATUS_CD,
    rhsp AS RHSP,
    rhga AS RHGA,
    TRUNC(last_update_date) AS MODIFIED_DATE,
    TO_CHAR(last_update_date,'HH24MI') AS MODIFIED_TIME,
    last_updated_by AS MODIFIED_NAME,
    TRUNC(creation_date) AS RECORD_DATE,
    TO_CHAR(creation_date,'HH24MI') AS RECORD_TIME,
    created_by AS RECORD_NAME
  FROM eb.case_client;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_CLIENT_SV TO MAXDAT_SUPPORT_READ_ONLY;
