CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_ERROR_CD_SV
AS
  SELECT 
    ee.value enrollment_error_code ,
    ee.description enrollment_error_description ,
    ee.warning_ind ,
    ee.denial_reason_ind ,
    ee.needs_image_ind ,
    NULL source_record_id ,
    ee.do_not_persist_ind ,
    ee.recycle_ind ,
    ee.denied_letter_ind ,
    ee.on_denial_create_task_ind ,
    ee.correct_for_plan_svc_types ,
    pt.value managed_care_program ,
    ee.manual_edit_ind
  FROM enum_enrollment_error_code ee
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL 
  UNION
  SELECT 
    '0' enrollment_error_code ,
    'Not Defined' enrollment_error_description ,
    0 warning_ind ,
    null denial_reason_ind ,
    0 needs_image_ind ,
    NULL source_record_id ,
    0 do_not_persist_ind ,
    0 recycle_ind ,
    0 denied_letter_ind ,
    null on_denial_create_task_ind ,
    null correct_for_plan_svc_types ,
    'MEDICAID' managed_care_program ,
    0 manual_edit_ind
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV TO MAXDAT_REPORTS;