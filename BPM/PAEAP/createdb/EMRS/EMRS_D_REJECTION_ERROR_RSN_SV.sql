CREATE OR REPLACE VIEW EMRS_D_REJECTION_ERROR_RSN_SV
AS
  SELECT 
    pt.value managed_care_program ,
    pt.value rejection_category ,
    NULL source_record_id ,
    dec.value rejection_code ,
    SUBSTR(dec.description,1,25) rejection_error_reason ,
    dec.description rejection_error_description ,
    'AIDP.P1BPIX01' related_files --find out what this is for PA
  FROM enum_denial_error_code DEC
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION ALL
   SELECT 
    'UNKNOWN' AS managed_care_program ,
    'UNKNOWN' AS rejection_category ,
    NULL source_record_id ,
    '0' rejection_code ,
    'UNKNOWN' AS rejection_error_reason ,
    'UNKNOWN' AS rejection_error_description ,
    'AIDP.P1BPIX01' related_files --find out what this is for PA
    FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_REJECTION_ERROR_RSN_SV TO EB_MAXDAT_REPORTS; 