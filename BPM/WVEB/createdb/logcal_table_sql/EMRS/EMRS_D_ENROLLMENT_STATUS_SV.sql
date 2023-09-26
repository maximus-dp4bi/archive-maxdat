SELECT es.is_mandatory_unassign_ind
       ,pt.value managed_care_program
       ,NULL source_record_id
       ,es.is_aa_pce_ind
       ,es.value enrollment_status_code
       ,es.description enrollment_status_desc
       ,NULL enrollment_status_id
FROM enum_client_enroll_status es , enum_program_type pt
WHERE pt.effective_end_date IS NULL