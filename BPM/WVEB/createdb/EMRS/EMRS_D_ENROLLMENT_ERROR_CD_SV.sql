CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_ERROR_CD_SV
AS
  SELECT NULL enrollment_error_code_id ,
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
  WHERE pt.effective_end_date IS NULL ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_ENROLLMENT_ERROR_CD_SV TO EB_MAXDAT_REPORTS;