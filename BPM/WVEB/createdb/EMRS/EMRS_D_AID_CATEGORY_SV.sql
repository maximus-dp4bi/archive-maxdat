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
    NULL aid_category_id ,
    effective_start_date start_date ,
    description aid_category_name
  FROM eb.enum_aid_category ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_AID_CATEGORY_SV TO EB_MAXDAT_REPORTS;