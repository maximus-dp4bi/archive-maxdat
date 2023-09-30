SELECT pt.value managed_care_program
       ,NULL sub_program_id
       ,st.description sub_program_name
       ,st.value sub_program_code
       ,NULL source_record_id
       ,pt.value parent_program_name
       ,COALESCE(st.effective_start_date,st.create_ts) start_date
       ,st.effective_end_date end_date
       ,NULL parent_program_id
       ,st.value plan_service_type
     FROM enum_subprogram_type st, enum_program_type pt
     WHERE pt.effective_end_date IS NULL    