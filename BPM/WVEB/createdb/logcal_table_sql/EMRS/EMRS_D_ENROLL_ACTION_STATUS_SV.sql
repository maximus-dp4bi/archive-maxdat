SELECT e.value enrollment_action_status_code
	 ,e.description  enrollment_action_status_code_
   ,pt.value managed_care_program
   ,NULL enrollment_action_status_id
   ,NULL source_record_id
  FROM enum_enrollment_trans_type e, enum_program_type pt
  WHERE pt.effective_end_date IS NULL