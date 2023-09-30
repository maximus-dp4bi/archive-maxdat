CREATE OR REPLACE VIEW EMRS_D_REJECTION_ERROR_RSN_SV
AS
  SELECT NULL rejection_error_reason_id ,
    pt.value managed_care_program ,
    pt.value rejection_category ,
    NULL source_record_id ,
    dec.value rejection_code ,
    SUBSTR(dec.description,1,25) rejection_error_reason ,
    dec.description rejection_error_description ,
    'AIDP.P1BPIX01' related_files --find out what this is for WV
  FROM enum_denial_error_code DEC
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_REJECTION_ERROR_RSN_SV TO EB_MAXDAT_REPORTS; 