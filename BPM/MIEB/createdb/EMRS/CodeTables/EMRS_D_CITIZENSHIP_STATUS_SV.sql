CREATE OR REPLACE VIEW EMRS_D_CITIZENSHIP_STATUS_SV
AS
  SELECT pt.value managed_care_program ,
    e.description citizenship_description ,
    NULL source_record_id ,    
    e.value citizenship_code
  FROM enum_citizen e
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION
  SELECT 'MEDICAID' managed_care_program ,
    'Not Defined' citizenship_description ,
    NULL source_record_id ,    
    '0' citizenship_code
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV TO MAXDAT_REPORTS; 