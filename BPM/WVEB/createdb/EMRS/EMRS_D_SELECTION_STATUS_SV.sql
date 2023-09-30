CREATE OR REPLACE VIEW EMRS_D_SELECTION_STATUS_SV
AS
  SELECT NULL selection_status_id ,
    ss.value selection_status_code ,
    ss.description selection_status_description ,
    ss.overwrite_ind ,
    NULL source_record_id ,
    ss.valid_selection_ind ,
    ss.allow_new_selection_ind ,
    pt.value managed_care_program ,
    ss.overwrite_to_value
  FROM eb.enum_selection_status ss
  CROSS JOIN eb.enum_program_type pt
  WHERE pt.effective_end_date IS NULL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_SELECTION_STATUS_SV TO EB_MAXDAT_REPORTS;