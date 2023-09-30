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
       ,CASE WHEN ae.elig_outcome_cd IS NOT NULL THEN letter_status ELSE NULL END notice_status
       ,completed_ts task_completion_date
       ,task_name
       ,step_instance_id task_id
       ,ae.program_subtype_cd new_aid_category     
       ,COALESCE(mmis.mmis_app_status, m.status_code) mmis_app_status
       ,COALESCE(mmis.approval_date,m.approval_date) approval_date
       ,ai.client_id
       ,ae.program_cd
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
  LEFT OUTER JOIN (SELECT reference_id application_id,letter_type,letter_create_ts,letter_status
                   FROM letters_stg ls
                     INNER JOIN letter_request_link_stg lr
                       ON ls.letter_id = lr.lmreq_id
                   WHERE letter_status != 'Voided'
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
  
GRANT SELECT ON D_APPLICATION_OUTCOMES_SV to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_APPLICATION_MISSING_INFO_SV
AS
SELECT *
FROM (
SELECT ah.application_id
       ,ai.client_cin recipient_id
       ,st.report_label application_status
       ,CASE WHEN EXISTS(SELECT 1 FROM app_missing_info_stg am WHERE am.application_id = ah.application_id AND am.app_individual_id IS NULL AND am.satisfied_date IS NULL) THEN 'Has MI' ELSE 'No MI' END application_mi
       ,CASE WHEN EXISTS(SELECT 1 FROM app_missing_info_stg am WHERE am.application_id = ah.application_id AND am.app_individual_id IS NOT NULL AND am.satisfied_date IS NULL) THEN 'Has MI' ELSE 'No MI' END recipient_mi       
       ,(SELECT first_name||' '||last_name FROM d_staff s WHERE TO_CHAR(s.staff_id) = al.created_by) mi_created_by
       ,al.create_ts mi_create_ts
       ,al.report_label mi_event      
       ,mi.mi_type       
FROM app_header_stg ah
  INNER JOIN app_individual_stg ai
    ON ah.application_id = ai.application_id
  INNER JOIN app_status_lkup st
    ON ah.status_cd = st.value  
  LEFT OUTER JOIN (SELECT al.application_id, al.create_ts, et.report_label, al.created_by
                   FROM app_event_log_stg al
                   INNER JOIN app_event_type_lkup et
                      ON al.app_event_cd = et.value    
                   WHERE al.app_event_cd = 'APP_MI_ADDED'
                   AND al.create_ts = (SELECT MAX(create_ts)
                                       FROM app_event_log_stg al2
                                       WHERE al.application_id = al2.application_id
                                       AND al.app_event_cd = al2.app_event_cd)) al
    ON ah.application_id = al.application_id     
  LEFT OUTER JOIN (SELECT application_id,LISTAGG(mi_category||'-'||mi_type, ', ') WITHIN GROUP (ORDER BY application_id) mi_type
                   FROM (SELECT DISTINCT application_id, mi_type_cd,t.report_label mi_type, ic.report_label mi_category                            
                         FROM app_missing_info_stg i
                            INNER JOIN app_mi_type_lkup t
                              ON i.mi_type_cd = t.value 
                            INNER JOIN app_mi_category_lkup ic
                              ON t.mi_category = ic.value
                          WHERE i.satisfied_date IS NULL  )
                          GROUP BY application_id ) mi
    ON ah.application_id = mi.application_id      
--  WHERE ah.status_cd = 'INPROCESS' 
  )
WHERE application_mi = 'Has MI'
 OR recipient_mi = 'Has MI';

GRANT SELECT ON D_APPLICATION_MISSING_INFO_SV to MAXDAT_READ_ONLY;