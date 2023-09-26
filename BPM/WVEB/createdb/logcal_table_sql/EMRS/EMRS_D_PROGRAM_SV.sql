SELECT NULL source_record_id
       ,NULL program_id
       ,value program_code       
       ,description program_name
       ,CASE WHEN effective_end_date IS NULL THEN 'A' ELSE 'I' END active_inactive
       ,effective_end_date end_date
       ,NULL program_category
       ,value managed_care_program
       ,effective_start_date start_date
FROM enum_program_type  