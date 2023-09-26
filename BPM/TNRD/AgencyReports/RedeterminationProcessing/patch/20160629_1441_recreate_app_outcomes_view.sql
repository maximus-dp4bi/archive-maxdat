CREATE OR REPLACE VIEW D_APPLICATION_OUTCOMES_SV
AS
SELECT ah.application_id
       ,ah.status_cd application_status
       ,client_cin recipient_id
       ,(SELECT first_name||' '||last_name FROM d_staff WHERE TO_CHAR(staff_id) = ae.updated_by) updated_by
       ,ae.update_ts last_update_date
       ,pt.report_label program_type      
       ,st.report_label determination       
       ,er.report_label outcome_reason
       ,o.report_label outcome
       ,CASE WHEN ae.elig_outcome_cd IS NOT NULL THEN letter_type ELSE NULL END notice_created
       ,CASE WHEN ae.elig_outcome_cd IS NOT NULL THEN letter_create_ts ELSE NULL END notice_create_date
       ,completed_ts task_completion_date
       ,task_name
       ,step_instance_id task_id
FROM app_header_stg ah
  INNER JOIN app_individual_stg ai
    ON ah.application_id = ai.application_id
  LEFT OUTER JOIN app_elig_outcome_stg ae
    ON ai.application_id = ae.application_id
    AND ai.app_individual_id = ae.app_individual_id  
  LEFT OUTER JOIN elig_outcome_lkup o
    ON ae.elig_outcome_cd = o.value
  LEFT OUTER JOIN elig_outcome_reason_lkup er
    ON ae.elig_outcome_reason_cd = er.value
  LEFT OUTER JOIN subprogram_type_lkup st
    ON ae.program_subtype_cd = st.value
  LEFT OUTER JOIN program_type_lkup pt
    ON ae.program_cd = pt.value  
  LEFT OUTER JOIN (SELECT reference_id application_id,letter_type,letter_create_ts
                   FROM letters_stg ls
                     INNER JOIN letter_request_link_stg lr
                       ON ls.letter_id = lr.lmreq_id
                   WHERE letter_status != 'Voided'
                   AND letter_type_cd NOT IN('TN 401','TN 401a', 'TN 401R','TN 401aR')
                   AND lr.reference_type = 'APP_HEADER' )ale
    ON ale.application_id = ah.application_id
    AND  ale.letter_create_ts >= ae.create_ts
  LEFT OUTER JOIN(SELECT ref_id, ref_type, completed_ts,  task_name, step_instance_id
                   FROM step_instance_stg s
                      INNER JOIN d_task_types t
                        ON s.step_definition_id = t.task_type_id
                   WHERE s.ref_type = 'APP_HEADER'
                   AND hist_status = 'COMPLETED'
		   AND completed_ts IS NOT NULL 
                   AND step_instance_id = (SELECT MAX(step_instance_id)
                                           FROM step_instance_stg s1
                                           WHERE s.ref_id = s1.ref_id
                                           AND s.ref_type = s1.ref_type)
                   AND step_instance_history_id = (SELECT MAX(step_instance_history_id)
                                                   FROM step_instance_stg s1
                                                   WHERE s1.step_instance_id = s.step_instance_id
                                                   AND s1.hist_status = 'COMPLETED'
                                                   AND s1.completed_ts IS NOT NULL
                                                   )) tt
     ON tt.ref_id = ah.application_id
  ;
  
GRANT SELECT ON D_APPLICATION_OUTCOMES_SV to MAXDAT_READ_ONLY;