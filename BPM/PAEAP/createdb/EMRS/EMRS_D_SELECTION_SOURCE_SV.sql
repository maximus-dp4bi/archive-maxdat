CREATE OR REPLACE VIEW EMRS_D_SELECTION_SOURCE_SV
AS
  SELECT pt.value managed_care_program ,
    e.value selection_source_code ,
    DECODE(e.value,'6','N','Y') is_choice_ind ,
    NULL source_record_id ,
    e.description selection_source     
  FROM eb.enum_enrollment_trans_source e
  CROSS JOIN eb.enum_program_type pt
  WHERE pt.effective_end_date IS NULL 
  AND (e.effective_end_date IS NULL OR e.value = '6')
  UNION
  SELECT 'MEDICAID' managed_care_program ,
    '0' selection_source_code ,
    'X' is_choice_ind ,
    NULL source_record_id ,
    'Not Defined' selection_source     
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV TO EB_MAXDAT_REPORTS;