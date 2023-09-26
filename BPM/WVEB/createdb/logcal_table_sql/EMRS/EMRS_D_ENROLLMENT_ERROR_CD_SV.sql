SELECT NULL enrollment_error_code_id
      ,ee.value enrollment_error_code
       ,ee.description enrollment_error_description
       ,warning_ind
       ,denial_reason_ind
       ,needs_image_ind
       ,NULL source_record_id
       ,do_not_persist_ind
       ,recycle_ind
       ,denied_letter_ind
       ,on_denial_create_task_ind  
      ,correct_for_plan_svc_types
       ,pt.value managed_care_program
       ,manual_edit_ind
FROM enum_enrollment_error_code ee, enum_program_type pt
WHERE pt.effective_end_date IS NULL 