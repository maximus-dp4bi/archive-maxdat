CREATE OR REPLACE VIEW coverva_dmas.dmas_application_current_state_vw
AS
WITH curr AS( 
              SELECT e.tracking_number,e.event_date 
               ,CASE WHEN mpt.manual_prod_status IS NOT NULL THEN mpt.manual_prod_status
                     WHEN o.override_status IS NOT NULL THEN o.override_status 
                     WHEN apldss.tracking_number IS NOT NULL OR iarldss.tracking_number IS NOT NULL 
                        OR mcpu.manual_cpu_status = 'Transferred to LDSS' OR mcviu.manual_cviu_status = 'Transferred to LDSS' THEN 'Transferred to LDSS' 
                     WHEN cm.cm044_status IS NOT NULL THEN cm.cm044_status 
                     WHEN ( ( (in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND dd.business_day_flag = 'Y' ) 
                               AND (cviu_processing_status = 'Submitted' OR cpui_processing_status = 'Submitted' OR COALESCE(cpu_status,running_cpu_status) = 'Submitted' 
                                      OR (DATEDIFF(DAY,CAST(COALESCE(cpu_app_received_date,running_cpu_app_received_date) AS DATE),cpuev.cpu_last_event) < 60) ) ) 
                          OR ((in_cviu = 'Y' AND cviu_worker IS NOT NULL AND REGEXP_INSTR(cviu_worker, '900') = 0)   
                             OR (in_cpu_incarcerated = 'Y' AND cpui_worker IS NOT NULL AND REGEXP_INSTR(cpui_worker, '900') = 0)  
                             OR (in_ppit = 'Y' AND ppit_worker IS NOT NULL AND REGEXP_INSTR(ppit_worker, '900') = 0) ) 
                          OR(in_cviu = 'N' AND in_cpu_incarcerated = 'N' AND in_ppit = 'N' AND in_app_metric = 'Y' AND am_worker IS NOT NULL AND REGEXP_INSTR(am_worker, '900') = 0 )  ) THEN 
                          CASE WHEN (cpd.tracking_number IS NOT NULL OR iard.tracking_number IS NOT NULL) THEN 
                              CASE WHEN cpd.disposition IN('APPROVED','AUTO_APPROVED') OR iard.disposition IN('APPROVED','AUTO_APPROVED') THEN 'Approved' 
                                   WHEN cpd.disposition IN('DENIED','AUTO_DENIED') OR iard.disposition IN('DENIED','AUTO_DENIED') THEN 'Denied' 
                                ELSE 'Complete - Needs Research' END 
                            ELSE 'Complete - Needs Research' END 
                     WHEN (NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number) 
                        OR (EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND complete_task_date IS NULL) AND cpmi.tracking_number IS NULL) ) 
                        AND NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_initial_application_review cpi WHERE cpi.tracking_number = e.tracking_number) AND iarmi.tracking_number IS NULL 
                     THEN 'Waiting Initial Review' 
                     WHEN (cpmi.tracking_number IS NOT NULL OR iarmi.tracking_number IS NOT NULL) 
                        OR (in_app_metric = 'Y' AND pending_due_vcl_am = 'Y') OR (in_app_metric_pw = 'Y' AND pending_due_vcl_pw = 'Y' ) 
                     THEN 'Waiting for Verification Documents' 
                  ELSE 'Waiting Initial Review' END current_state 
               ,LEAST(COALESCE(apldss.app_end_date,mcpu.mcpu_ldss_date,mcviu.mcviu_ldss_date,iarldss.app_end_date)
                      ,COALESCE(mcpu.mcpu_ldss_date,mcviu.mcviu_ldss_date,iarldss.app_end_date,apldss.app_end_date)
                      ,COALESCE(mcviu.mcviu_ldss_date,iarldss.app_end_date,apldss.app_end_date,mcpu.mcpu_ldss_date)
                      ,COALESCE(iarldss.app_end_date,apldss.app_end_date,mcpu.mcpu_ldss_date,mcviu.mcviu_ldss_date) ) ldss_end_date  
               ,CASE WHEN cm.cm044_status IS NOT NULL THEN cm.cm044_authorized_date 
                   ELSE LEAST(COALESCE(cpd.complete_task_date,mcpu.mcpu_complete_date,mcviu.mcviu_complete_date,iard.status_date)
                              ,COALESCE(mcpu.mcpu_complete_date,mcviu.mcviu_complete_date,iard.status_date,cpd.complete_task_date)
                              ,COALESCE(mcviu.mcviu_complete_date,iard.status_date,cpd.complete_task_date,mcpu.mcpu_complete_date)    
                              ,COALESCE(iard.status_date,cpd.complete_task_date,mcpu.mcpu_complete_date,mcviu.mcviu_complete_date)) 
                   END ad_complete_date
               ,CASE WHEN o.override_status IS NOT NULL THEN 'Y' ELSE 'N' END override_indicator
               ,mpt.mpt_complete_date,o.override_app_end_date, e.prev_app_end_date, inv.latest_inventory_date
             FROM coverva_dmas.dmas_application_event e 
               LEFT JOIN PUBLIC.D_DATES dd on e.event_date = dd.d_date AND dd.project_id = 117 
               LEFT JOIN (SELECT tracking_number,file_inventory_date latest_inventory_date 
                            FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                 FROM coverva_dmas.dmas_application da) 
                            WHERE rnk = 1) inv ON e.tracking_number = inv.tracking_number 
               LEFT JOIN(SELECT tracking_number,min(event_date) cpu_last_event 
                         FROM coverva_dmas.dmas_application_event cpue 
                         WHERE cpue.in_cpu = 'N' 
                         AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event cpuf WHERE cpue.tracking_number = cpuf.tracking_number and cpuf.event_date > cpue.event_date and cpuf.in_cpu = 'Y') 
                         GROUP BY tracking_number) cpuev ON e.tracking_number = cpuev.tracking_number 
             LEFT JOIN(SELECT tracking_number,app_end_date,sr_create_date 
                         FROM(SELECT tracking_number, complete_task_date app_end_date,sr_create_date 
                               ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY complete_task_date,sr_id) rn 
                              FROM coverva_dmas.cp_application_inventory cp 
                              WHERE action_taken = 'TRANSFERRED_TO_LDSS' ) 
                         WHERE rn =1) apldss ON apldss.tracking_number = e.tracking_number  AND e.event_date >= CAST(COALESCE(apldss.app_end_date,apldss.sr_create_date) AS DATE)  
              LEFT JOIN(SELECT tracking_number,app_end_date,created_on   
                         FROM(SELECT tracking_number, status_date app_end_date,created_on 
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY status_date,task_id) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                              WHERE action_taken = 'TRANSFERRED_TO_LDSS'  ) iar 
                         WHERE rn = 1 ) iarldss ON iarldss.tracking_number = e.tracking_number AND e.event_date >= CAST(COALESCE(iarldss.app_end_date,iarldss.created_on) AS DATE)
               LEFT JOIN(SELECT tracking_number,disposition,complete_task_date,sr_create_date 
                         FROM(SELECT tracking_number, disposition,complete_task_date,sr_create_date 
                               ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,3),complete_task_date,sr_id) rn 
                              FROM coverva_dmas.cp_application_inventory cp 
                              WHERE disposition NOT IN('PENDING_MI','CANCELLED') ) 
                         WHERE rn =1) cpd ON cpd.tracking_number = e.tracking_number  AND e.event_date >= CAST(COALESCE(cpd.complete_task_date,cpd.sr_create_date) AS DATE)
               LEFT JOIN(SELECT tracking_number,disposition,complete_task_date,sr_create_date 
                         FROM(SELECT tracking_number, disposition,complete_task_date,sr_create_date 
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY complete_task_date DESC,sr_id DESC) rn 
                              FROM coverva_dmas.cp_application_inventory cp ) 
                         WHERE rn =1 AND disposition = 'PENDING_MI') cpmi ON cpmi.tracking_number = e.tracking_number AND e.event_date >= CAST(COALESCE(cpmi.complete_task_date,cpmi.sr_create_date) AS DATE) 
               LEFT JOIN(SELECT tracking_number,disposition,status_date,created_on   
                         FROM(SELECT tracking_number, disposition,status_date,created_on 
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,3),status_date,task_id) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                              WHERE disposition NOT IN('PENDING_MI','CANCELLED') ) cp 
                         WHERE rn = 1 ) iard ON iard.tracking_number = e.tracking_number AND e.event_date >= CAST(COALESCE(iard.status_date,iard.created_on) AS DATE)
               LEFT JOIN(SELECT tracking_number,disposition,status_date,created_on  
                         FROM(SELECT tracking_number, disposition,created_on,status_date                        
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY status_date,task_id) rn 
                              FROM coverva_dmas.cp_initial_application_review cp ) cp  
                         WHERE rn = 1 AND disposition = 'PENDING_MI') iarmi ON iarmi.tracking_number = e.tracking_number AND e.event_date >= CAST(COALESCE(iarmi.status_date,iarmi.created_on) AS DATE) 
               LEFT JOIN (SELECT DISTINCT tracking_number,cm044_status,cm044_authorized_date,file_date 
                         FROM(SELECT tracking_number,status cm044_status,authorized_date cm044_authorized_date, CAST(f.file_date AS DATE) file_date 
                                ,ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY UPPER(LEFT(cm.status,1)),cm.authorized_date) rnk 
                              FROM coverva_dmas.cm044_data_full_load cm 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1) cm ON cm.tracking_number = e.tracking_number AND CAST(cm.cm044_authorized_date AS DATE ) <= e.event_date 
                   LEFT JOIN (SELECT DISTINCT application_number,manual_cpu_status,mcpu_activity_date
                                    ,CASE WHEN manual_cpu_status = 'Transferred to LDSS' THEN mcpu_activity_date ELSE NULL END mcpu_ldss_date
                                    ,CASE WHEN manual_cpu_status IN('Approved','Denied') THEN mcpu_activity_date ELSE NULL END mcpu_complete_date
                              FROM(SELECT application_number
                                     ,CASE WHEN sent_to_ldss = '1' THEN 'Transferred to LDSS'
                                           WHEN approved = '1' THEN 'Approved' 
                                           WHEN denied = '1' THEN 'Denied'
                                           WHEN vcl = '1' THEN 'Waiting for Verification Documents'
                                       ELSE NULL END manual_cpu_status
                                     ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcpu_activity_date
                                     ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC,record_id DESC) rnk 
                                  FROM coverva_dmas.manual_cpu_tracking) 
                              WHERE rnk = 1) mcpu ON mcpu.application_number = e.tracking_number AND e.event_date >= mcpu.mcpu_activity_date 
                   LEFT JOIN (SELECT DISTINCT application_number,manual_cviu_status,mcviu_activity_date  
                              ,CASE WHEN manual_cviu_status = 'Transferred to LDSS' THEN mcviu_activity_date ELSE NULL END mcviu_ldss_date
                                    ,CASE WHEN manual_cviu_status IN('Approved','Denied') THEN mcviu_activity_date ELSE NULL END mcviu_complete_date
                              FROM(SELECT application_number, 
                                     CASE WHEN LEFT(UPPER(sent_to_ldss_1yes_0no),1) IN('Y','1') THEN 'Transferred to LDSS' 
                                          WHEN UPPER(status) LIKE 'APPROVED%' THEN 'Approved'
                                          WHEN UPPER(status) LIKE 'DENIED%' THEN 'Denied'                                          
                                          WHEN LEFT(UPPER(vcl_1yes_0no),1) IN('Y','1') OR LEFT(UPPER(manual_vcl_1yes_0no),1) IN('Y','1') THEN 'Waiting for Verification Documents'
                                       ELSE NULL END manual_cviu_status
                                     ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcviu_activity_date
                                     ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC,record_id DESC) rnk 
                                  FROM coverva_dmas.manual_cviu_tracking) 
                              WHERE rnk = 1) mcviu ON mcviu.application_number = e.tracking_number AND e.event_date >= mcviu.mcviu_activity_date 
                   LEFT JOIN (SELECT DISTINCT tracking_number,manual_prod_status,mpt_complete_date                                  
                              FROM(SELECT tracking_number, 
                                     CASE WHEN UPPER(status) = 'TRANSFERRED TO LDSS' THEN 'Transferred to LDSS' 
                                          WHEN UPPER(status) = 'APPROVED' THEN 'Approved'
                                          WHEN UPPER(status) = 'DENIED' THEN 'Denied'                                          
                                          WHEN UPPER(status) = 'PENDING, EMERGENCY SERVICES' THEN 'Complete - Needs Research'
                                          WHEN UPPER(status) LIKE 'PENDING%VCL%' THEN 'Waiting for Verification Documents'
                                          WHEN UPPER(status) = 'NONE OF THE ABOVE' THEN 'Waiting Initial Review'
                                       ELSE NULL END manual_prod_status
                                     ,CAST(completion_time AS DATE) mpt_complete_date
                                     ,ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY completion_time DESC,record_id DESC) rnk 
                                  FROM coverva_dmas.manual_prod_tracker_full_load) 
                              WHERE rnk = 1 AND manual_prod_status IS NOT NULL) mpt ON mpt.tracking_number = e.tracking_number AND e.event_date >= mpt.mpt_complete_date
                   LEFT JOIN (SELECT DISTINCT tracking_number, override_status,override_app_end_date,file_date 
                              FROM(SELECT tracking_number, CAST(CONCAT(REPLACE(LEFT(date(end_date),2),'00','20'),RIGHT(date(end_date),8)) AS DATE)  override_app_end_date
                                      ,CASE WHEN UPPER(current_state) = 'TRANSFERRED TO LDSS' THEN 'Transferred to LDSS'
                                            WHEN UPPER(current_state) = 'APPROVED' THEN 'Approved'
                                            WHEN UPPER(current_state) = 'DENIED' THEN 'Denied'
                                            WHEN UPPER(current_state) = 'WAITING FOR VERIFICATION DOCUMENTS' THEN 'Waiting for Verification Documents'
                                            WHEN UPPER(current_state) = 'WAITING INITIAL REVIEW' THEN 'Waiting Initial Review'
                                            ELSE INITCAP(current_state) END override_status
                                      ,CAST(f.file_date AS DATE) file_date
                                      ,ROW_NUMBER() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                   FROM coverva_dmas.application_override_full_load o 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                              WHERE rnk = 1 AND LENGTH(override_status) > 0) o ON o.tracking_number = e.tracking_number AND (e.event_date = o.file_date) -- OR inv.latest_inventory_date <= o.file_date)
)     
              SELECT DISTINCT tracking_number,event_date,current_state,latest_inventory_date,override_indicator 
                    ,CAST(CASE WHEN mpt_complete_date IS NOT NULL THEN mpt_complete_date 
                         WHEN override_app_end_date IS NOT NULL THEN override_app_end_date 
                         WHEN current_state = 'Transferred to LDSS' THEN ldss_end_date                          
                         WHEN current_state IN('Approved','Denied') THEN ad_complete_date 
                     ELSE NULL END AS DATE) AS app_end_date                    
              FROM curr   ;