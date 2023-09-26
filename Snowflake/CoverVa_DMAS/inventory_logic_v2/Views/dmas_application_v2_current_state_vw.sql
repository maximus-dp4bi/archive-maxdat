 CREATE OR REPLACE VIEW coverva_dmas.dmas_application_v2_current_state_vw
 AS 
 WITH cs AS(
 SELECT e.tracking_number,e.event_date        
               ,CASE WHEN NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND e.event_date >= cpi.sr_create_date )
                    AND NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_initial_application_review cpi WHERE cpi.tracking_number = e.tracking_number AND e.event_date >= cpi.status_date ) 
                    THEN 
                      CASE WHEN (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cpu = 'N' AND in_cviu = 'N' AND in_cpui = 'N' AND in_cm043 = 'Y' AND case_type = 'Renewal') THEN COALESCE(mio_term_state,'Waiting Initial Review')
                        ELSE 'Intake' END ELSE NULL END current_state_0
               ,CASE WHEN (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cviu = 'N' AND in_cpui = 'N') 
                    AND (COALESCE(in_running_ppit,'N') = 'N' AND COALESCE(in_running_am,'N') = 'N' AND COALESCE(in_running_pw,'N') = 'N' 
                     AND COALESCE(in_running_cviu,'N') = 'N' AND COALESCE(in_running_cpui,'N') = 'N')
                    AND in_cpu = 'Y' AND COALESCE(cpu_status,'X') != 'Submitted'  THEN 'current_state_0a' ELSE NULL END current_state_0a
               ,CASE WHEN ( (in_app_metric = 'Y' AND (case_type != 'Renewal' OR (case_type = 'Renewal' AND am_processing_status != 'Completed' ))
                       AND  ( (worker_id IS NULL OR  (REGEXP_INSTR(worker_id, '900') > 0 AND am_wid_in_ldap = 'Y')) AND (in_ppit = 'N' OR ppit_wid_in_ldap = 'Y') ) ) 
                   OR (in_ppit = 'Y' AND (ppit_worker_id IS NOT NULL AND REGEXP_INSTR(ppit_worker_id, '900') > 0 AND ppit_wid_in_ldap = 'Y' ))  )
                   OR  (in_app_metric = 'N' AND in_ppit = 'N' AND ( (in_cviu = 'Y' AND COALESCE(cviu_processing_status,'X') != 'Submitted') OR (in_cpui = 'Y' AND COALESCE(cpui_processing_status,'X') != 'Submitted') ) )
                   OR (case_type != 'Renewal' AND in_cm043 = 'Y' AND UPPER(processing_status) = 'NEW')  
                   OR (case_type = 'Renewal' AND in_cm043 = 'Y')  
                   THEN 'current_state_1' ELSE NULL END current_state_1
               ,CASE 
                  WHEN (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cpu = 'N' AND in_cviu = 'N' AND in_cpui = 'N' AND in_cm043 = 'Y' AND case_type = 'Renewal') THEN COALESCE(mio_term_state,'Waiting Initial Review')
                  WHEN (e.cp_inv_pend_disposition IS NOT NULL OR e.cp_iar_pend_disposition IS NOT NULL) 
                         OR (e.sd_stage = '6-Pending VCL')
                         OR (mio_prod_status  = 'Waiting for Verification Documents')
                         OR (manual_prod_status  = 'Waiting for Verification Documents')
                         OR (manual_cviu_status = 'Waiting for Verification Documents')
                         OR (manual_cpu_status = 'Waiting for Verification Documents')
                       THEN 'Waiting for Verification Documents'
                     WHEN mio_prod_status = 'Initial Review Complete' THEN mio_prod_status
                     WHEN (EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND complete_task_date IS NULL) AND e.cp_inv_pend_disposition IS NULL)  
                        AND e.cp_iar_pend_disposition IS NULL 
                        AND in_manual_cpu = 'N' AND in_manual_cviu = 'N'
                        AND (mpt_orig_status IS NULL OR UPPER(mpt_orig_status) NOT LIKE 'PENDING%VCL%') 
                        AND (mio_orig_status IS NULL OR (mio_prod_status) NOT IN('Waiting for Verification Documents','Initial Review Complete')) 
                      THEN 'Waiting Initial Review'
                  ELSE 'Waiting Initial Review' END  current_state_1a                                             
               ,CASE WHEN e.cm044_status IS NOT NULL THEN e.cm044_status ELSE NULL END current_state_2                                                        
               ,CASE WHEN (e.cp_inv_action_taken IS NOT NULL OR e.cp_iar_action_taken IS NOT NULL OR e.cp_inv_ad_disposition = 'REFERRED' OR cp_iar_ad_disposition = 'REFERRED'
                        OR e.manual_cpu_status = 'Transferred to LDSS' OR e.manual_cviu_status = 'Transferred to LDSS' OR e.mio_term_state = 'Transferred to LDSS')                        
                   THEN 'Transferred to LDSS' ELSE NULL END current_state_3
                ,CASE WHEN ( (in_app_metric = 'Y'  AND (case_type != 'Renewal' OR (case_type = 'Renewal' AND am_processing_status != 'Completed' ))
                               AND (REGEXP_INSTR(worker_id, '900') > 0 AND worker_id IS NOT NULL AND am_wid_in_ldap = 'N') )
                         OR (in_ppit = 'Y' AND (REGEXP_INSTR(ppit_worker_id, '900') > 0 AND ppit_worker_id IS NOT NULL AND ppit_wid_in_ldap = 'N'))
                         OR (in_cviu = 'Y' AND (REGEXP_INSTR(cviu_worker, '900') > 0 AND cviu_worker IS NOT NULL AND cviu_wid_in_ldap = 'N') )
                         OR (in_cpui = 'Y' AND (REGEXP_INSTR(cpui_worker, '900') > 0 AND cpui_worker IS NOT NULL AND cpui_wid_in_ldap = 'N') ) )
                       THEN 'Non Maximus Assigned' ELSE NULL END current_state_3b     
                ,CASE  WHEN ((in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cm043 = 'N' AND in_cviu = 'N' AND in_cpui = 'N') AND (in_running_ppit = 'Y' OR in_running_am = 'Y' OR in_running_pw = 'Y') )                                                  
                      OR (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cm043 = 'N' AND in_cviu = 'N' AND in_cpui = 'N' AND in_running_cm043 = 'Y')   
                      OR (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cm043 = 'N' AND in_cviu = 'N' AND in_cpui = 'N' AND (in_running_cviu = 'Y' OR in_running_cpui = 'Y' ) )                  
                   THEN 'current_state_4' ELSE NULL END current_state_4         
                ,CASE WHEN ( (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N') 
                              --use running status if app fell off from cviu or cpui or cpu
                              AND (COALESCE(cpu_status,running_cpu_status) = 'Submitted'                                     
                               OR (DATEDIFF(DAY,CAST(COALESCE(cpu_app_received_date,running_cpu_app_received_date) AS DATE),cpuev.cpu_last_event) < 60) ) )  
                       OR (in_app_metric = 'Y' AND case_type = 'Renewal' AND am_processing_status = 'Completed' )
                       OR (in_app_metric = 'N' AND in_running_am = 'Y' AND running_case_type = 'Renewal' AND running_am_processing_status = 'Completed' )
                   THEN 'current_state_5' ELSE NULL END current_state_5 
               ,CASE WHEN ( (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N') 
                              --use running status if app fell off from cviu or cpui or cpu
                             AND (COALESCE(cviu_processing_status,running_cviu_status) = 'Submitted' OR COALESCE(cpui_processing_status,running_cpui_status) = 'Submitted'  ) )  THEN 'current_state_5a' ELSE NULL END current_state_5a                                
               ,CASE WHEN ((in_cviu = 'Y' AND cviu_worker IS NOT NULL AND REGEXP_INSTR(cviu_worker, '900') = 0)   
                             OR (in_cpui = 'Y' AND cpui_worker IS NOT NULL AND REGEXP_INSTR(cpui_worker, '900') = 0)  
                             OR (in_ppit = 'Y' AND ppit_worker_id IS NOT NULL AND REGEXP_INSTR(ppit_worker_id, '900') = 0) 
                             OR (in_cviu = 'N' AND running_cviu_worker IS NOT NULL AND REGEXP_INSTR(running_cviu_worker, '900') = 0) --check last record where the app was found in these sources
                             OR (in_cpui = 'N' AND running_cpui_worker IS NOT NULL AND REGEXP_INSTR(running_cpui_worker, '900') = 0)  
                             OR (in_ppit = 'N' AND running_ppit_worker IS NOT NULL AND REGEXP_INSTR(running_ppit_worker, '900') = 0) ) THEN 'current_state_6' ELSE NULL END current_state_6 
               ,CASE WHEN ((in_cviu = 'N' AND in_cpui = 'N' AND in_ppit = 'N' AND in_app_metric = 'Y' AND worker_id IS NOT NULL AND REGEXP_INSTR(worker_id, '900') = 0 )  
                    OR (in_cviu = 'N' AND in_cpui = 'N' AND in_ppit = 'N' AND in_app_metric = 'N' AND running_am_worker IS NOT NULL AND REGEXP_INSTR(running_am_worker, '900') = 0 ) ) THEN 'current_state_7' ELSE NULL END current_state_7
               ,CASE WHEN (e.cp_inv_ad_disposition IS NOT NULL OR e.cp_iar_ad_disposition IS NOT NULL OR e.manual_cpu_status IS NOT NULL OR e.manual_cviu_status IS NOT NULL OR e.mio_term_state IS NOT NULL) THEN 
                    CASE WHEN e.cp_inv_ad_disposition IN('APPROVED','AUTO_APPROVED') OR e.cp_iar_ad_disposition IN('APPROVED','AUTO_APPROVED') 
                            OR e.manual_cpu_status = 'Approved' OR e.manual_cviu_status = 'Approved' THEN 'Approved' 
                         WHEN e.cp_inv_ad_disposition IN('DENIED','AUTO_DENIED','DENIED_CLOSED') OR e.cp_iar_ad_disposition IN('DENIED','AUTO_DENIED','DENIED_CLOSED') 
                             OR e.manual_cpu_status = 'Denied' OR e.manual_cviu_status = 'Denied' THEN 'Denied' 
                         WHEN e.mio_term_state = 'Approved' THEN 'Approved'
                         WHEN e.mio_term_state = 'Denied' THEN 'Denied'
                    ELSE 'Complete - Needs Research' END 
                 ELSE 'Complete - Needs Research' END current_state_8
               ,CASE WHEN e.mio_term_state IN ('Approved','Denied','Complete - Needs Research','Transferred to LDSS') THEN e.mio_term_state ELSE NULL END current_state_9  
               ,CASE WHEN e.manual_prod_status IS NOT NULL THEN e.manual_prod_status ELSE NULL END current_state_10  
               ,CASE WHEN e.override_current_state IS NOT NULL THEN e.override_current_state ELSE NULL END current_state_11               
               ,CASE WHEN (NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND e.event_date >= cpi.sr_create_date ) 
                        OR (EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND complete_task_date IS NULL) AND e.cp_inv_pend_disposition IS NULL) ) 
                        AND NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_initial_application_review cpi WHERE cpi.tracking_number = e.tracking_number AND e.event_date >= cpi.status_date ) AND e.cp_iar_pend_disposition IS NULL 
                        AND in_manual_cpu = 'N' AND in_manual_cviu = 'N'
                     THEN 'Waiting Initial Review' ELSE NULL END current_state_12
               ,CASE WHEN (e.cp_inv_pend_disposition IS NOT NULL OR e.cp_iar_pend_disposition IS NOT NULL) 
                        OR (in_app_metric = 'Y' AND pending_due_vcl_am = 'Y') OR (in_app_metric_pw = 'Y' AND pending_due_vcl_pw = 'Y' ) 
                     THEN 'Waiting for Verification Documents' ELSE NULL END current_state_13
               ,LEAST(COALESCE(e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.mcpu_ldss_date,e.mcviu_ldss_date,e.cp_iar_ldss_end_date,e.mio_complete_date)
                       ,COALESCE(e.cp_referred_dispo_date,e.mcpu_ldss_date,e.mcviu_ldss_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.cp_ai_ldss_date)
                       ,COALESCE(e.mcpu_ldss_date,e.mcviu_ldss_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.cp_ai_ldss_date,e.cp_referred_dispo_date)
                       ,COALESCE(e.mcviu_ldss_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.mcpu_ldss_date)
                       ,COALESCE(e.cp_iar_ldss_end_date,e.mio_complete_date,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.mcpu_ldss_date,e.mcviu_ldss_date)
                       ,COALESCE(e.mio_complete_date,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.mcpu_ldss_date,e.mcviu_ldss_date,e.cp_iar_ldss_end_date)) ldss_end_date  
               ,LEAST(COALESCE(e.cp_ai_complete_date,e.mcpu_complete_date,e.mcviu_complete_date,e.cp_iar_ad_status_date)
                              ,COALESCE(e.mcpu_complete_date,e.mcviu_complete_date,e.cp_iar_ad_status_date,e.cp_ai_complete_date)
                              ,COALESCE(e.mcviu_complete_date,e.cp_iar_ad_status_date,e.cp_ai_complete_date,e.mcpu_complete_date)    
                              ,COALESCE(e.cp_iar_ad_status_date,e.cp_ai_complete_date,e.mcpu_complete_date,e.mcviu_complete_date)) ad_complete_date               
               ,CASE WHEN e.override_current_state IS NOT NULL THEN 'Y' ELSE 'N' END override_indicator
               ,e.mpt_complete_date,e.override_app_end_date,e.cm044_authorized_date,inv.latest_inventory_date, ame.last_date_in_file, e.mio_complete_date,wrk.last_date_in_file_mwrk
               ,cpu_last_event,min_cpu_submit_date,state_app_received_date,inv.previous_current_state,inv.previous_end_date,mio_term_state,in_cm043,in_running_cm043,case_type,running_case_type,previous_vcl_sent
             FROM (SELECT e.*,
                    CASE WHEN manual_cpu_status = 'Transferred to LDSS' THEN mcpu_activity_date ELSE NULL END mcpu_ldss_date
                    ,CASE WHEN manual_cpu_status IN('Approved','Denied') THEN mcpu_activity_date ELSE NULL END mcpu_complete_date
                    ,CASE WHEN manual_cviu_status = 'Transferred to LDSS' THEN mcviu_activity_date ELSE NULL END mcviu_ldss_date
                    ,CASE WHEN manual_cviu_status IN('Approved','Denied') THEN mcviu_activity_date ELSE NULL END mcviu_complete_date
                    ,CASE WHEN cp_inv_ad_disposition = 'REFERRED' OR cp_iar_ad_disposition = 'REFERRED' THEN COALESCE(cp_inv_ad_complete_date,cp_iar_ad_status_date,cp_inv_ad_status_date) ELSE NULL END cp_referred_dispo_date
                    ,COALESCE(cp_inv_ldss_end_date,cp_inv_ldss_status_date) cp_ai_ldss_date
                    ,COALESCE(cp_inv_ad_complete_date,cp_inv_ad_status_date) cp_ai_complete_date                    
                   ,RANK() OVER (PARTITION BY e.tracking_number ORDER BY event_date DESC) rnk
                   FROM coverva_dmas.dmas_raw_application_v2_event_vw e ) e              
               LEFT JOIN(SELECT tracking_number,MIN(cpu_last_event) cpu_last_event
                         FROM(SELECT tracking_number,MIN(event_date) cpu_last_event 
                              FROM coverva_dmas.dmas_application_v2_event cpue 
                              WHERE cpue.in_cpu = 'N' 
                              AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_event cpuf WHERE cpue.tracking_number = cpuf.tracking_number and cpuf.event_date > cpue.event_date and cpuf.in_cpu = 'Y') 
                              GROUP BY tracking_number
                              UNION
                              SELECT tracking_number,MIN(cpu_last_event) cpu_last_event
                              FROM coverva_dmas.dmas_application_v2_min_event
                              WHERE cpu_last_event IS NOT NULL
                              GROUP BY tracking_number)
                          GROUP BY tracking_number  ) cpuev ON e.tracking_number = cpuev.tracking_number
               LEFT JOIN(SELECT tracking_number,MIN(min_cpu_submit_date) min_cpu_submit_date
                         FROM(SELECT tracking_number,MIN(event_date) min_cpu_submit_date 
                              FROM coverva_dmas.dmas_application_v2_event cpue 
                              WHERE cpue.in_cpu = 'Y' AND cpu_status = 'Submitted'
                              GROUP BY tracking_number
                              UNION
                              SELECT tracking_number,MIN(min_cpu_submit_date) min_cpu_submit_date
                              FROM coverva_dmas.dmas_application_v2_min_event
                              WHERE min_cpu_submit_date IS NOT NULL
                              GROUP BY tracking_number)
                          GROUP BY tracking_number  ) mcpus ON e.tracking_number = mcpus.tracking_number 
               LEFT JOIN(SELECT tracking_number,MAX(last_date_in_file) last_date_in_file
                         FROM(SELECT tracking_number,MAX(event_date) last_date_in_file
                              FROM coverva_dmas.dmas_application_v2_event ame
                              WHERE (ame.in_app_metric = 'Y' 
                              OR ame.in_ppit = 'Y' 
                              OR ame.in_app_metric_pw = 'Y'                                
                              OR ame.in_cviu = 'Y'
                              OR ame.in_cpu_incarcerated = 'Y'
                              OR ame.in_cm043 = 'Y' )  
                              AND EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_event mn JOIN public.d_dates dd ON mn.event_date = dd.d_date AND dd.project_id = 117 AND business_day_flag = 'Y'
                                         WHERE ame.tracking_number = mn.tracking_number
                                         AND mn.in_app_metric = 'N' AND mn.in_ppit = 'N' AND mn.in_app_metric_pw = 'N' AND mn.in_cviu = 'N' AND mn.in_cpu_incarcerated = 'N' AND mn.in_cm043 = 'N'
                                         AND mn.application_event_id > ame.application_event_id 
                                         AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_event my JOIN public.d_dates dd ON my.event_date = dd.d_date AND dd.project_id = 117 AND business_day_flag = 'Y'
                                                        WHERE my.tracking_number = mn.tracking_number                                    
                                                        AND (my.in_app_metric = 'Y' OR my.in_ppit = 'Y' OR my.in_app_metric_pw = 'Y' OR my.in_cviu = 'Y' OR my.in_cpu_incarcerated = 'Y' OR my.in_cm043 = 'Y') 
                                                        AND my.application_event_id > mn.application_event_id ) )
                              GROUP BY tracking_number
                              UNION
                              SELECT tracking_number,MAX(last_date_in_file) last_date_in_file
                              FROM coverva_dmas.dmas_application_v2_min_event
                              WHERE last_date_in_file IS NOT NULL
                              GROUP BY tracking_number)
                         GROUP BY tracking_number ) ame ON ame.tracking_number = e.tracking_number
              LEFT JOIN(SELECT tracking_number,MIN(last_date_in_file_mwrk) last_date_in_file_mwrk
                        FROM(SELECT tracking_number,MIN(event_date) last_date_in_file_mwrk
                             FROM coverva_dmas.dmas_application_v2_event wrk
                             WHERE ( (wrk.in_app_metric = 'Y' AND (REGEXP_INSTR(am_worker, '900') = 0) )
                                OR (wrk.in_ppit = 'Y' AND (REGEXP_INSTR(ppit_worker, '900') = 0) )                         
                                OR (wrk.in_cviu = 'Y'AND (REGEXP_INSTR(cviu_worker, '900') = 0) ) 
                                OR (wrk.in_cpu_incarcerated = 'Y' AND ( REGEXP_INSTR(cpui_worker, '900') = 0) )        )                        
                             GROUP BY tracking_number
                             UNION
                             SELECT tracking_number,MIN(last_date_in_file_mwrk) last_date_in_file_mwrk
                             FROM coverva_dmas.dmas_application_v2_min_event
                             WHERE last_date_in_file_mwrk IS NOT NULL
                             GROUP BY tracking_number)
                        GROUP BY tracking_number  ) wrk ON wrk.tracking_number = e.tracking_number                       
               LEFT JOIN (SELECT tracking_number,file_inventory_date latest_inventory_date,state_app_received_date,previous_current_state,previous_end_date,previous_vcl_sent 
                            FROM(SELECT da.tracking_number,file_inventory_date,state_app_received_date, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk
                                      ,LEAD(current_state) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) previous_current_state
                                      ,LEAD(vcl_sent_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) previous_vcl_sent
                                      ,LEAD(application_processing_end_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) previous_end_date
                                 FROM coverva_dmas.dmas_application_v2_inventory da) 
                            WHERE rnk = 1) inv ON e.tracking_number = inv.tracking_number  ),
final_cur_state AS                            
(SELECT cs.tracking_number
  ,cs.event_date,latest_inventory_date,previous_current_state
  ,current_state_0,current_state_1,current_state_1a,current_state_2,current_state_3,current_state_3b,current_state_4,current_state_5,current_state_5a ,current_state_6,current_state_7
  ,current_state_8,current_state_9,current_state_10,current_state_11
  ,override_app_end_date,mpt_complete_date ,ldss_end_date,cm044_authorized_date,ad_complete_date
  ,last_date_in_file last_date_in_any_file
  ,mio_complete_date,last_date_in_file_mwrk,cpu_last_event,min_cpu_submit_date,previous_end_date,previous_vcl_sent
  ,CASE WHEN (current_state_1 IS NOT NULL OR current_state_0a IS NOT NULL) THEN 
        CASE WHEN current_state_0 IS NOT NULL THEN current_state_0 
             WHEN previous_current_state = 'Non Maximus Assigned' AND current_state_1a = 'Waiting Initial Review' THEN 'Initial Review Complete'
          ELSE current_state_1a END       
       WHEN current_state_2 IS NOT NULL THEN current_state_2
       WHEN current_state_3 IS NOT NULL THEN current_state_3     
       WHEN current_state_3b IS NOT NULL THEN current_state_3b     
       WHEN running_case_type = 'Renewal' AND current_state_4 IS NOT NULL THEN
         CASE WHEN in_cm043 = 'N' AND in_running_cm043 = 'Y' AND current_state_8 = 'Complete - Needs Research' THEN CASE WHEN mio_term_state IS NOT NULL THEN mio_term_state ELSE 'Waiting Initial Review' END ELSE current_state_8 END       
       WHEN current_state_4 IS NOT NULL OR current_state_5 IS NOT NULL OR current_state_5a IS NOT NULL OR current_state_6 IS NOT NULL OR current_state_7 IS NOT NULL THEN current_state_8
       WHEN current_state_9 IS NOT NULL THEN current_state_9
       WHEN current_state_10 IS NOT NULL THEN current_state_10
       WHEN current_state_11 IS NOT NULL THEN current_state_11  
       WHEN previous_current_state IN ('Approved','Denied','Complete - Needs Research','Transferred to LDSS') THEN previous_current_state
   ELSE 'Waiting Initial Review' END final_current_state
 FROM cs)   
 SELECT fcs.*,
   CAST(CASE WHEN final_current_state IN('Intake','Waiting Initial Review','Waiting for Verification Documents','Initial Review Complete','Non Maximus Assigned') THEN NULL
             WHEN current_state_2 IS NOT NULL THEN cm044_authorized_date                         
             WHEN current_state_3 = 'Transferred to LDSS' THEN CASE WHEN ldss_end_date IS NOT NULL THEN ldss_end_date ELSE NULL END             
             WHEN final_current_state IN('Approved','Denied','Complete - Needs Research') THEN                                  
               CASE WHEN COALESCE(mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file) IS NOT NULL 
                THEN LEAST(COALESCE(mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file),
                     COALESCE(ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mio_complete_date),
                     COALESCE(last_date_in_file_mwrk,fcs.last_date_in_any_file,mio_complete_date,ad_complete_date),
                     COALESCE(fcs.last_date_in_any_file,mio_complete_date,ad_complete_date,last_date_in_file_mwrk))
                 ELSE LEAST(COALESCE(cpu_last_event,min_cpu_submit_date),COALESCE(min_cpu_submit_date,cpu_last_event)) END                 
             WHEN current_state_9 IS NOT NULL THEN
                CASE WHEN current_state_9 IN('Approved','Denied','Transferred to LDSS','Complete - Needs Research') THEN mio_complete_date ELSE NULL END 
             WHEN current_state_10 IS NOT NULL THEN
                CASE WHEN current_state_10 IN('Approved','Denied','Transferred to LDSS','Complete - Needs Research') THEN mpt_complete_date ELSE NULL END   
             WHEN current_state_11 IS NOT NULL THEN
                CASE WHEN current_state_11 IN('Approved','Denied','Transferred to LDSS','Complete - Needs Research') THEN override_app_end_date ELSE NULL END    
             WHEN previous_end_date IS NOT NULL THEN previous_end_date    
        ELSE NULL END AS DATE) final_end_date,
   CASE WHEN final_current_state IN('Approved','Denied','Transferred to LDSS','Complete - Needs Research') THEN
       CASE WHEN current_state_2 IS NOT NULL THEN 'Y' ELSE 'N' END 
     ELSE NULL END cm044_verified,
   CASE WHEN final_current_state = 'Non Maximus Assigned' THEN event_date ELSE NULL END non_maximus_initial_date,
   CASE WHEN previous_current_state = 'Non Maximus Assigned' AND final_current_state != previous_current_state THEN event_date ELSE NULL END non_maximus_returned_date,
   CASE WHEN final_current_state = 'Waiting for Verification Documents' THEN CASE WHEN previous_vcl_sent IS NULL THEN event_date ELSE previous_vcl_sent END ELSE NULL END waiting_for_vdoc_date
 FROM final_cur_state fcs;
 

