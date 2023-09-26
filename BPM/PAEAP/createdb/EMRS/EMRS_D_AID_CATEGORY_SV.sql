CREATE OR REPLACE VIEW EMRS_D_AID_CATEGORY_SV
AS
  SELECT
    CASE
      WHEN effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END active_inactive ,
    effective_end_date end_date ,
    COALESCE(scope,'MEDICAID') managed_care_program ,
    NULL source_record_id ,
    value aid_category_code ,
    effective_start_date start_date ,
    description aid_category_name ,
    subprogram_codes subprogram_code
  FROM eb.enum_aid_category 
  UNION  
  SELECT 
    'A' AS active_inactive,
     NULL AS end_date,
     'MEDICAID' as managed_care_program,
     NULL source_record_id,
     '0' AS aid_category_code,
     TO_DATE('01/01/1900','MM/DD/YYYY') start_date,
     'Not Defined' AS aid_category_name  ,
     '0' subprogram_code
  FROM DUAL ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AID_CATEGORY_SV TO EB_MAXDAT_REPORTS;