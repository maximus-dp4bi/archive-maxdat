SELECT pt.value managed_care_program 
       ,e.value selection_reason_code
	     ,e.description  selection_reason
       ,NULL source_record_id
       ,NULL selection_reason_id
  FROM enum_choice_reason e, enum_program_type pt
  WHERE pt.effective_end_date IS NULL