CREATE OR REPLACE VIEW EMRS_D_SELECTION_SOURCE_SV
AS
  SELECT pt.value managed_care_program ,
    e.value selection_source_code ,
    DECODE(e.value,'A','N','Y') is_choice_ind ,
    NULL source_record_id ,
    e.description selection_source ,
    NULL selection_source_id
  FROM eb.enum_enrollment_trans_source e
  CROSS JOIN eb.enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION ALL
  SELECT 
    'MEDICAID' AS managed_care_program,
    'State Facilitated' AS selection_source_code,
    NULL AS is_choice_ind,
    NULL source_record_id,
    'State Facilitated' AS selection_source,
    NULL selection_source_id
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_SELECTION_SOURCE_SV TO EB_MAXDAT_REPORTS;