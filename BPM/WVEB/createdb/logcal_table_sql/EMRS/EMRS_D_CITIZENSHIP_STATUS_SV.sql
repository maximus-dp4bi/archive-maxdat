SELECT  pt.value managed_care_program
	,e.description  citizenship_description
  ,NULL source_record_id
  ,NULL citizenship_id
  ,e.value citizenship_code               
FROM enum_citizen e, enum_program_type pt
WHERE pt.effective_end_date IS NULL 