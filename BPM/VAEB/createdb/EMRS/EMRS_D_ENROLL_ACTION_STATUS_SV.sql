CREATE OR REPLACE VIEW EMRS_D_ENROLL_ACTION_STATUS_SV
AS
  SELECT e.value enrollment_action_status_code ,
    e.description enrollment_action_status_code_ ,
    pt.value managed_care_program ,
    NULL source_record_id
  FROM enum_enrollment_trans_type e
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION ALL
  SELECT 'State_Facilitated_Enrollment' AS enrollment_action_status_code ,
    'State Facilitated' AS enrollment_action_status_code_ ,
    'MEDICAID' AS managed_care_program ,
    NULL source_record_id
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_ACTION_STATUS_SV TO MAXDAT_REPORTS;