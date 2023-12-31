DROP VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV
AS
SELECT client_enroll_status_id AS CLIENT_ENROLL_STATUS_ID ,
    client_id AS CLIENT_ID ,
    CASE
      WHEN end_date IS NULL
      THEN 'Y'
      ELSE 'N'
    END AS CURRENT_FLAG ,
    program_cd AS MANAGED_CARE_PROGRAM ,
    COALESCE(plan_type_cd, '0') AS PLAN_TYPE ,
    enroll_status_cd AS CURRENT_ENROLLMENT_STATUS,
    enroll_status_cd AS ENROLLMENT_STATUS_CODE ,
    start_date AS START_DATE,
    end_date AS END_DATE,
    start_date AS DATE_OF_VALIDITY_START ,
    COALESCE(end_date,TO_DATE('12/31/2050','mm/dd/yyyy')) AS DATE_OF_VALIDITY_END ,
    create_ts AS RECORD_DATE ,
    created_by AS RECORD_NAME ,
    update_ts AS MODIFIED_DATE ,
    updated_by AS MODIFIED_NAME
  FROM client_enroll_status;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV TO MAXDAT_SUPPORT_READ_ONLY;
