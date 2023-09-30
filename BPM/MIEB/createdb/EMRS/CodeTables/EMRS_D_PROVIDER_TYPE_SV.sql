CREATE OR REPLACE VIEW EMRS_D_PROVIDER_TYPE_SV
AS
  SELECT 
    pt.value managed_care_program ,
    ept.description provider_name ,
    NULL source_record_id ,
    'Y' valid ,
    'N' invalid ,
    ept.value provider_code
  FROM enum_provider_type ept,
    enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION
  SELECT 
    'MEDICAID' managed_care_program ,
    'Not Defined' provider_name ,
    NULL source_record_id ,
    'Y' valid ,
    'N' invalid ,
    '0' provider_code
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_TYPE_SV TO MAXDAT_REPORTS; 