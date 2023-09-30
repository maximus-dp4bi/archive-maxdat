CREATE OR REPLACE VIEW EMRS_D_LANGUAGE_SV
AS
  SELECT NULL language_code_id ,
    pt.value managed_care_program ,
    l.value language_code ,
    NULL source_record_id ,
    l.effective_start_date business_start_date ,
    l.effective_end_date business_end_date ,
    l.description language
  FROM enum_language l
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_LANGUAGE_SV TO EB_MAXDAT_REPORTS;