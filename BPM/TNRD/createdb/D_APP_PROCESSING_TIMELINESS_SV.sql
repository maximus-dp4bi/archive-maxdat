--------------------------------------------------------
--  File created - Friday-April-06-2018   
--------------------------------------------------------
CREATE VIEW MAXDAT.D_APP_PROCESSING_TIMELINESS_SV
AS SELECT application_id
       ,member_id
       ,receipt_date
       ,trunc(reactivation_ts) as reactivation_date
       ,scan_date scan_dt
       ,application_status
       ,coverage_end_date
       ,eligibility_outcome
       ,term_date
       ,CASE WHEN receipt_date > term_date AND receipt_date <= term_date+90 THEN 'Y' ELSE 'N' END rcvd_during_90day_prd
       ,TRUNC(fwd_create_ts) forward_task_to_state_dt
       ,TRUNC(mi_date) mi_determination_dt
       ,TRUNC(refer_to_hcfa_date) refer_to_hcfa_dt
       ,TRUNC(cycle_stop) processed_dt
       ,TRUNC(cycle_stop) cycle_time_stop_dt
       ,sla
       ,CASE WHEN COALESCE(cycle_stop,TRUNC(SYSDATE)) - cycle_start < 0 THEN 0 ELSE COALESCE(cycle_stop,TRUNC(SYSDATE)) - cycle_start END calendar_days_cycle_age 
       ,CASE WHEN business_days_cycle_age < 0 THEN 0 ELSE  business_days_cycle_age END business_days_cycle_age           
       ,CASE WHEN cycle_stop IS NULL THEN 'Not Processed'
             WHEN CASE WHEN COALESCE(cycle_stop,TRUNC(SYSDATE)) - cycle_start < 0 THEN 0 ELSE COALESCE(cycle_stop,TRUNC(SYSDATE)) - cycle_start END <= sla THEN 'Timely' 
          ELSE 'Untimely' END calendar_day_timeliness
       ,CASE WHEN cycle_stop IS NULL THEN 'Not Processed'
              WHEN business_days_cycle_age <= sla THEN 'Timely' 
          ELSE 'Untimely' END business_day_timeliness          
       ,TRUNC(receipt_date,'MM') receipt_month
       ,TRUNC(cycle_stop,'MM') processed_month
       ,multi_applying_member_flag
       ,callback_date
       ,COALESCE(application_type,app_form_cd) application_type
       ,link_date
       ,cob_indicator
       ,hcfa_reactivation_flag    
       ,staff_completed_by
       ,de_task_create_date
       ,TRUNC(billable_outcome_date) billable_outcome_date
       ,TRUNC(cycle_start) cycle_start_date
       ,TRUNC(cycle_start,'mm') cycle_start_month
       ,CASE WHEN (cycle_stop IS NOT NULL or application_status = 'Timeout') THEN 'NA'             
         ELSE CASE WHEN business_days_cycle_age >= jeopardy_days THEN 'Y' ELSE 'N' END END app_jeopardy_status
       ,TRUNC(term_date+90) recon_period_end_date
       ,(SELECT MAX(letter_mailed_date)
         FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
         WHERE lr.letter_type_cd = 'TN 411' AND lr.letter_status_cd = 'MAIL' AND lr.letter_request_type = 'L' 
         AND ll.reference_id = application_id) TN411_mailed_date
       ,(SELECT MAX(letter_mailed_date)
         FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
         WHERE lr.letter_type_cd IN('TN 408ftp','TN 409ftp') AND lr.letter_status_cd = 'MAIL' AND lr.letter_request_type = 'L' 
         AND ll.reference_id = application_id) ftp_mailed_date
       ,(SELECT DISTINCT FIRST_VALUE (COALESCE(tl.report_label,d.doc_type_cd) ) OVER (ORDER BY ds.received_date DESC)
         FROM document_set_stg ds 
           INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
           LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
           LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'                         
         WHERE dl.link_ref_id = application_id
         AND TRUNC(ds.received_date) <= COALESCE(TRUNC(cycle_stop),TRUNC(sysdate))) recent_doc_type
        ,open_task_name
        ,open_task_bu_name
        ,open_task_status
        ,open_task_owner_name
        ,open_task_owner_type       
        ,document_form_type
        ,document_type
,TRUNC(pst_cycle_start) pst_cycle_start_date
        ,TRUNC(pst_cycle_start,'mm') pst_cycle_start_month        
        ,CASE WHEN pst_cycle_stop IS NULL THEN 'Not Processed'
              WHEN pst_business_days_cycle_age <= sla THEN 'Timely' 
          ELSE 'Untimely' END pst_business_day_timeliness   
        ,CASE WHEN pst_business_days_cycle_age < 0 THEN 0 ELSE  pst_business_days_cycle_age END pst_business_days_cycle_age           
        ,TRUNC(pst_cycle_stop) pst_processed_dt
        ,TRUNC(pst_cycle_stop) pst_cycle_time_stop_dt         
        ,CASE WHEN (pst_cycle_stop IS NOT NULL or application_status = 'Timeout') THEN 'NA'             
         ELSE CASE WHEN pst_business_days_cycle_age >= jeopardy_days THEN 'Y' ELSE 'N' END END pst_app_jeopardy_status
FROM (
SELECT ah.application_id      
       ,ah.reactivation_ts
       ,doc_rcvd.received_date receipt_date
       ,doc_rcvd.scan_date scan_date
       ,ast.report_label application_status
       ,apt.report_label application_type
       ,ai.client_cin member_id
       ,renewal_due_date coverage_end_date       
        ,(SELECT report_label FROM elig_outcome_lkup eeo WHERE eeo.value = aeo.elig_outcome_cd) eligibility_outcome
        ,app_form_cd
        ,fwd_create_ts
        ,staff_fwd_by
        ,fwdby_staff_type       
        ,staff_fwd_to
        ,fwdto_staff_type   
        ,trm.term_date
        ,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END billable_outcome_date
        ,ah.first_mi_added_date mi_date
        ,CASE WHEN rf_outcome_cd = 'PENDING' THEN rf_outcome_date ELSE NULL END refer_to_hcfa_date
        ,txc.callback_date
        ,ttx.new_cycle_start_date
        ,ttx.new_cycle_end_date
        ,ttx.hcfa_reactivation_flag
        ,ttx.exception_type
        ,COALESCE(lxc.exclusion_flag,ttx.exclusion_flag,txc.exclusion_flag) exclusion_flag
        ,CASE WHEN EXISTS (SELECT 1 FROM document_stg d INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id  
                            WHERE doc_type_cd = 'UPLOAD' AND doc_form_type = 'MULT_RESCAN' AND link_type_cd = 'APPLICATION' AND link_ref_id = ah.application_id)
          THEN 'Y' ELSE 'N' END multi_applying_member_flag   
         ,doc_rcvd.link_date link_date 
         ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END cob_indicator
        ,TRUNC(CASE WHEN ttx.exception_type IN('Processing Error','Other') AND ttx.new_cycle_end_date IS NOT NULL THEN TRUNC(ttx.new_cycle_end_date)
                  ELSE LEAST(COALESCE(CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date),
                             COALESCE(fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END),
                             COALESCE(ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts),
                             COALESCE(callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date),
                             COALESCE(detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date) ) END )  cycle_stop  
         ,TRUNC(COALESCE(ttx.new_cycle_start_date,CASE WHEN hcfa_reactivation_flag = 'Y' THEN reactivation_ts END,COALESCE(doc_rcvd.link_date,de_task_create_date))) cycle_start        
         ,CASE WHEN doc_rcvd.doc_form_type = 'LTSS' THEN (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'APPLICATION_SLA_DAYS8' AND value = 'SLA_DAYS8')
               WHEN doc_rcvd.received_date > trm.term_date AND doc_rcvd.received_date <= trm.term_date+90 AND COALESCE(ah.ref_value_1,'0') = '0' THEN 
                 (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'APPLICATION_SLA_DAYS5' AND value = 'SLA_DAYS5')
           ELSE (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'APPLICATION_SLA_DAYS8' AND value = 'SLA_DAYS8') END sla
         ,CASE WHEN doc_rcvd.doc_form_type = 'LTSS' THEN (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'APPLICATION_JEOPARDY_DAYS8' AND value = 'JEOPARDY_DAYS8')
               WHEN doc_rcvd.received_date > trm.term_date AND doc_rcvd.received_date <= trm.term_date+90 AND COALESCE(ah.ref_value_1,'0') = '0' THEN 
                 (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'APPLICATION_JEOPARDY_DAYS5' AND value = 'JEOPARDY_DAYS5')
           ELSE (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'APPLICATION_JEOPARDY_DAYS8' AND value = 'JEOPARDY_DAYS8') END jeopardy_days
         ,(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(COALESCE(ttx.new_cycle_start_date,CASE WHEN hcfa_reactivation_flag = 'Y' THEN ah.reactivation_ts  END,COALESCE(doc_rcvd.link_date,de_task_create_date)))
            AND COALESCE(TRUNC(CASE WHEN ttx.exception_type IN('Processing Error','Other') AND ttx.new_cycle_end_date IS NOT NULL THEN TRUNC(ttx.new_cycle_end_date)
                          ELSE LEAST(COALESCE(CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date),
                                     COALESCE(fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END),
                                     COALESCE(ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts),
                                     COALESCE(callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date),
                                     COALESCE(detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date)) END ) ,TRUNC(SYSDATE) ) )   business_days_cycle_age
        ,COALESCE(rf_staff_completed_by,bo_staff_completed_by) staff_completed_by  
        ,de_task_create_date     
        ,opntask.open_task_name
        ,opntask.open_task_bu_name
        ,opntask.open_task_status
        ,opntask.open_task_owner_name
        ,opntask.open_task_owner_type
        ,doc_rcvd.doc_form_type document_form_type
        ,doc_rcvd.document_type
--for pst calculation
        ,(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(FROM_TZ(CAST(COALESCE(ttx.new_cycle_start_date,CASE WHEN hcfa_reactivation_flag = 'Y' THEN ah.reactivation_ts  END,COALESCE(doc_rcvd.link_date,de_task_create_date)) AS TIMESTAMP),'CST') AT TIME ZONE 'US/Pacific'   )
            AND  TRUNC( FROM_TZ(CAST(COALESCE(CASE WHEN ttx.exception_type IN('Processing Error','Other') AND ttx.new_cycle_end_date IS NOT NULL THEN ttx.new_cycle_end_date
                          ELSE LEAST(COALESCE(CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date),
                                     COALESCE(fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END),
                                     COALESCE(ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts),
                                     COALESCE(callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date),
                                     COALESCE(detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date)) END  ,SYSDATE ) AS TIMESTAMP),'CST') AT TIME ZONE 'US/Pacific')) pst_business_days_cycle_age
        ,TRUNC(FROM_TZ(CAST(COALESCE(ttx.new_cycle_start_date,CASE WHEN hcfa_reactivation_flag = 'Y' THEN ah.reactivation_ts  END,COALESCE(doc_rcvd.link_date,de_task_create_date)) AS TIMESTAMP),'CST') AT TIME ZONE 'US/Pacific'   )  pst_cycle_start                                  
        ,TRUNC(FROM_TZ(CAST(COALESCE(CASE WHEN ttx.exception_type IN('Processing Error','Other') AND ttx.new_cycle_end_date IS NOT NULL THEN ttx.new_cycle_end_date
                          ELSE LEAST(COALESCE(CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date),
                                     COALESCE(fwd_create_ts,ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END),
                                     COALESCE(ah.first_mi_added_date,callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts),
                                     COALESCE(callback_date,detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date),
                                     COALESCE(detask_cycle_stop_date,CASE WHEN rf_outcome_date IS NULL THEN bo.billable_outcome_date ELSE LEAST(rf_outcome_date,COALESCE(bo.billable_outcome_date,rf_outcome_date)) END,fwd_create_ts,ah.first_mi_added_date,callback_date)) END  ,SYSDATE ) AS TIMESTAMP),'CST') AT TIME ZONE 'US/Pacific') pst_cycle_stop        
FROM  app_header_stg ah
 INNER JOIN app_individual_stg ai
    ON ah.application_id = ai.application_id 
    AND applicant_ind = 1
  LEFT OUTER JOIN app_elig_outcome_stg aeo
    ON ai.app_individual_id = aeo.app_individual_id
    AND ai.application_id = aeo.application_id
  LEFT JOIN app_status_lkup ast
    ON ah.status_cd = ast.value
  LEFT OUTER JOIN app_type_lkup apt
    ON ah.app_form_cd = apt.value
  LEFT OUTER JOIN (SELECT ttx.app_id,txl.exception_type,ttx.hcfa_reactivation_flag,ttx.new_cycle_start_date,ttx.new_cycle_end_date,exclusion_flag
                   FROM ts_timeliness_exception ttx
                     JOIN ts_exception_type_lkup txl ON ttx.exception_type_id = txl.exception_type_id                  
                   WHERE txl.exception_type NOT IN('Callback','Letter Exception') 
                   AND ttx.ignore_flag = 'N') ttx  
    ON ah.application_id = ttx.app_id 
  LEFT JOIN (SELECT txc.app_id, txc.callback_date,txc.exclusion_flag
             FROM ts_timeliness_exception txc 
                JOIN ts_exception_type_lkup  tl ON txc.exception_type_id = tl.exception_type_id 
              WHERE tl.exception_type = 'Callback'
              AND txc.ignore_flag = 'N') txc
    ON ah.application_id = txc.app_id 
  LEFT JOIN (SELECT lxc.app_id,lxc.exclusion_flag
             FROM ts_timeliness_exception lxc 
                JOIN ts_exception_type_lkup  ll ON lxc.exception_type_id = ll.exception_type_id 
              WHERE ll.exception_type = 'Letter Exception'
              AND lxc.ignore_flag = 'N') lxc
    ON ah.application_id = lxc.app_id                     
  LEFT JOIN (SELECT *
             FROM(SELECT ref_id application_id, i.step_instance_id fwd_task_id, i.hist_create_ts fwd_create_ts, sfwd.first_name||' '||sfwd.last_name staff_fwd_by, sfwdto.first_name||' '||sfwdto.last_name staff_fwd_to, step_instance_history_id
                             ,sfwd.staff_type_cd fwdby_staff_type, sfwdto.staff_type_cd fwdto_staff_type
                             ,ROW_NUMBER() OVER (PARTITION BY ref_id,ref_type ORDER BY step_instance_history_id) trn
                      FROM step_instance_stg i                                                
                        LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
                        LEFT JOIN d_staff sfwd   ON i.forwarded_by = TO_CHAR(sfwd.staff_id)
                        LEFT JOIN d_staff sfwdto  ON i.owner = TO_CHAR(sfwdto.staff_id)                        
                      WHERE i.ref_type = 'APP_HEADER'                                           
                      AND ((sfwd.staff_type_cd = 'PROJECT_STAFF' AND sfwdto.staff_type_cd = 'STATE') 
                              OR d.business_unit_name = 'HCFA Verifications') )
             WHERE trn = 1    ) taskinfo
   ON taskinfo.application_id = ah.application_id   
  LEFT JOIN (SELECT *
           FROM (
                SELECT el.application_id, el.app_individual_id,TRUNC(el.create_ts) billable_outcome_date, outcome_cd bo_outcome_cd
                       ,ds.first_name||' '||ds.last_name bo_staff_completed_by
                       ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.create_ts) rn
                FROM app_event_log_stg el  
                  LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
                WHERE app_event_cd = 'STATUS_CHANGE'
                AND action_cd = 'END_APPLICATION_TRACKING'  
                AND outcome_cd IN('REJECTED','APPROVED')
                AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                                AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) )          )
           WHERE rn = 1  ) bo
     ON bo.application_id = ah.application_id
LEFT JOIN (SELECT *
           FROM (
                  SELECT el.application_id, el.app_individual_id, TRUNC(el.create_ts) rf_outcome_date, outcome_cd rf_outcome_cd                         
                               ,ds.first_name||' '||ds.last_name rf_staff_completed_by
                               ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.create_ts) rn
                  FROM app_event_log_stg el
                    LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
                  WHERE  el.rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' )
           WHERE rn=1) rf
   ON rf.application_id = ah.application_id
  LEFT JOIN(SELECT *
            FROM (SELECT letter_mailed_date,response_due_date term_date, reference_id,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn            
                  FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
                  WHERE lr.letter_type_cd IN ('TN 411', 'TN 408', 'TN 408ftp', 'TN 409', 'TN 409ftp') 
                  AND lr.letter_status_cd = 'MAIL'
                  AND lr.letter_request_type = 'L')
             WHERE rn = 1 ) trm 
    ON trm.reference_id = ah.application_id                
  LEFT OUTER JOIN(SELECT *
                   FROM(
                     SELECT link_ref_id,ds.received_date,d.scan_date,dl.create_ts link_date,doc_form_type,COALESCE(tl.report_label,d.doc_type_cd) document_type
                            ,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY received_date) rn
                     FROM document_set_stg ds 
                      INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
                      LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'
                      LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                     WHERE doc_type_cd = 'APPLICATION' )
                   WHERE rn = 1) doc_rcvd
      ON doc_rcvd.link_ref_id = ah.application_id      
  LEFT JOIN (SELECT ref_id application_id, i.step_instance_id de_task_id, i.create_ts de_task_create_date, i.completed_ts de_task_complete_date
                    ,CASE WHEN hist_status = 'CLAIMED' AND co.staff_type_cd = 'STATE' THEN i.hist_create_ts ELSE NULL END detask_cycle_stop_date 
                             --,ROW_NUMBER() OVER (PARTITION BY ref_id,ref_type ORDER BY step_instance_history_id ) vrn
                             ,ROW_NUMBER() OVER (PARTITION BY ref_id,ref_type ORDER BY step_instance_history_id ) vrn
                      FROM step_instance_stg i                        
                        JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                        LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
                      WHERE ref_type = 'APP_HEADER'
                      AND task_name = 'Data Evaluation'
                        ) detask
    ON detask.application_id = ah.application_id
    AND detask.de_task_create_date >= doc_rcvd.received_date
    AND vrn = 1      
  LEFT JOIN (SELECT si.*, CASE WHEN open_task_status = 'CLAIMED' THEN si.first_name||' '||si.last_name ELSE NULL END open_task_owner_name
             FROM (SELECT ref_id,step_instance_id,sd.task_name open_task_name,hist_status open_task_status,d.business_unit_name open_task_bu_name,o.first_name,o.last_name,o.staff_type_cd open_task_owner_type
                          ,ROW_NUMBER() OVER (PARTITION BY ref_id,step_instance_id ORDER BY DECODE(hist_status,'COMPLETED',2,'TERMINATED',3,1) DESC,hist_create_ts DESC,step_instance_history_id DESC) rn
                   FROM step_instance_stg si 
                      JOIN d_task_types sd ON si.step_definition_id = sd.task_type_id                       
                      LEFT JOIN d_business_units d ON d.business_unit_id = si.group_id
                      LEFT JOIN d_staff o ON si.owner = TO_CHAR(o.staff_id)
                   where ref_type = 'APP_HEADER'    )  si 
             WHERE rn =1 
             AND open_task_status IN('UNCLAIMED','CLAIMED')) opntask
     ON opntask.ref_id = ah.application_id
WHERE doc_rcvd.received_date >= to_date('06/07/2016','mm/dd/yyyy')  
AND ah.status_cd != 'DISREGARDED'
AND COALESCE(lxc.exclusion_flag,ttx.exclusion_flag,txc.exclusion_flag,'N') = 'N'
 )
