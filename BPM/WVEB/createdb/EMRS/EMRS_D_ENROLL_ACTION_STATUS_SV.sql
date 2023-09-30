CREATE OR REPLACE VIEW EMRS_D_ENROLL_ACTION_STATUS_SV
AS
  SELECT e.value enrollment_action_status_code ,
    e.description enrollment_action_status_code_ ,
    pt.value managed_care_program ,
    NULL enrollment_action_status_id ,
    NULL source_record_id
  FROM enum_enrollment_trans_type e
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_ENROLL_ACTION_STATUS_SV TO EB_MAXDAT_REPORTS;