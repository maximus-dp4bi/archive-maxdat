CREATE OR REPLACE VIEW EMRS_D_PROVIDER_TYPE_SV
AS
  SELECT NULL provider_type_id ,
    pt.value managed_care_program ,
    ept.description provider_name ,
    NULL source_record_id ,
    'Y' valid ,
    'N' invalid ,
    ept.value provider_code
  FROM enum_provider_type ept,
    enum_program_type pt
  WHERE pt.effective_end_date IS NULL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_PROVIDER_TYPE_SV TO EB_MAXDAT_REPORTS; 