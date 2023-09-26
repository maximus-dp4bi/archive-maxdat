SELECT NULL language_code_id
        ,pt.value managed_care_program
        ,l.value language_code
        ,NULL source_record_id
        ,l.effective_start_date business_start_date
        ,l.effective_end_date business_end_date
        ,l.description language
 FROM enum_language l, enum_program_type pta
 WHERE pt.effective_end_date IS NULL 