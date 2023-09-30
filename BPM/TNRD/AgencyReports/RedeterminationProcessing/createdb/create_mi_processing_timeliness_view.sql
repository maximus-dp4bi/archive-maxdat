CREATE OR REPLACE VIEW d_mi_processing_timeliness_old_sv
AS
SELECT document_id
       ,application_id
       ,member_id
       ,app_receipt_date       
       ,reactivation_date
       ,app_scan_date
       ,application_status
       ,coverage_end_date
       ,eligibility_outcome
       ,term_date
       ,rcvd_during_90day_prd
       ,mi_link_date
       ,mi_receipt_date
       ,mi_scan_date
       ,TRUNC(fwd_create_ts) forward_task_to_state_dt
       ,TRUNC(mi_added_date) mi_determination_dt
       ,TRUNC(refer_to_hcfa_date) refer_to_hcfa_dt
       ,TRUNC(mi_cycle_stop) processed_dt
       ,TRUNC(mi_cycle_stop) cycle_time_stop_dt
       ,sla
       ,CASE WHEN COALESCE(mi_cycle_stop,TRUNC(SYSDATE)) - TRUNC(mi_link_date) < 0 THEN 0 ELSE COALESCE(mi_cycle_stop,TRUNC(SYSDATE)) - TRUNC(mi_link_date) END calendar_days_cycle_age 
       ,(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(mi_link_date) AND  COALESCE(mi_cycle_stop,TRUNC(SYSDATE))) business_days_cycle_age
       ,CASE WHEN mi_cycle_stop IS NULL THEN 'Not Processed' 
             WHEN CASE WHEN COALESCE(mi_cycle_stop,TRUNC(SYSDATE)) - TRUNC(mi_link_date) < 0 THEN 0 ELSE COALESCE(mi_cycle_stop,TRUNC(SYSDATE)) - TRUNC(mi_link_date) END <= sla THEN 'Timely' 
          ELSE 'Untimely' END calendar_day_timeliness 
       ,CASE WHEN mi_cycle_stop IS NULL THEN 'Not Processed' 
         ELSE CASE WHEN (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                         FROM D_DATES
                         WHERE business_day_flag = 'Y'
                         AND d_date BETWEEN TRUNC(mi_link_date) AND  COALESCE(mi_cycle_stop,TRUNC(SYSDATE))) <= sla THEN 'Timely' ELSE 'Untimely' END END business_day_timeliness       
       ,TRUNC(app_receipt_date,'MM') app_receipt_month
       ,TRUNC(mi_receipt_date,'MM') mi_receipt_month
       ,TRUNC(mi_cycle_stop,'MM') processed_month
       ,multi_applying_member_flag
       ,callback_date
       ,COALESCE(application_type,app_form_cd) application_type
       ,app_link_date
       ,cob_indicator
       ,hcfa_reactivation_flag    
       ,staff_completed_by
       ,de_task_create_date
       ,de_task_complete_date       
       ,TRUNC(billable_outcome_date) billable_outcome_date
       ,TRUNC(mi_link_date) cycle_start_date
       ,TRUNC(mi_link_date,'mm') cycle_start_month
       ,de_task_id
       ,de_task_status
       ,de_claimed_unclaimed
       ,de_current_owner
       ,CASE WHEN mi_cycle_stop IS NOT NULL THEN 'NA'
         ELSE CASE WHEN (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                   FROM D_DATES
                   WHERE business_day_flag = 'Y'
                   AND d_date BETWEEN TRUNC(mi_link_date) AND TRUNC(SYSDATE) ) < jeopardy_days THEN 'N' ELSE 'Y' END END jeopardy_status
       ,(SELECT MAX(letter_mailed_date)
         FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
         WHERE lr.letter_type_cd LIKE 'TN 406%' AND lr.letter_status_cd = 'MAIL' AND lr.letter_request_type = 'L' 
         AND ll.reference_id = application_id) last_mi_mailed_date
       ,(SELECT DISTINCT FIRST_VALUE (COALESCE(tl.report_label,d.doc_type_cd) ) OVER (ORDER BY ds.received_date DESC)
         FROM document_set_stg ds 
           INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
           LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
           LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'                         
         WHERE dl.link_ref_id = application_id
         AND TRUNC(ds.received_date) <= COALESCE(TRUNC(mi_cycle_stop),TRUNC(sysdate))) recent_doc_type    
       ,de_task_type  
       ,document_type
       ,document_form_type
FROM (          
SELECT dl.document_id
       ,dl.link_ref_id application_id
       ,dss.received_date mi_receipt_date
       ,ds.scan_date mi_scan_date
       ,TRUNC(ah.reactivation_ts) reactivation_date
       ,COALESCE(dat.received_date,doc_rcvd.received_date) app_receipt_date
       ,COALESCE(dat.scan_date,doc_rcvd.scan_date) app_scan_date
       ,ast.report_label application_status
       ,apt.report_label application_type
       ,ai.client_cin member_id
       ,renewal_due_date coverage_end_date       
       ,(SELECT report_label FROM elig_outcome_lkup eeo WHERE eeo.value = aeo.elig_outcome_cd) eligibility_outcome
       ,app_form_cd       
       ,dat.term_date       
       ,dl.create_ts mi_link_date
       ,3 sla
       ,CASE WHEN receipt_date > term_date AND receipt_date <= term_date+90 THEN 'Y' ELSE 'N' END rcvd_during_90day_prd
       ,CASE WHEN EXISTS (SELECT 1 FROM document_stg d INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id  
                            WHERE doc_type_cd = 'UPLOAD' AND doc_form_type = 'MULT_RESCAN' AND link_type_cd = 'APPLICATION' AND link_ref_id = ah.application_id)
          THEN 'Y' ELSE 'N' END multi_applying_member_flag   
       ,COALESCE(dat.link_date,doc_rcvd.link_date) app_link_date   
       ,CASE WHEN ah.ref_value_1 = 1 THEN 'Yes' ELSE 'No' END cob_indicator        
       ,fwd_task_id
       ,fwd_create_ts
       ,staff_fwd_by
       ,fwdby_staff_type       
       ,staff_fwd_to
       ,fwdto_staff_type
       ,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END billable_outcome_date        
       ,CASE WHEN rf_outcome_cd = 'PENDING' THEN rf_outcome_date ELSE NULL END refer_to_hcfa_date 
       ,txc.callback_date
       ,ttx.new_cycle_start_date
       ,ttx.new_cycle_end_date
       ,ttx.hcfa_reactivation_flag
       ,ttx.exception_type
       ,mi.mi_added_date
       ,detask.de_task_create_date
       ,detask.de_task_complete_date   
       ,COALESCE(rf_staff_completed_by,bo_staff_completed_by) staff_completed_by  
       ,TRUNC(CASE WHEN ttx.exception_type IN('Processing Error','Other') AND ttx.new_cycle_end_date IS NOT NULL THEN TRUNC(ttx.new_cycle_end_date)
          ELSE LEAST(COALESCE(CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,mi.mi_added_date,callback_date,detask.detask_cycle_stop_date),
                 COALESCE(fwd_create_ts,mi.mi_added_date,callback_date,detask.detask_cycle_stop_date, CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END ),
                 COALESCE(mi.mi_added_date,callback_date,detask.detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts),
                 COALESCE(callback_date,detask.detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,mi.mi_added_date) ,
                 COALESCE(detask.detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,mi.mi_added_date, callback_date )) END)  mi_cycle_stop         
       ,de_task_id
       ,de_task_status
       ,CASE WHEN de_task_status = 'CLAIMED' THEN de_current_owner ELSE NULL END de_current_owner
       ,CASE WHEN de_task_status = 'CLAIMED' THEN 'Claimed'
             WHEN de_task_status = 'UNCLAIMED' THEN 'Unclaimed'
        ELSE NULL END de_claimed_unclaimed
       ,2 jeopardy_days 
       ,de_task_type
       ,COALESCE(dtl.report_label,ds.doc_type_cd) document_type
       ,ds.doc_form_type document_form_type
FROM doc_link_stg dl
  JOIN document_stg ds ON dl.document_id = ds.document_id
  LEFT JOIN document_set_stg dss ON ds.document_set_id = dss.document_set_id
  LEFT JOIN document_type_lkup dtl ON ds.doc_type_cd = dtl.value
  JOIN app_header_stg ah ON dl.link_ref_id = ah.application_id
  JOIN app_individual_stg ai ON ah.application_id = ai.application_id AND applicant_ind = 1
  LEFT JOIN app_elig_outcome_stg aeo ON ai.app_individual_id = aeo.app_individual_id AND ai.application_id = aeo.application_id
  LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
  LEFT JOIN app_type_lkup apt ON ah.app_form_cd = apt.value  
  LEFT JOIN(SELECT reference_id,term_date,received_date,scan_date,link_date
            FROM (
                SELECT trm.*, dat.*,ROW_NUMBER() OVER (PARTITION BY reference_id ORDER BY received_date,doc_link_id) drn
                FROM (SELECT *
                      FROM (SELECT letter_mailed_date,response_due_date term_date, reference_id,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn            
                            FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
                            WHERE lr.letter_type_cd IN ('TN 411', 'TN 408', 'TN 408ftp', 'TN 409', 'TN 409ftp') 
                            AND lr.letter_status_cd = 'MAIL')
                      WHERE rn = 1 ) trm 
             LEFT JOIN (SELECT link_ref_id,ds.received_date,d.scan_date,doc_link_id,dl.create_ts link_date
                        FROM document_set_stg ds 
                         INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id
                        WHERE doc_type_cd = 'APPLICATION' 
                        AND link_type_cd = 'APPLICATION') dat
               ON trm.reference_id = dat.link_ref_id
               AND dat.received_date >= trm.letter_mailed_date )
            WHERE drn = 1   ) dat
    ON dat.reference_id = ah.application_id                
  LEFT JOIN(SELECT *
            FROM(SELECT link_ref_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY received_date) rn
                 FROM document_set_stg ds 
                   INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
                   INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id
                 WHERE doc_type_cd = 'APPLICATION' 
                 AND link_type_cd = 'APPLICATION')
             WHERE rn = 1) doc_rcvd
      ON doc_rcvd.link_ref_id = ah.application_id 
  LEFT JOIN (SELECT ref_id application_id, i.step_instance_id fwd_task_id, i.hist_create_ts fwd_create_ts, sfwd.first_name||' '||sfwd.last_name staff_fwd_by, sfwdto.first_name||' '||sfwdto.last_name staff_fwd_to, step_instance_history_id
                             ,sfwd.staff_type_cd fwdby_staff_type, sfwdto.staff_type_cd fwdto_staff_type,dl.document_id
                             ,ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY step_instance_id,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC) trn
             FROM doc_link_stg dl
               JOIN step_instance_stg i ON dl.link_ref_id = i.ref_id                                                
               LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
               LEFT JOIN d_staff sfwd   ON i.forwarded_by = TO_CHAR(sfwd.staff_id)
               LEFT JOIN d_staff sfwdto  ON i.owner = TO_CHAR(sfwdto.staff_id)                        
             WHERE dl.mi_task_indicator = 1
             AND dl.link_type_cd = 'APPLICATION'
             AND i.ref_type = 'APP_HEADER'   
             AND i.hist_create_ts >= dl.create_ts
             AND ((sfwd.staff_type_cd = 'PROJECT_STAFF' AND sfwdto.staff_type_cd = 'STATE') 
                  OR d.business_unit_name = 'HCFA Verifications') ) taskinfo
    ON taskinfo.document_id = dl.document_id    
    AND trn = 1
  LEFT JOIN (SELECT ref_id application_id, i.step_instance_id de_task_id, i.create_ts de_task_create_date, i.completed_ts de_task_complete_date
                    ,CASE WHEN hist_status = 'CLAIMED' AND co.staff_type_cd = 'STATE' THEN i.hist_create_ts ELSE i.completed_ts END detask_cycle_stop_date                    
                    ,step_instance_history_id,dl.document_id
                    ,task_name,hist_status de_task_status
                    ,co.first_name||' '||co.last_name de_current_owner
                    ,dt.task_name de_task_type
                    ,ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY step_instance_id,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC,step_instance_history_id) vrn
             FROM doc_link_stg dl
              JOIN step_instance_stg i ON dl.link_ref_id = i.ref_id 
              JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
              LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
             WHERE dl.mi_task_indicator = 1
             AND dl.link_type_cd = 'APPLICATION'
             AND ref_type = 'APP_HEADER'
             AND i.hist_create_ts >= dl.create_ts
             AND task_name IN('Data Evaluation','MI Data Evaluation')  ) detask
    ON detask.document_id = dl.document_id    
    AND vrn = 1        
  LEFT JOIN (SELECT el.application_id, el.app_individual_id,TRUNC(el.create_ts) billable_outcome_date, outcome_cd bo_outcome_cd
                       ,ds.first_name||' '||ds.last_name bo_staff_completed_by,dl.document_id
                       ,ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY el.application_id,el.create_ts) brn
                FROM doc_link_stg dl
                  JOIN app_event_log_stg el  ON dl.link_ref_id = el.application_id
                  LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
                WHERE dl.mi_task_indicator = 1
                AND dl.link_type_cd = 'APPLICATION'
                AND app_event_cd = 'STATUS_CHANGE'
                AND action_cd = 'END_APPLICATION_TRACKING'  
                AND outcome_cd IN('REJECTED','APPROVED')                
                AND el.create_ts >= dl.create_ts
                AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                                AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) ) )      bo
     ON bo.document_id = dl.document_id     
     AND brn = 1
  LEFT JOIN (SELECT el.application_id, el.app_individual_id, TRUNC(el.create_ts) rf_outcome_date, outcome_cd rf_outcome_cd                         
                               ,ds.first_name||' '||ds.last_name rf_staff_completed_by,dl.document_id
                                ,ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY el.application_id,el.create_ts) rrn
                  FROM doc_link_stg dl 
                    JOIN app_event_log_stg el  ON dl.link_ref_id = el.application_id
                    LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id) 
                  WHERE dl.mi_task_indicator = 1
                  AND dl.link_type_cd = 'APPLICATION'
                  AND el.rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' 
                  AND el.create_ts >= dl.create_ts ) rf
   ON rf.document_id = dl.document_id    
   AND rrn = 1
   LEFT JOIN (SELECT mi.application_id, mi.create_ts mi_added_date,dl.document_id,
                     ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY mi.application_id,mi.create_ts) mrn
                  FROM doc_link_stg dl
                  JOIN app_missing_info_stg mi ON dl.link_ref_id = mi.application_id
                  WHERE dl.mi_task_indicator = 1
                  AND dl.link_type_cd = 'APPLICATION'
                  AND mi.create_ts >= dl.create_ts
                  AND mi.satisfied_date IS NULL ) mi
   ON mi.document_id = dl.document_id    
   AND mrn = 1   
  LEFT OUTER JOIN (SELECT ttx.app_id,txl.exception_type,ttx.hcfa_reactivation_flag,ttx.new_cycle_start_date,ttx.new_cycle_end_date,exclusion_flag,ttx.create_datetime,
                          dl.document_id,ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY ttx.create_datetime) ttxrn
                   FROM doc_link_stg dl
                     JOIN ts_timeliness_exception ttx  ON dl.link_ref_id = ttx.app_id
                     JOIN ts_exception_type_lkup txl ON ttx.exception_type_id = txl.exception_type_id                  
                   WHERE dl.mi_task_indicator = 1
                   AND dl.link_type_cd = 'APPLICATION'
                   AND txl.exception_type NOT IN('Callback','Letter Exception') 
                   AND ttx.ignore_flag = 'N'
                   AND ttx.create_datetime >= dl.create_ts) ttx  
    ON ttx.document_id = dl.document_id    
    AND ttx.ttxrn = 1
  LEFT JOIN (SELECT txc.app_id, txc.callback_date,txc.exclusion_flag,dl.document_id,ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY txc.callback_date) txcrn
             FROM doc_link_stg dl
                 JOIN ts_timeliness_exception txc ON dl.link_ref_id = txc.app_id 
                 JOIN ts_exception_type_lkup  tl ON txc.exception_type_id = tl.exception_type_id 
              WHERE dl.mi_task_indicator = 1
              AND dl.link_type_cd = 'APPLICATION'
              AND tl.exception_type = 'Callback'
              AND txc.ignore_flag = 'N'
              AND txc.callback_date >= dl.create_ts) txc
    ON txc.document_id = dl.document_id    
    AND txc.txcrn = 1
  LEFT JOIN (SELECT lxc.app_id,lxc.exclusion_flag, lxc.create_datetime,dl.document_id, ROW_NUMBER() OVER (PARTITION BY dl.document_id ORDER BY lxc.create_datetime) lxcrn
             FROM doc_link_stg dl
                JOIN ts_timeliness_exception lxc  ON dl.link_ref_id = lxc.app_id 
                JOIN ts_exception_type_lkup  ll ON lxc.exception_type_id = ll.exception_type_id 
              WHERE dl.mi_task_indicator = 1
              AND dl.link_type_cd = 'APPLICATION'
              AND ll.exception_type = 'Letter Exception'
              AND lxc.ignore_flag = 'N'
              AND lxc.create_datetime >= dl.create_ts) lxc
    ON lxc.document_id = dl.document_id    
    AND lxc.lxcrn = 1
WHERE link_type_cd = 'APPLICATION'
AND mi_task_indicator = 1
AND COALESCE(lxc.exclusion_flag,ttx.exclusion_flag,txc.exclusion_flag,'N') = 'N' 
AND TRUNC(de_task_create_date) =  TRUNC(dl.create_ts) --IS NOT NULL
);


GRANT SELECT ON D_MI_PROCESSING_TIMELINESS_OLD_SV to MAXDAT_READ_ONLY;