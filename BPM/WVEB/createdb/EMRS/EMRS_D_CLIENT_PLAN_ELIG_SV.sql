CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_ELIG_SV
AS
  SELECT
    CASE
      WHEN end_date IS NULL
      THEN 1
      ELSE 0
    END AS VERSION ,
    client_elig_status_id AS SOURCE_RECORD_ID ,
    client_elig_status_id AS CLIENT_PLAN_ELIGIBILITY_ID ,
    client_id AS CLIENT_NUMBER ,
    NULL AS PLAN_TYPE_ID ,
    elig_status_cd AS ELIGIBILITY_STATUS_CODE ,
    CASE
      WHEN end_date IS NULL
      THEN 'Y'
      ELSE 'N'
    END AS CURRENT_FLAG ,
    created_by AS CREATED_BY ,
    create_ts AS DATE_CREATED ,
    start_date AS DATE_OF_VALIDITY_START ,
    COALESCE(end_date, TO_DATE('12/31/2050','mm/dd/yyyy')) AS DATE_OF_VALIDITY_END ,
    update_ts AS DATE_UPDATED ,
    updated_by AS UPDATED_BY ,
    elig_status_cd AS CURRENT_ELIGIBILITY_STATUS_CD ,
    NULL AS SUB_PROGRAM_ID ,
    plan_type_cd AS PLAN_TYPE ,
    subprogram_type AS SUB_PROGRAM_CODE ,
    program_cd AS MANAGED_CARE_PROGRAM
  FROM client_elig_status;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_CLIENT_PLAN_ELIG_SV TO EB_MAXDAT_REPORTS; 