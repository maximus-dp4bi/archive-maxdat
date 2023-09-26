SELECT NULL plan_type_id
              ,NULL source_record_id 
              ,pt.value managed_care_program
              ,p.value plan_type
       FROM enum_plan_type p, enum_program_type pt
  WHERE pt.effective_end_date IS NULL 