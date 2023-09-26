CREATE OR REPLACE VIEW coverva_dmas.dmas_raw_application_event_vw
AS
WITH tlist AS(
SELECT dd.d_date event_date,tracking_number,prev_current_state,prev_end_date,prev_business_date
FROM public.d_dates dd
 JOIN (SELECT tracking_number,file_inventory_date,prev_current_state ,prev_end_date
                            FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date ,dmas_application_id) rnk 
                                   ,FIRST_VALUE(current_state) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) prev_current_state 
                                   ,FIRST_VALUE(application_processing_end_date) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) prev_end_date 
                                 FROM coverva_dmas.dmas_application da) 
                            WHERE rnk = 1 
      UNION 
                  SELECT DISTINCT tracking_number, file_date event_date,null ,null
                  FROM(SELECT tracking_number, CAST(f.file_date AS DATE) file_date 
                        ,RANK() OVER(PARTITION BY cm.tracking_number,f.file_date ORDER BY f.file_date,cm.cm044_data_id  ) rnk 
                       FROM coverva_dmas.cm044_data_full_load cm 
                        JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename)                        
                       WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application da WHERE da.tracking_number = cm.tracking_number ) 
                          AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application da WHERE da.tracking_number = cm.tracking_number ))
           WHERE rnk = 1 ) da on dd.d_date >= da.file_inventory_date AND dd.d_date <= current_date()
 LEFT JOIN(SELECT d_date,LAG(d_date) OVER(ORDER BY d_date) prev_business_date
      FROM PUBLIC.D_DATES
      WHERE project_id = 117
      AND business_day_flag = 'Y') ddprev ON dd.d_date = ddprev.d_date  
WHERE dd.project_id = 117   )
SELECT DISTINCT da.tracking_number, da.event_date 
              ,CASE WHEN am.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_metric 
              ,CASE WHEN pw.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_metric_pw 
              ,CASE WHEN p.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_ppit 
              ,CASE WHEN cmd.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm043     
              ,CASE WHEN cm.file_date = da.event_date AND cm.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm044   
              ,CASE WHEN cviu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cviu   
              ,CASE WHEN cpui.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cpui 
              ,CASE WHEN cpu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cpu, cpu.cpu_status, cpu.cpu_app_received_date,cpu.cpu_worker
              ,CASE WHEN mcpu.application_number IS NOT NULL THEN 'Y' ELSE 'N' END in_manual_cpu
              ,CASE WHEN mcviu.application_number IS NOT NULL THEN 'Y' ELSE 'N' END in_manual_cviu
              ,cm.cm044_status,cm.cm044_authorized_date,o.override_current_state 
              ,cviu.cviu_processing_status,cpui.cpui_processing_status, pw.pending_due_to_vcl pending_due_vcl_pw 
              ,am.pending_due_to_vcl pending_due_vcl_am,p.worker_id ppit_worker_id,cpui.cpui_worker,cviu.cviu_worker,am.worker_id,pw.worker pw_worker 
              ,CASE WHEN o.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_override 
              ,cm.cm044_worker,am.vcl_due_date_am, pw.vcl_due_date_pw, o.override_last_employee, o.override_app_end_date,cmd.processing_status,da.prev_current_state,da.prev_end_date              
              ,rcpu.running_cpu_status,rcpu.running_cpu_app_received_date
              ,apldss.cp_inv_action_taken,apldss.cp_inv_ldss_create_date,apldss.cp_inv_ldss_status_date,apldss.cp_inv_ldss_end_date,apldss.cp_inv_ldss_worker
              ,iarldss.cp_iar_action_taken,iarldss.cp_iar_ldss_created_on,iarldss.cp_iar_ldss_end_date,iarldss.cp_iar_ldss_worker              
              ,cpd.cp_inv_ad_disposition,cpd.cp_inv_ad_create_date,cpd.cp_inv_ad_status_date,cpd.cp_inv_ad_complete_date,cpd.cp_inv_ad_worker
              ,iard.cp_iar_ad_disposition,iard.cp_iar_ad_created_on,iard.cp_iar_ad_status_date,iard.cp_iar_ad_worker
              ,cpmi.cp_inv_pend_disposition,cpmi.cp_inv_pend_create_date,cpmi.cp_inv_pend_status_date,cpmi.cp_inv_pend_complete_date,cpmi.cp_inv_pend_worker                           
              ,iarmi.cp_iar_pend_disposition,iarmi.cp_iar_pend_created_on,iarmi.cp_iar_pend_status_date, iarmi.cp_iar_pend_worker
              ,mcpu.manual_cpu_status,mcpu.mcpu_activity_date, mcpu.mcpu_last_employee
              ,mcviu.manual_cviu_status,mcviu.mcviu_activity_date,mcviu.mcviu_last_employee
              ,mpt.manual_prod_status,mpt.mpt_orig_status,mpt.mpt_complete_date,mpt.mpt_last_employee,rcpu.running_cpu_worker,rcpu.file_date running_cpu_file_date
              ,mpt_vcl_due_date,cpmi.cp_vcl_due_date,iarmi.iar_vcl_due_date
              ,running_am_worker,running_ppit_worker,running_cviu_worker, running_cviu_status,running_cpui_worker,running_cpui_status
FROM  tlist da             
--am
             LEFT JOIN (SELECT tracking_number, worker_id, pending_due_to_vcl,vcl_due_date_am, file_date 
                        FROM(SELECT tracking_number, worker_id, pending_due_to_vcl,vcl_due_date vcl_due_date_am,CAST(f.file_date AS DATE) file_date 
                               ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number,CAST(f.file_date AS DATE) ORDER BY am.appmetric_data_id DESC) rnk
                             FROM coverva_dmas.app_metric_full_load am 
                              JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) )
                        WHERE rnk = 1) am ON da.tracking_number = am.tracking_number AND da.event_date = am.file_date 
--running am
             LEFT JOIN (SELECT tracking_number, running_am_worker,  file_date 
                        FROM(SELECT tracking_number, worker_id running_am_worker, CAST(f.file_date AS DATE) file_date 
                               ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,am.appmetric_data_id DESC) rnk
                             FROM coverva_dmas.app_metric_full_load am 
                              JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) )
                        WHERE rnk = 1) ram ON da.tracking_number = ram.tracking_number AND da.event_date >= ram.file_date
--pw                           
              LEFT JOIN (SELECT tracking_number, worker, pending_due_to_vcl,vcl_due_date_pw,file_date 
                         FROM(SELECT tracking_number, worker, pending_due_to_vcl,vcl_due_date vcl_due_date_pw,CAST(f.file_date AS DATE) file_date 
                                 ,ROW_NUMBER() OVER(PARTITION BY pw.tracking_number,CAST(f.file_date AS DATE) ORDER BY pw.appmetric_pw_data_id DESC) rnk
                               FROM coverva_dmas.app_metric_pw_full_load pw 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(pw.filename) = UPPER(f.filename))
                         WHERE rnk = 1  ) pw ON da.tracking_number = pw.tracking_number AND da.event_date = pw.file_date 
--ppit                           
              LEFT JOIN (SELECT tracking_number, worker_id, file_date 
                         FROM (SELECT tracking_number, worker_id,CAST(f.file_date AS DATE) file_date 
                                 ,ROW_NUMBER() OVER(PARTITION BY p.tracking_number,CAST(f.file_date AS DATE) ORDER BY p.ppit_data_id DESC) rnk
                               FROM coverva_dmas.ppit_data_full_load p 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(p.filename) = UPPER(f.filename))
                         WHERE rnk = 1) p ON da.tracking_number = p.tracking_number AND da.event_date = p.file_date 
--running ppit
             LEFT JOIN (SELECT tracking_number, running_ppit_worker, file_date 
                         FROM (SELECT tracking_number, worker_id running_ppit_worker,CAST(f.file_date AS DATE) file_date 
                                 ,ROW_NUMBER() OVER(PARTITION BY p.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,p.ppit_data_id DESC) rnk
                               FROM coverva_dmas.ppit_data_full_load p 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(p.filename) = UPPER(f.filename))
                         WHERE rnk = 1) rp ON da.tracking_number = rp.tracking_number AND da.event_date >= rp.file_date 
--cm043                           
              LEFT JOIN (SELECT tracking_number,processing_status,file_date 
                         FROM(SELECT tracking_number,processing_status,CAST(f.file_date AS DATE) file_date 
                                  ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number,CAST(f.file_date AS DATE) ORDER BY cmd.cm043_data_id DESC) rnk
                              FROM coverva_dmas.cm043_data_full_load cmd 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)) 
                         WHERE rnk = 1) cmd ON da.tracking_number = cmd.tracking_number AND da.event_date = cmd.file_date 
--cm044                           
              LEFT JOIN (SELECT DISTINCT tracking_number,cm044_status,cm044_authorized_date,file_date,cm044_worker 
                         FROM(SELECT tracking_number,status cm044_status,authorized_date cm044_authorized_date,authorized_worker_id cm044_worker, CAST(f.file_date AS DATE) file_date 
                                ,ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY  CAST(f.file_date AS DATE) DESC,UPPER(LEFT(cm.status,1)),cm.cm044_data_id DESC) rnk 
                              FROM coverva_dmas.cm044_data_full_load cm 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number AND da.event_date > cm.file_date      
--cviu                         
              LEFT JOIN (SELECT tracking_number, cviu_worker, cviu_processing_status,  file_date 
                         FROM(SELECT tracking_number,assigned_to cviu_worker,processing_status cviu_processing_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cviu.tracking_number,CAST(f.file_date AS DATE) ORDER BY cviu.cviu_data_id DESC) rnk 
                              FROM coverva_dmas.cviu_data_full_load cviu 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)) 
                         WHERE rnk = 1) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date
--running cviu                         
              LEFT JOIN (SELECT tracking_number, running_cviu_worker, running_cviu_status, file_date 
                         FROM(SELECT tracking_number,assigned_to running_cviu_worker,processing_status running_cviu_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cviu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC, cviu.cviu_data_id DESC) rnk 
                              FROM coverva_dmas.cviu_data_full_load cviu 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)) 
                         WHERE rnk = 1) rcviu ON da.tracking_number = rcviu.tracking_number AND da.event_date >= rcviu.file_date                          
--cpui                           
              LEFT JOIN (SELECT tracking_number,cpui_worker,cpui_processing_status, file_date 
                         FROM(SELECT tracking_number,assigned_to cpui_worker,processing_status cpui_processing_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cpui.tracking_number,CAST(f.file_date AS DATE) ORDER BY cpui.cpu_incarcerated_id DESC) rnk 
                              FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename))
                         WHERE rnk = 1) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date
--running cpui                           
              LEFT JOIN (SELECT tracking_number,running_cpui_worker,running_cpui_status, file_date 
                         FROM(SELECT tracking_number,assigned_to running_cpui_worker,processing_status running_cpui_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cpui.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,cpui.cpu_incarcerated_id DESC) rnk 
                              FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename))
                         WHERE rnk = 1) rcpui ON da.tracking_number = rcpui.tracking_number AND da.event_date >= rcpui.file_date                         
--cpu                           
              LEFT JOIN (SELECT tracking_number,cpu_worker,cpu_status, cpu_app_received_date,file_date 
                         FROM(SELECT tracking_number,assigned_to cpu_worker,status cpu_status,app_received_date cpu_app_received_date, CAST(f.file_date AS DATE) file_date 
                                 ,ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY cpu_data_id DESC) rnk 
                              FROM coverva_dmas.cpu_data_full_load cpu 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1) cpu ON da.tracking_number = cpu.tracking_number AND da.event_date = cpu.file_date            
--running cpu                         
              LEFT JOIN (SELECT tracking_number,running_cpu_status,running_cpu_app_received_date,running_cpu_worker,file_date 
                         FROM(SELECT tracking_number,status running_cpu_status,app_received_date running_cpu_app_received_date, assigned_to running_cpu_worker, CAST(f.file_date AS DATE) file_date 
                                 ,RANK() OVER(PARTITION BY cpu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,UPPER(f.filename),cpu.cpu_data_id DESC) rnk 
                              FROM coverva_dmas.cpu_data_full_load cpu 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1) rcpu ON da.tracking_number = rcpu.tracking_number AND da.event_date >= rcpu.file_date
--app override                         
              LEFT JOIN (SELECT DISTINCT tracking_number, override_current_state,override_last_employee,override_app_end_date,file_date 
                         FROM(SELECT tracking_number,current_state override_current_state, last_employee override_last_employee
                                ,CAST(CONCAT(REPLACE(LEFT(date(end_date),2),'00','20'),RIGHT(date(end_date),8)) AS DATE) override_app_end_date
                                ,CAST(f.file_date AS DATE) file_date  
                                ,RANK() OVER(PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                              FROM coverva_dmas.application_override_full_load o 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1 AND override_current_state IS NOT NULL) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date 
--inv ldss                         
              LEFT JOIN(SELECT tracking_number,cp_inv_ldss_end_date,sr_create_date cp_inv_ldss_create_date,sr_status_date cp_inv_ldss_status_date ,staff_name cp_inv_ldss_worker,'Transferred to LDSS' cp_inv_action_taken
                         FROM(SELECT tracking_number, complete_task_date cp_inv_ldss_end_date,sr_create_date ,sr_status_date,INITCAP(completed_by_name) staff_name
                               ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY complete_task_date,sr_id) rn 
                              FROM coverva_dmas.cp_application_inventory cp 
                              WHERE action_taken = 'TRANSFERRED_TO_LDSS' ) 
                         WHERE rn =1) apldss ON apldss.tracking_number = da.tracking_number  AND da.event_date >= CAST(COALESCE(apldss.cp_inv_ldss_end_date,apldss.cp_inv_ldss_status_date) AS DATE)  
--iar ldss                         
              LEFT JOIN(SELECT tracking_number,cp_iar_ldss_end_date,created_on cp_iar_ldss_created_on,'Transferred to LDSS' cp_iar_action_taken,cp_iar_ldss_worker
                         FROM(SELECT tracking_number, status_date cp_iar_ldss_end_date,created_on,completed_by_name cp_iar_ldss_worker 
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY status_date,task_id) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                              WHERE action_taken = 'TRANSFERRED_TO_LDSS'  ) iar 
                         WHERE rn = 1 ) iarldss ON iarldss.tracking_number = da.tracking_number AND da.event_date >= CAST(COALESCE(iarldss.cp_iar_ldss_end_date,iarldss.cp_iar_ldss_created_on) AS DATE)
--inv appr denied                         
               LEFT JOIN(SELECT tracking_number,disposition cp_inv_ad_disposition,complete_task_date cp_inv_ad_complete_date,sr_create_date cp_inv_ad_create_date,sr_status_date cp_inv_ad_status_date,staff_name cp_inv_ad_worker
                         FROM(SELECT tracking_number, disposition,complete_task_date,sr_create_date,sr_status_date, INITCAP(completed_by_name) staff_name 
                               ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,3),complete_task_date,sr_id) rn 
                              FROM coverva_dmas.cp_application_inventory cp 
                              WHERE disposition NOT IN('PENDING_MI') ) 
                         WHERE rn =1) cpd ON cpd.tracking_number = da.tracking_number  AND da.event_date >= CAST(COALESCE(cpd.cp_inv_ad_complete_date,cpd.cp_inv_ad_status_date) AS DATE)
--inv pend                         
               LEFT JOIN(SELECT tracking_number,cp_inv_pend_disposition,complete_task_date cp_inv_pend_complete_date,sr_create_date cp_inv_pend_create_date,sr_status_date cp_inv_pend_status_date,cp_inv_pend_worker,cp_vcl_due_date
                         FROM(SELECT tracking_number, disposition cp_inv_pend_disposition,complete_task_date,sr_create_date ,sr_status_date,INITCAP(completed_by_name) cp_inv_pend_worker,vcl_due_date cp_vcl_due_date
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY complete_task_date DESC,sr_id DESC) rn 
                              FROM coverva_dmas.cp_application_inventory cp ) 
                         WHERE rn =1 AND cp_inv_pend_disposition = 'PENDING_MI') cpmi ON cpmi.tracking_number = da.tracking_number AND da.event_date >= CAST(COALESCE(cpmi.cp_inv_pend_complete_date,cpmi.cp_inv_pend_status_date) AS DATE) 
--iar appr denied                         
               LEFT JOIN(SELECT tracking_number,disposition cp_iar_ad_disposition,status_date cp_iar_ad_status_date,created_on cp_iar_ad_created_on,cp_iar_ad_worker
                         FROM(SELECT tracking_number, disposition,status_date,created_on,completed_by_name cp_iar_ad_worker 
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,3),status_date,task_id) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                              WHERE disposition NOT IN('PENDING_MI') ) cp 
                         WHERE rn = 1 ) iard ON iard.tracking_number = da.tracking_number AND da.event_date >= CAST(COALESCE(iard.cp_iar_ad_status_date,iard.cp_iar_ad_created_on) AS DATE)
--iar pend                         
               LEFT JOIN(SELECT tracking_number,cp_iar_pend_disposition,status_date cp_iar_pend_status_date,created_on cp_iar_pend_created_on,cp_iar_pend_worker,iar_vcl_due_date
                         FROM(SELECT cp.tracking_number, cp.disposition cp_iar_pend_disposition,cp.created_on,cp.status_date,cp.completed_by_name cp_iar_pend_worker,ai.vcl_due_date iar_vcl_due_date                      
                                ,ROW_NUMBER() OVER (PARTITION BY cp.tracking_number ORDER BY cp.status_date,cp.task_id) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                                LEFT JOIN coverva_dmas.cp_application_inventory ai ON cp.task_id = ai.complete_task_id) cp  
                         WHERE rn = 1 AND cp_iar_pend_disposition = 'PENDING_MI') iarmi ON iarmi.tracking_number = da.tracking_number AND da.event_date >= CAST(iarmi.cp_iar_pend_status_date AS DATE)                         
--manual cpu                         
               LEFT JOIN (SELECT DISTINCT application_number,manual_cpu_status,mcpu_activity_date,mcpu_last_employee
                                    ,CASE WHEN manual_cpu_status = 'Transferred to LDSS' THEN mcpu_activity_date ELSE NULL END mcpu_ldss_date
                                    ,CASE WHEN manual_cpu_status IN('Approved','Denied') THEN mcpu_activity_date ELSE NULL END mcpu_complete_date
                          FROM(SELECT application_number
                                     ,CASE WHEN sent_to_ldss = '1' THEN 'Transferred to LDSS'
                                           WHEN approved = '1' THEN 'Approved' 
                                           WHEN denied = '1' THEN 'Denied'
                                           WHEN vcl = '1' THEN 'Waiting for Verification Documents'
                                       ELSE NULL END manual_cpu_status
                                     ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcpu_activity_date
                                     ,CASE WHEN sent_to_ldss = '1' OR approved = '1' OR denied = '1' OR vcl = '1' OR noa = '1' THEN NULL ELSE ew END mcpu_last_employee
                                     ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC,record_id DESC) rnk 
                                FROM coverva_dmas.manual_cpu_tracking) 
                           WHERE rnk = 1) mcpu ON mcpu.application_number = da.tracking_number AND da.event_date >= mcpu.mcpu_activity_date 
--manual cviu                           
                LEFT JOIN (SELECT DISTINCT application_number,manual_cviu_status,mcviu_activity_date,mcviu_last_employee  
                             ,CASE WHEN manual_cviu_status = 'Transferred to LDSS' THEN mcviu_activity_date ELSE NULL END mcviu_ldss_date
                                    ,CASE WHEN manual_cviu_status IN('Approved','Denied') THEN mcviu_activity_date ELSE NULL END mcviu_complete_date
                           FROM(SELECT application_number, 
                                   CASE WHEN LEFT(UPPER(sent_to_ldss_1yes_0no),1) IN('Y','1') OR UPPER(status) LIKE 'APPROVED%' 
                                     OR UPPER(status) LIKE 'DENIED%' OR LEFT(UPPER(vcl_1yes_0no),1) IN('Y','1') OR LEFT(UPPER(manual_vcl_1yes_0no),1) IN('Y','1') THEN name_ew ELSE NULL END mcviu_last_employee,
                                   CASE WHEN LEFT(UPPER(sent_to_ldss_1yes_0no),1) IN('Y','1') THEN 'Transferred to LDSS' 
                                        WHEN UPPER(status) LIKE 'APPROVED%' THEN 'Approved'
                                        WHEN UPPER(status) LIKE 'DENIED%' THEN 'Denied'                                          
                                        WHEN LEFT(UPPER(vcl_1yes_0no),1) IN('Y','1') OR LEFT(UPPER(manual_vcl_1yes_0no),1) IN('Y','1') THEN 'Waiting for Verification Documents'
                                     ELSE NULL END manual_cviu_status
                                   ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcviu_activity_date
                                   ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC,record_id DESC) rnk 
                                FROM coverva_dmas.manual_cviu_tracking) 
                           WHERE rnk = 1) mcviu ON mcviu.application_number = da.tracking_number AND da.event_date >= mcviu.mcviu_activity_date 
--mpt                           
                LEFT JOIN (SELECT DISTINCT tracking_number,manual_prod_status,mpt_orig_status,mpt_complete_date ,mpt_last_employee ,mpt_vcl_due_date, file_date                              
                           FROM(SELECT tracking_number, name mpt_last_employee,status mpt_orig_status,
                                  CASE WHEN UPPER(status) = 'TRANSFERRED TO LDSS' THEN 'Transferred to LDSS' 
                                       WHEN UPPER(status) = 'APPROVED' THEN 'Approved'
                                       WHEN UPPER(status) = 'DENIED' THEN 'Denied'                                          
                                       WHEN UPPER(status) = 'PENDING, EMERGENCY SERVICES' THEN 'Complete - Needs Research'
                                       WHEN UPPER(status) LIKE 'PENDING%VCL%' THEN 'Waiting for Verification Documents'
                                       WHEN UPPER(status) = 'NONE OF THE ABOVE' THEN 'Waiting Initial Review'
                                    ELSE NULL END manual_prod_status
                                  ,CAST(completion_time AS DATE) mpt_complete_date
                                  ,CAST(f.file_date AS DATE) file_date
                                  ,vcl_due_date mpt_vcl_due_date
                                  ,ROW_NUMBER() OVER(PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY completion_time DESC,record_id DESC) rnk                                   
                              FROM coverva_dmas.manual_prod_tracker_full_load mpt
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(mpt.filename) = UPPER(f.filename) )  
                           WHERE rnk = 1 AND manual_prod_status IS NOT NULL) mpt ON mpt.tracking_number = da.tracking_number AND da.prev_business_date = mpt.file_date ;