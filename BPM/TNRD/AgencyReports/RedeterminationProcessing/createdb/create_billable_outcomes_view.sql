CREATE OR REPLACE VIEW D_BILLABLE_OUTCOMES_OLD_SV
AS

SELECT bill.*,
       COUNT(1) OVER (PARTITION BY application_id) bill_outcome_count
FROM(
SELECT ah.application_id
       ,i.app_individual_id
       ,(SELECT report_label FROM app_status_lkup s WHERE s.value = COALESCE(el.app_status_cd,'INPROCESS')) application_status
       ,COALESCE(el.program, pt.report_label) program
       ,COALESCE(el.program_subtype,st.report_label) determination       
       ,(SELECT report_label FROM elig_outcome_lkup e WHERE e.value = COALESCE(el.outcome_cd,'PENDING')) outcome
       ,el.outcome_reason
       ,TRUNC(el.outcome_date) outcome_date
       ,i.client_cin recipient_id
       ,cl.case_cin state_case_id
       ,null mi_type
       ,null denial_reason
       ,(SELECT report_label from app_rfe_status_lkup fe WHERE fe.value = ts.rfe_status_cd) hh_member_status
       ,staff_name
       ,staff_type
       ,(SELECT MIN(letter_mailed_date)
         FROM letters_stg lr
         WHERE lr.letter_type_cd IN('TN 401','TN 401a')
          AND lr.letter_status_cd = 'MAIL'
          AND letter_case_id = cl.case_id) packet_mailed_date
       ,doc.received_date   
       ,0 trmdn_substantive
       ,0 trmdn_procedural      
       ,null denial_type
       ,null billable_date
       ,previous_reactivation_reason
       ,current_reactivation_reason    
       ,CASE WHEN TRUNC(doc.received_date) > TRUNC(ltr.response_due_date)+90 THEN 'Y' ELSE 'N' END rcvd_after_recon_period
FROM app_header_stg ah
  INNER JOIN app_case_link_stg cl
    ON ah.application_id = cl.application_id
  INNER JOIN app_individual_stg i
    ON ah.application_id = i.application_id
  INNER JOIN app_elig_outcome_stg o
    ON ah.application_id = o.application_id  
    AND i.app_individual_id = o.app_individual_id
  LEFT OUTER JOIN program_type_lkup pt
    ON o.program_cd = pt.value
  LEFT OUTER JOIN subprogram_type_lkup st
    ON o.program_subtype_cd = st.value   
  LEFT OUTER JOIN elig_outcome_reason_lkup er
    ON o.elig_outcome_reason_cd = er.value      
  INNER JOIN (SELECT DISTINCT el.application_id, el.app_individual_id,
                   TRUNC(el.create_ts) outcome_date, outcome_cd, er.report_label outcome_reason, pt.report_label program, 
                     app_status_cd,st.report_label program_subtype                   
                    ,COUNT(1) OVER (PARTITION BY el.application_id ) cnt_rec
                    ,COALESCE(s.first_name||' '||REPLACE(s.last_name,' S',''),el.created_by) staff_name, s.staff_type_cd staff_type
                    ,previous_reactivation_reason
                    ,current_reactivation_reason
                 FROM app_event_log_stg el
                   LEFT OUTER JOIN elig_outcome_reason_lkup er
                     ON el.outcome_reason_cd = er.value 
                   LEFT OUTER JOIN program_type_lkup pt
                     ON el.program_cd = pt.value  
                   LEFT OUTER JOIN subprogram_type_lkup st
                     ON el.program_subtype_cd = st.value   
                   LEFT OUTER JOIN d_staff s
                     ON el.created_by = TO_CHAR(s.staff_id) 
                   LEFT JOIN (SELECT *
                           FROM(SELECT ae.application_id, ae.app_event_log_id,rfe_status_cd      
                                       ,LAG(app_event_context, 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS previous_reactivation_reason      
                                       ,LEAD(app_event_context, 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS current_reactivation_reason      
                                 FROM app_event_log_stg ae                          
                                 WHERE ( (app_event_cd ='APP_REACTIVATED' AND action_cd ='APP_REACTIVATED')
                                        OR rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' ) )
                           WHERE rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE')  rr  
                       ON  rr.application_id = el.application_id
                       AND rr.app_event_log_id = el.app_event_log_id  
                 WHERE  el.rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' ) el
    ON el.application_id = ah.application_id  
   LEFT OUTER JOIN (SELECT *
                     FROM app_tracker_stg ts
                     WHERE app_tracker_id = (SELECT MAX(app_tracker_id) 
                                             FROM app_tracker_stg s
                                             WHERE ts.application_id = s.application_id
                                             AND ts.app_individual_id = s.app_individual_id)) ts
    ON ah.application_id = ts.application_id
    AND i.app_individual_id = ts.app_individual_id 
 LEFT OUTER JOIN (SELECT dl.link_ref_id application_id,MIN(received_date) received_date
                   FROM document_stg d
                     INNER JOIN document_set_stg s
                       ON d.document_set_id = s.document_set_id
                     INNER JOIN doc_link_stg dl
                       ON d.document_id = dl.document_id
                   WHERE doc_type_cd = 'APPLICATION'
                   AND link_type_cd = 'APPLICATION'                  
                   GROUP BY dl.link_ref_id                   
                   ) doc                   
  ON ah.application_id = doc.application_id                   
 LEFT OUTER JOIN (SELECT *
                  FROM (
                   SELECT letter_id,letter_case_id, letter_mailed_date,response_due_date, reference_id,letter_type_cd,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn            
                   FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
                   WHERE lr.letter_type_cd IN('TN 411', 'TN 408ftp','TN 408') 
                   AND lr.letter_status_cd = 'MAIL'
                   AND lr.letter_request_type IN('L','S'))                   
                  WHERE rn = 1 ) ltr     
   ON ah.application_id = ltr.reference_id   
WHERE  ah.application_id >=320
UNION ALL
SELECT ah.application_id
       ,i.app_individual_id
       ,(SELECT report_label FROM app_status_lkup s WHERE s.value = el.app_status_cd) application_status
       ,COALESCE(el.program,pt.report_label) program
       ,COALESCE(el.program_subtype,st.report_label) determination        
       ,(SELECT report_label FROM elig_outcome_lkup e WHERE e.value = outcome_cd) outcome
       ,COALESCE(el.outcome_reason,er.report_label) outcome_reason
       ,TRUNC(el.outcome_date) outcome_date
       ,i.client_cin recipient_id
       ,cl.case_cin state_case_id
       ,null mi_type
       ,CASE WHEN outcome_cd = 'REJECTED' THEN denial_reason ELSE NULL END denial_reason
       ,(SELECT report_label from app_rfe_status_lkup fe WHERE fe.value = ts.rfe_status_cd) hh_member_status
       ,staff_name
       ,staff_type
       ,(SELECT MIN(letter_mailed_date)
         FROM letters_stg lr
         WHERE lr.letter_type_cd IN('TN 401','TN 401a')
          AND lr.letter_status_cd = 'MAIL'
          AND letter_case_id = cl.case_id) packet_mailed_date
       ,doc.received_date       
       ,CASE WHEN outcome_cd = 'REJECTED' THEN trmdn_substantive ELSE 0 END trmdn_substantive
       ,CASE WHEN outcome_cd = 'REJECTED' THEN trmdn_procedural  ELSE 0 END trmdn_procedural
       ,CASE WHEN  outcome_cd = 'REJECTED' THEN denial_type ELSE null END denial_type
       ,TRUNC(el.process_ts) billable_date
       ,previous_reactivation_reason
       ,current_reactivation_reason
       ,CASE WHEN TRUNC(doc.received_date) > TRUNC(el.response_due_date)+90 THEN 'Y' ELSE 'N' END rcvd_after_recon_period
FROM app_header_stg ah
  INNER JOIN app_case_link_stg cl
    ON ah.application_id = cl.application_id
  INNER JOIN app_individual_stg i
    ON ah.application_id = i.application_id
  INNER JOIN app_elig_outcome_stg o
    ON ah.application_id = o.application_id  
    AND i.app_individual_id = o.app_individual_id
  LEFT OUTER JOIN subprogram_type_lkup st
    ON o.program_subtype_cd = st.value  
  LEFT OUTER JOIN elig_outcome_reason_lkup er
     ON o.elig_outcome_reason_cd = er.value 
  LEFT OUTER JOIN program_type_lkup pt
     ON o.program_cd = pt.value      
 INNER JOIN (SELECT aelog.*, es.process_ts,es.mmis_app_status
                    ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 1 ELSE 0 END trmdn_substantive
                    ,CASE WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 1 ELSE 0 END trmdn_procedural
                    ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 'Substantive'
                          WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 'Procedural'
                     ELSE null END denial_type
                    ,rr.previous_reactivation_reason,rr.current_reactivation_reason
                    ,lr.response_due_date
              FROM
                (SELECT el.app_event_log_id,el.application_id, el.app_individual_id,el.create_ts outcome_date, outcome_cd, er.report_label outcome_reason, 
                    pt.report_label program, app_status_cd, st.report_label program_subtype,
                    COALESCE(s.first_name||' '||REPLACE(s.last_name,' S',''),el.created_by) staff_name, s.staff_type_cd staff_type,
                    (SELECT MAX(ref_id)
                     FROM app_event_log_stg ls
                     WHERE ls.application_id = el.application_id
                     AND ls.app_event_cd = 'LETTER_REQ'
                     AND ls.ref_type = 'LETTER_REQUEST'
                     AND ls.app_event_context IN('TN 408','TN 408ftp','TN 409','TN 409ftp', 'TN 411') 
                     AND ls.outcome_cd = 'REJECTED' 
                     AND TRUNC(ls.create_ts) = TRUNC(el.create_ts)) rej_letter_req_id
                 FROM app_event_log_stg el
                   LEFT OUTER JOIN elig_outcome_reason_lkup er
                     ON el.outcome_reason_cd = er.value 
                   LEFT OUTER JOIN program_type_lkup pt
                     ON el.program_cd = pt.value    
                   LEFT OUTER JOIN subprogram_type_lkup st
                    ON el.program_subtype_cd = st.value   
                   LEFT OUTER JOIN d_staff s
                     ON el.created_by = TO_CHAR(s.staff_id)
                 WHERE app_event_cd = 'STATUS_CHANGE'
                 AND action_cd = 'END_APPLICATION_TRACKING'  
                 AND outcome_cd IN('REJECTED','APPROVED')
                 AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                                 AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) )) aelog
                LEFT JOIN etl_e_app_status_staging_stg es                                                          
                  ON aelog.application_id = es.application_id
                  AND aelog.rej_letter_req_id = es.letter_req_id                   
                  --AND TRUNC(es.process_ts) >= TRUNC(aelog.outcome_date) 
                  AND mmis_app_status IN('TRMDN','NR')      
                LEFT JOIN letters_stg lr ON es.letter_req_id = lr.letter_id  
                LEFT JOIN (SELECT *
                           FROM(SELECT ae.application_id, ae.app_event_log_id,action_cd      
                                       ,LAG(DECODE(app_event_context,'APPLICATION_TRACKING',null,app_event_context), 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS previous_reactivation_reason      
                                       ,LEAD(DECODE(app_event_context,'APPLICATION_TRACKING',null,app_event_context), 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS current_reactivation_reason      
                                 FROM app_event_log_stg ae                          
                                 WHERE app_event_cd IN('APP_REACTIVATED','STATUS_CHANGE') 
                                 AND action_cd IN('APP_REACTIVATED','END_APPLICATION_TRACKING'))
                           WHERE action_cd = 'END_APPLICATION_TRACKING')  rr
                    ON rr.application_id = aelog.application_id
                    AND rr.app_event_log_id = aelog.app_event_log_id                    
                  ) el
    ON el.application_id = ah.application_id
    --AND el.rnes = 1   
   LEFT OUTER JOIN (SELECT *
                     FROM app_tracker_stg ts
                     WHERE app_tracker_id = (SELECT MAX(app_tracker_id) 
                                             FROM app_tracker_stg s
                                             WHERE ts.application_id = s.application_id
                                             AND ts.app_individual_id = s.app_individual_id)) ts
    ON ah.application_id = ts.application_id
    AND i.app_individual_id = ts.app_individual_id     
  LEFT OUTER JOIN (SELECT case_id,client_id,LISTAGG(denial_reason,', ') WITHIN GROUP (ORDER BY case_id) denial_reason
                   FROM(SELECT ce.case_id,ce.client_id,ma.report_label denial_reason
                        FROM case_event_stg ce
                          INNER JOIN case_manual_action_lkup ma
                            ON ce.context =  ma.value
                        WHERE ce.event_type_cd = 'CASE_MANUAL_ACTION'
                        AND ce.event_id = (SELECT MAX(event_id)
                                           FROM case_event_stg ce1
                                           WHERE ce1.case_id = ce.case_id
                                           AND ce1.client_id = ce.client_id
                                           AND ce1.event_type_cd = ce.event_type_cd
                                           AND ce1.context = ce.context) )                     
                   GROUP BY case_id, client_id  ) dr
     ON cl.case_id = dr.case_id
     AND i.client_id = dr.client_id
 LEFT OUTER JOIN (SELECT dl.link_ref_id application_id,MIN(received_date) received_date
                   FROM document_stg d
                     INNER JOIN document_set_stg s
                       ON d.document_set_id = s.document_set_id
                     INNER JOIN doc_link_stg dl
                       ON d.document_id = dl.document_id
                   WHERE doc_type_cd = 'APPLICATION'
                   AND link_type_cd = 'APPLICATION'                  
                   GROUP BY dl.link_ref_id                   
                   ) doc
  ON ah.application_id = doc.application_id     
WHERE  ah.application_id >=320  
--AND outcome_cd = 'APPROVED' OR (outcome_cd = 'REJECTED' AND denial_type IS NOT NULL)
     ) bill
;

GRANT SELECT ON D_BILLABLE_OUTCOMES_OLD_SV to MAXDAT_READ_ONLY;


