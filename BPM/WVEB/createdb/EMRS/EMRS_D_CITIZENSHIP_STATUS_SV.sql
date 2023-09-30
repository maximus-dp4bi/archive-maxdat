CREATE OR REPLACE VIEW EMRS_D_CITIZENSHIP_STATUS_SV
AS
  SELECT pt.value managed_care_program ,
    e.description citizenship_description ,
    NULL source_record_id ,
    NULL citizenship_id ,
    e.value citizenship_code
  FROM enum_citizen e
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_CITIZENSHIP_STATUS_SV TO EB_MAXDAT_REPORTS; 