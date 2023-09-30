CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPEC_CD_SV
AS
  SELECT 
    ps.value provider_specialty_code ,
    ps.description provider_specialty ,
    NULL source_record_id ,
    'N' invalid_pcp ,
    'N' special_needs ,
    pt.value managed_care_program ,
    'Y' valid_pcp
  FROM enum_provider_specialty ps
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL
UNION
SELECT '0' provider_specialty_code ,
    'Not Defined' provider_specialty ,
    NULL source_record_id ,
    'N' invalid_pcp ,
    'N' special_needs ,
    'MEDICAID' managed_care_program ,
    'N' valid_pcp
FROM DUAL;    
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_SPEC_CD_SV TO EB_MAXDAT_REPORTS; 