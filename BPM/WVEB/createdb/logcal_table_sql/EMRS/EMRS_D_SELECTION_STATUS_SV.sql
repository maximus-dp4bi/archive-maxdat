SELECT NULL selection_status_id
       ,ss.value selection_status_code
       ,ss.description selection_status_description
       ,ss.overwrite_ind
       ,NULL source_record_id
       ,ss.valid_selection_ind
       ,ss.allow_new_selection_ind
       ,pt.value managed_care_program
       ,ss.overwrite_to_value
  FROM enum_selection_status ss, enum_program_type pt
  WHERE pt.effective_end_date IS NULL