CREATE OR REPLACE VIEW EMRS_D_SELECTION_REASON_SV
AS
  SELECT pt.value managed_care_program ,
    e.value selection_reason_code ,
    e.description selection_reason ,
    NULL source_record_id ,
    NULL selection_reason_id
  FROM enum_choice_reason e
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_SELECTION_REASON_SV TO EB_MAXDAT_REPORTS; 