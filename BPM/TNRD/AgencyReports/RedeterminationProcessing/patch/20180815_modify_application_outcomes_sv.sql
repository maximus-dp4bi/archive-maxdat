
CREATE OR REPLACE VIEW D_APPLICATION_OUTCOMES_SV
AS
SELECT ah.application_id
       ,ah.status_cd application_status
       ,client_cin recipient_id
       ,s.first_name||' '||s.last_name updated_by       
       ,ae.update_ts last_update_date
       ,pt.report_label program_type      
       ,st.report_label determination       
       ,er.report_label outcome_reason
       ,o.report_label outcome
       ,CASE WHEN ae.elig_outcome_cd IS NOT NULL THEN letter_type ELSE NULL END notice_created
       ,CASE WHEN ae.elig_outcome_cd IS NOT NULL THEN letter_create_ts ELSE NULL END notice_create_date
       ,CASE WHEN ae.elig_outcome_cd IS NOT NULL THEN letter_status ELSE NULL END notice_status
       ,completed_ts task_completion_date
       ,task_name
       ,step_instance_id task_id
       ,ae.program_subtype_cd new_aid_category     
       ,COALESCE(mmis.mmis_app_status, m.status_code) mmis_app_status
       ,COALESCE(mmis.approval_date,m.approval_date) approval_date
       ,ai.client_id
       ,ae.program_cd
       ,ae.elig_outcome_cd       
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
  LEFT JOIN d_staff s ON TO_CHAR(staff_id) = ae.updated_by    
  LEFT OUTER JOIN (SELECT reference_id application_id,letter_type,letter_create_ts,letter_status
                   FROM letters_stg ls
                     INNER JOIN letter_request_link_stg lr
                       ON ls.letter_id = lr.lmreq_id
                   WHERE letter_status_cd != 'VOID'
                   AND letter_type_cd NOT IN('TN 401','TN 401a', 'TN 401R','TN 401aR')
                   AND lr.reference_type = 'APP_HEADER' )ale
    ON ale.application_id = ah.application_id
    AND  ale.letter_create_ts >= ae.create_ts    
  LEFT JOIN (SELECT *
             FROM(SELECT ref_id application_id, i.step_instance_id, i.completed_ts,task_name
                    ,ROW_NUMBER() OVER (PARTITION BY ref_id ORDER BY step_instance_id,DECODE(hist_status,'COMPLETED',2,'TERMINATED',3,1) DESC,hist_create_ts DESC,step_instance_history_id DESC)  vrn
                  FROM step_instance_stg i                        
                    INNER JOIN d_task_types t  ON i.step_definition_id = t.task_type_id
                  WHERE ref_type = 'APP_HEADER'
                  AND hist_status = 'COMPLETED'
                  AND completed_ts IS NOT NULL) t
             WHERE vrn = 1) tt ON tt.application_id = ah.application_id   
  LEFT JOIN(SELECT application_id,process_ts approval_date, status_code
            FROM (SELECT application_id,process_ts,mmis_app_status status_code
                         ,ROW_NUMBER() OVER(PARTITION BY application_id ORDER BY etl_e_app_status_staging_id DESC) rn
                  FROM etl_e_app_status_staging_stg ss
                  WHERE process_ts IS NOT NULL)
            WHERE rn = 1 ) m ON m.application_id = ah.application_id             
  LEFT JOIN (SELECT ea.application_id,ea.create_ts approval_date,REGEXP_REPLACE(REPLACE(REPLACE(ea.app_event_cd,'CK',''),'MA',''), '[^0-9A-Za-z]', '') mmis_app_status
                FROM (SELECT ea.application_id, ea.create_ts,ea.app_event_cd,ROW_NUMBER() OVER (PARTITION BY ea.application_id ORDER BY app_event_log_id DESC) rn 
                      FROM app_event_log_stg ea              
                      WHERE app_event_cd IN('RFI_CK','PEND_CK','NR_CK','TRMDN_CK','APPR_CK','CK_APPR_MA','TRMDN','NR')) ea 
                WHERE rn = 1)  mmis ON mmis.application_id = ah.application_id;
                
CREATE INDEX STEP_INS_INDX5 ON step_instance_stg(hist_status) TABLESPACE MAXDAT_INDX;
CREATE INDEX STEP_INS_INDX6 ON step_instance_stg(completed_ts) TABLESPACE MAXDAT_INDX; 