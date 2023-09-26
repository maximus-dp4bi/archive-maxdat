CREATE OR REPLACE VIEW EMRS_D_CLIENT_ENRL_STATUS_SV
AS
  SELECT client_enroll_status_id AS CLIENT_ENROLL_STATUS_ID ,
    client_id AS CLIENT_NUMBER ,
    NULL AS PLAN_TYPE_ID ,
    NULL AS ENROLLMENT_STATUS_ID ,
    NULL AS CURRENT_ENROLLMENT_STATUS_ID ,
    created_by AS CREATED_BY ,
    client_enroll_status_id AS SOURCE_RECORD_ID ,
    start_date AS DATE_OF_VALIDITY_START ,
    COALESCE(end_date,TO_DATE('12/31/2050','mm/dd/yyyy')) AS DATE_OF_VALIDITY_END ,
    update_ts AS DATE_UPDATED ,
    updated_by AS UPDATED_BY ,
    CASE
      WHEN end_date IS NULL
      THEN 'Y'
      ELSE 'N'
    END AS CURRENT_FLAG ,
    CASE
      WHEN end_date IS NULL
      THEN 1
      ELSE 0
    END AS VERSION ,
    create_ts AS DATE_CREATED ,
    plan_type_cd AS PLAN_TYPE ,
    program_cd AS MANAGED_CARE_PROGRAM ,
    enroll_status_cd AS ENROLLMENT_STATUS_CODE ,
    enroll_status_cd AS CURRENT_ENROLLMENT_STATUS
  FROM client_enroll_status;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_CLIENT_ENRL_STATUS_SV TO EB_MAXDAT_REPORTS; 