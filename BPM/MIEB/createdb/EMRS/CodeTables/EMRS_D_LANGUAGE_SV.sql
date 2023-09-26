CREATE OR REPLACE VIEW EMRS_D_LANGUAGE_SV
AS
  SELECT 
    pt.value managed_care_program ,
    l.value language_code ,
    NULL source_record_id ,
    l.effective_start_date business_start_date ,
    l.effective_end_date business_end_date ,
    l.description language
  FROM enum_language l
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL 
  UNION ALL
    SELECT 
    'UNKNOWN' AS managed_care_program ,
    '0' AS language_code ,
    NULL source_record_id ,
    NULL AS business_start_date ,
    NULL AS business_end_date ,
    'UNKNOWN' AS language
    FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV TO MAXDAT_REPORTS;