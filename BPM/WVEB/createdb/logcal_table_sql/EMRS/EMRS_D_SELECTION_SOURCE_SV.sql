SELECT pt.value managed_care_program
	    ,e.value selection_source_code      
      ,DECODE(is_choice_ind,1,'Y','N') is_choice_ind        
      ,NULL source_record_id
      ,e.description  selection_source
      ,NULL selection_source_id
  FROM eb.enum_enrollment_trans_source e, eb.enum_program_type pt
  WHERE pt.effective_end_date IS NULL 