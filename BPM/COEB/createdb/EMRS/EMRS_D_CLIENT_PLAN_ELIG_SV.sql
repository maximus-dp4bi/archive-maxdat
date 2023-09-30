CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_ELIG_SV
AS
  SELECT
    client_elig_status_id AS CLIENT_PLAN_ELIGIBILITY_ID ,
    client_id AS CLIENT_ID ,     
    elig_status_cd AS CURRENT_ELIGIBILITY_STATUS_CD ,
    COALESCE(elig_status_cd, '0') AS ELIGIBILITY_STATUS_CODE ,
    COALESCE(plan_type_cd, '0') AS PLAN_TYPE ,
    program_cd AS MANAGED_CARE_PROGRAM,
    CASE
      WHEN end_date IS NULL
      THEN 'Y'
      ELSE 'N'
    END AS CURRENT_FLAG ,
    subprogram_type AS SUB_PROGRAM_CODE ,
    start_date AS START_DATE,
    end_date AS END_DATE,
    start_date AS DATE_OF_VALIDITY_START ,
    COALESCE(end_date, TO_DATE('12/31/2050','mm/dd/yyyy')) AS DATE_OF_VALIDITY_END ,
    create_ts AS RECORD_DATE ,
    created_by AS RECORD_NAME ,
    update_ts AS MODIFIED_DATE ,
    updated_by AS MODIFIED_NAME 
  FROM &schema_name..client_elig_status;

  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_PLAN_ELIG_SV TO MAXDAT_REPORTS; 