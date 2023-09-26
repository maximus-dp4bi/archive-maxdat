CREATE OR REPLACE VIEW coverva_dmas.dmas_raw_application_v2_event_vw
AS
WITH tlist AS(
SELECT dd.d_date event_date,tracking_number,prev_current_state,prev_end_date,prev_business_date,ddate_last_sat,day_of_week
FROM public.d_dates dd
 JOIN (SELECT tracking_number,file_inventory_date,prev_current_state ,prev_end_date
                            FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date ,dmas_application_id) rnk 
                                   ,FIRST_VALUE(current_state) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) prev_current_state 
                                   ,FIRST_VALUE(application_processing_end_date) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) prev_end_date 
                                 FROM coverva_dmas.dmas_application_v2_inventory da) 
                            WHERE rnk = 1 
      UNION 
                  SELECT DISTINCT tracking_number, file_date event_date,null ,null
                  FROM(SELECT tracking_number, CAST(f.file_date AS DATE) file_date 
                        ,RANK() OVER(PARTITION BY cm.tracking_number,f.file_date ORDER BY f.file_date,cm.cm044_data_id  ) rnk 
                       FROM coverva_dmas.cm044_data_full_load cm 
                        JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename)                        
                       WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_inventory da WHERE da.tracking_number = cm.tracking_number ) 
                          AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v2_application da WHERE da.tracking_number = cm.tracking_number ))
           WHERE rnk = 1 ) da on dd.d_date >= da.file_inventory_date AND dd.d_date <= current_date()
 LEFT JOIN(SELECT d_date,LAG(d_date) OVER(ORDER BY d_date) prev_business_date,NEXT_DAY(d_date - 7, 'sat') ddate_last_sat
      FROM PUBLIC.D_DATES
      WHERE project_id = 117
      AND business_day_flag = 'Y') ddprev ON dd.d_date = ddprev.d_date  
WHERE dd.project_id = 117   ),
raw_event AS(SELECT DISTINCT da.tracking_number, da.event_date 
              ,CASE WHEN am.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_metric 
              ,CASE WHEN am.tracking_number IS NOT NULL AND UPPER(am.ma_pg_indicator) IN('YES','Y') THEN 'Y' ELSE 'N' END in_app_metric_pw 
              ,CASE WHEN p.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_ppit 
              ,CASE WHEN cmd.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm043     
              ,CASE WHEN GREATEST(da.prev_business_date,da.event_date-1) = cm.file_date AND cm.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm044   
              ,CASE WHEN cviu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cviu   
              ,CASE WHEN cpui.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cpui 
              ,CASE WHEN cpu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cpu, cpu.cpu_status, cpu.cpu_app_received_date,cpu.cpu_worker
              ,CASE WHEN mcpu.application_number IS NOT NULL THEN 'Y' ELSE 'N' END in_manual_cpu
              ,CASE WHEN mcviu.application_number IS NOT NULL THEN 'Y' ELSE 'N' END in_manual_cviu
              ,cm.cm044_status,cm.cm044_authorized_date,o.override_current_state 
              ,cviu.cviu_processing_status,cpui.cpui_processing_status, am.pending_due_vcl_pw 
              ,am.pending_due_to_vcl pending_due_vcl_am,p.worker_id ppit_worker_id,cpui.cpui_worker,cviu.cviu_worker,am.worker_id,am.pw_worker 
              ,CASE WHEN o.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_override 
              ,cm.cm044_worker,am.vcl_due_date_am, am.vcl_due_date_pw, o.override_last_employee, o.override_app_end_date,cmd.processing_status,da.prev_current_state,da.prev_end_date              
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
              ,CASE WHEN ram.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_am
              ,CASE WHEN rp.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_ppit
              ,CASE WHEN ram.tracking_number IS NOT NULL AND UPPER(ram.ma_pg_indicator) IN('YES','Y') THEN 'Y' ELSE 'N' END in_running_pw
              ,CASE WHEN rcmd.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_cm043
              ,CASE WHEN rcviu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_cviu
              ,CASE WHEN rcpui.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_cpui
              ,CASE WHEN rcpu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_cpu
             -- ,mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee,mio_vcl_due_date,mio_term_state
             ,COALESCE(am_wid_in_ldap,'N') am_wid_in_ldap,COALESCE(running_am_wid_in_ldap,'N') running_am_wid_in_ldap
             ,COALESCE(ppit_wid_in_ldap,'N') ppit_wid_in_ldap,COALESCE(running_ppit_wid_in_ldap,'N') running_ppit_wid_in_ldap
             ,COALESCE(cviu_wid_in_ldap,'N') cviu_wid_in_ldap,COALESCE(running_cviu_wid_in_ldap,'N') running_cviu_wid_in_ldap
             ,COALESCE(cpui_wid_in_ldap,'N') cpui_wid_in_ldap,COALESCE(running_cpui_wid_in_ldap,'N') running_cpui_wid_in_ldap
             ,p.ppit_vcl_due_date,COALESCE(am.case_type,cm043_case_type,'Application') case_type,am.sd_stage,am.am_processing_status,ram.running_am_processing_status
             ,COALESCE(running_case_type,running_cm043_case_type,'Application') running_case_type
FROM  tlist da             
--am
             LEFT JOIN (SELECT tracking_number, worker_id, pending_due_to_vcl,vcl_due_date_am, file_date,am_wid_in_ldap,vcl_due_date_pw,pw_worker,pending_due_vcl_pw,
                               ma_pg_indicator,sd_stage,case_type,am_processing_status,filename_prefix
                        FROM(SELECT tracking_number, worker_id
                               ,CASE WHEN UPPER(pending_due_to_vcl) IN('YES','Y') THEN 'Y'
                                     WHEN UPPER(pending_due_to_vcl) IN('NO','N') THEN 'N' ELSE NULL END pending_due_to_vcl
                               ,vcl_due_date vcl_due_date_am,CAST(f.file_date AS DATE) file_date,ma_pg_indicator
                               ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number,CAST(f.file_date AS DATE) ORDER BY COALESCE(am.appmetric_data_id,am.renewal_data_id) DESC) rnk
                               ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END am_wid_in_ldap
                               ,CASE WHEN UPPER(am.ma_pg_indicator) IN('YES','Y') THEN vcl_due_date ELSE NULL END vcl_due_date_pw
                               ,CASE WHEN UPPER(am.ma_pg_indicator) IN('YES','Y') THEN worker_id ELSE NULL END pw_worker
                               ,CASE WHEN UPPER(am.ma_pg_indicator) IN('YES','Y') THEN 
                                  CASE WHEN UPPER(pending_due_to_vcl) IN('YES','Y') THEN 'Y'
                                       WHEN UPPER(pending_due_to_vcl) IN('NO','N') THEN 'N' ELSE NULL END
                                 ELSE NULL END pending_due_vcl_pw
                                ,stage sd_stage
                                ,application_type case_type
                                ,application_status am_processing_status
                                ,f.filename_prefix
                             FROM coverva_dmas.dmas_app_metric_and_renewal_v2_vw am 
                              JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                              LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON am.worker_id = ldap.ldap)
                        WHERE rnk = 1) am ON da.tracking_number = am.tracking_number 
                          AND ( (filename_prefix != 'RENEWALS' AND CASE WHEN day_of_week IN('0','6') THEN da.event_date ELSE GREATEST(da.prev_business_date,da.ddate_last_sat) END = am.file_date) 
                             OR (filename_prefix = 'RENEWALS' AND da.event_date = am.file_date))
--running am
             LEFT JOIN (SELECT tracking_number, running_am_worker, file_date,running_am_wid_in_ldap,vcl_due_date_pw,pw_worker,pending_due_vcl_pw,ma_pg_indicator,sd_stage,case_type running_case_type ,running_am_processing_status
                        FROM(SELECT tracking_number, worker_id running_am_worker, CAST(f.file_date AS DATE) file_date,ma_pg_indicator
                               ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,COALESCE(am.appmetric_data_id,am.renewal_data_id) DESC) rnk
                               ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_am_wid_in_ldap
                               ,CASE WHEN UPPER(am.ma_pg_indicator) IN('YES','Y') THEN vcl_due_date ELSE NULL END vcl_due_date_pw
                               ,CASE WHEN UPPER(am.ma_pg_indicator) IN('YES','Y') THEN worker_id ELSE NULL END pw_worker
                               ,CASE WHEN UPPER(am.ma_pg_indicator) IN('YES','Y') THEN 
                                   CASE WHEN UPPER(pending_due_to_vcl) IN('YES','Y') THEN 'Y'
                                        WHEN UPPER(pending_due_to_vcl) IN('NO','N') THEN 'N' ELSE NULL END
                                   ELSE NULL END pending_due_vcl_pw
                                ,stage sd_stage
                                ,application_type case_type 
                                ,application_status running_am_processing_status
                             FROM coverva_dmas.dmas_app_metric_and_renewal_v2_vw am 
                              JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                              LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON am.worker_id = ldap.ldap
                             UNION ALL
                             SELECT tracking_number, worker_id running_am_worker, CAST(f.file_date AS DATE) file_date,'NO' ma_pg_indicator
                               ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,am.appmetric_data_id DESC) rnk
                               ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_am_wid_in_ldap
                               ,null vcl_due_date_pw
                               ,null pw_worker
                               ,null pending_due_vcl_pw
                               ,stage sd_stage
                               ,'Application' case_type 
                               ,application_status running_am_processing_status
                              FROM coverva_dmas.app_metric_full_load am 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                                LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON am.worker_id = ldap.ldap
                               WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_v2_full_load amv WHERE amv.tracking_number = am.tracking_number)
                               AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load amv WHERE amv.tracking_number = am.tracking_number)
                              UNION ALL
                              SELECT tracking_number, null running_am_worker, CAST(f.file_date AS DATE) file_date,'YES' ma_pg_indicator
                                 ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,am.appmetric_pw_data_id DESC) rnk
                                 ,'N' running_am_wid_in_ldap
                                 ,vcl_due_date vcl_due_date_pw
                                 ,worker pw_worker
                                 ,pending_due_to_vcl pending_due_vcl_pw
                                 ,stage sd_stage
                                 ,'Application' case_type 
                                 ,null running_am_processing_status
                               FROM coverva_dmas.app_metric_pw_full_load am 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)                               
                               WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_v2_full_load amv WHERE amv.tracking_number = am.tracking_number)
                               AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amv WHERE amv.tracking_number = am.tracking_number)
                            )
                        WHERE rnk = 1) ram ON da.tracking_number = ram.tracking_number AND da.event_date >= ram.file_date                      
--ppit                           
              LEFT JOIN (SELECT tracking_number, worker_id, file_date,ppit_wid_in_ldap,ppit_vcl_due_date 
                         FROM (SELECT tracking_number, worker_id,CAST(f.file_date AS DATE) file_date 
                                 ,ROW_NUMBER() OVER(PARTITION BY p.tracking_number,CAST(f.file_date AS DATE) ORDER BY p.ppit_data_id DESC) rnk
                                 ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END ppit_wid_in_ldap
                                 ,vcl_due_date ppit_vcl_due_date
                               FROM coverva_dmas.ppit_data_full_load p 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(p.filename) = UPPER(f.filename)
                                LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON p.worker_id = ldap.ldap)
                         WHERE rnk = 1) p ON da.tracking_number = p.tracking_number AND da.event_date = p.file_date 
--running ppit
             LEFT JOIN (SELECT tracking_number, running_ppit_worker, file_date,running_ppit_wid_in_ldap 
                         FROM (SELECT tracking_number, worker_id running_ppit_worker,CAST(f.file_date AS DATE) file_date 
                                 ,ROW_NUMBER() OVER(PARTITION BY p.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,p.ppit_data_id DESC) rnk
                                 ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_ppit_wid_in_ldap                                 
                               FROM coverva_dmas.ppit_data_full_load p 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(p.filename) = UPPER(f.filename)
                                LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON p.worker_id = ldap.ldap)
                         WHERE rnk = 1) rp ON da.tracking_number = rp.tracking_number AND da.event_date >= rp.file_date 
--cm043                           
              LEFT JOIN (SELECT tracking_number,processing_status,file_date,case_type cm043_case_type
                         FROM(SELECT tracking_number,application_type as case_type,processing_status,CAST(f.file_date AS DATE) file_date 
                                  ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number,CAST(f.file_date AS DATE) ORDER BY cmd.cm043_data_id DESC) rnk
                              FROM coverva_dmas.cm043_data_full_load cmd 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)) 
                         WHERE rnk = 1) cmd ON da.tracking_number = cmd.tracking_number AND CASE WHEN day_of_week IN('0','6') THEN da.event_date ELSE GREATEST(da.prev_business_date,da.ddate_last_sat) END = cmd.file_date --da.event_date = cmd.file_date 
--running cm043
              LEFT JOIN (SELECT tracking_number,processing_status,file_date,case_type running_cm043_case_type 
                         FROM(SELECT tracking_number,application_type as case_type,processing_status,CAST(f.file_date AS DATE) file_date 
                                  ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,cmd.cm043_data_id DESC) rnk
                              FROM coverva_dmas.cm043_data_full_load cmd 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)) 
                         WHERE rnk = 1) rcmd ON da.tracking_number = rcmd.tracking_number AND da.event_date > rcmd.file_date
--cm044                           
              LEFT JOIN (SELECT DISTINCT tracking_number,cm044_status,cm044_authorized_date,file_date,cm044_worker 
                         FROM(SELECT tracking_number,status cm044_status,authorized_date cm044_authorized_date,authorized_worker_id cm044_worker, CAST(f.file_date AS DATE) file_date 
                                ,ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY  CAST(f.file_date AS DATE) DESC,SUBSTR(status,1,1),cm.cm044_data_id DESC) rnk 
                              FROM coverva_dmas.cm044_data_full_load cm 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) 
                              WHERE status IN('Approved','Denied') ) 
                         WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number AND da.event_date > cm.file_date      
--cviu                         
              LEFT JOIN (SELECT tracking_number, cviu_worker, cviu_processing_status, file_date, cviu_wid_in_ldap
                         FROM(SELECT tracking_number,assigned_to cviu_worker,processing_status cviu_processing_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cviu.tracking_number,CAST(f.file_date AS DATE) ORDER BY cviu.cviu_data_id DESC) rnk 
                                ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END cviu_wid_in_ldap
                              FROM coverva_dmas.cviu_data_full_load cviu 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)
                               LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON cviu.assigned_to = ldap.ldap) 
                         WHERE rnk = 1) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date
--running cviu                         
              LEFT JOIN (SELECT tracking_number, running_cviu_worker, running_cviu_status, file_date,running_cviu_wid_in_ldap 
                         FROM(SELECT tracking_number,assigned_to running_cviu_worker,processing_status running_cviu_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cviu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC, cviu.cviu_data_id DESC) rnk 
                                ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_cviu_wid_in_ldap
                              FROM coverva_dmas.cviu_data_full_load cviu 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)
                               LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON cviu.assigned_to = ldap.ldap) 
                         WHERE rnk = 1) rcviu ON da.tracking_number = rcviu.tracking_number AND da.event_date >= rcviu.file_date                          
--cpui                           
              LEFT JOIN (SELECT tracking_number,cpui_worker,cpui_processing_status, file_date,cpui_wid_in_ldap 
                         FROM(SELECT tracking_number,assigned_to cpui_worker,processing_status cpui_processing_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cpui.tracking_number,CAST(f.file_date AS DATE) ORDER BY cpui.cpu_incarcerated_id DESC) rnk 
                                ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END cpui_wid_in_ldap
                              FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename)
                                 LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON cpui.assigned_to = ldap.ldap)
                         WHERE rnk = 1) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date
--running cpui                           
              LEFT JOIN (SELECT tracking_number,running_cpui_worker,running_cpui_status, file_date,running_cpui_wid_in_ldap 
                         FROM(SELECT tracking_number,assigned_to running_cpui_worker,processing_status running_cpui_status, CAST(f.file_date AS DATE) file_date
                                ,ROW_NUMBER() OVER(PARTITION BY cpui.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,cpui.cpu_incarcerated_id DESC) rnk 
                                ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_cpui_wid_in_ldap
                              FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                 JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename)
                                 LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON cpui.assigned_to = ldap.ldap)
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
                         FROM(SELECT tracking_number,
                                   CASE WHEN UPPER(current_state) = 'APPROVED' THEN 'Approved'
                                        WHEN UPPER(current_state) = 'DENIED' THEN 'Denied'
                                        WHEN UPPER(current_state) LIKE 'WAITING%REVIEW' THEN 'Waiting Initial Review'
                                        WHEN UPPER(current_state) LIKE 'WAITING%DOC%' THEN 'Waiting for Verification Documents'
                                    ELSE current_state END override_current_state
                                ,last_employee override_last_employee
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
                                     ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM CAST('01/01/2021' as date))) AS DATE) mcpu_activity_date
                                     ,CASE WHEN sent_to_ldss = '1' OR approved = '1' OR denied = '1' OR vcl = '1' OR noa = '1' THEN NULL ELSE ew END mcpu_last_employee
                                     ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM CAST('01/01/2021' as date))) AS DATE) DESC,record_id DESC) rnk 
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
                                   ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM CAST('01/01/2021' as date))) AS DATE) mcviu_activity_date
                                   ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM CAST('01/01/2021' as date))) AS DATE) DESC,record_id DESC) rnk 
                                FROM coverva_dmas.manual_cviu_tracking) 
                           WHERE rnk = 1) mcviu ON mcviu.application_number = da.tracking_number AND da.event_date >= mcviu.mcviu_activity_date 
--mpt                           
                LEFT JOIN (SELECT DISTINCT tracking_number,manual_prod_status,mpt_orig_status,mpt_complete_date ,mpt_last_employee ,mpt_vcl_due_date, file_date,rnk_latest                              
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
                                  ,ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,completion_time DESC,record_id DESC) rnk_latest
                              FROM coverva_dmas.manual_prod_tracker_full_load mpt
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(mpt.filename) = UPPER(f.filename) )  
                           WHERE rnk = 1 AND manual_prod_status IS NOT NULL) mpt ON mpt.tracking_number = da.tracking_number AND (da.prev_business_date = mpt.file_date OR (da.event_date > mpt.file_date AND mpt.rnk_latest =1))
),
raw_event_fn AS(
SELECT raw_event.*,
  CASE WHEN ((in_ppit = 'N' AND in_app_metric = 'N' AND in_app_metric_pw = 'N' AND in_cm043 = 'N' AND in_cviu = 'N' AND in_cpui = 'N') 
                    AND (COALESCE(in_running_ppit,'N') = 'N' AND COALESCE(in_running_am,'N') = 'N' AND COALESCE(in_running_pw,'N') = 'N' 
                     AND COALESCE(in_running_cviu,'N') = 'N' AND COALESCE(in_running_cpui,'N') = 'N')
                    AND (in_cpu = 'Y' AND COALESCE(cpu_status,'X') != 'Submitted' ) )
         OR (( (in_app_metric = 'Y' AND (worker_id IS NULL OR REGEXP_INSTR(worker_id, '900') > 0) ) OR (in_ppit = 'Y' AND (ppit_worker_id IS NOT NULL AND REGEXP_INSTR(ppit_worker_id, '900') > 0))  )
                   OR  (in_app_metric = 'N' AND in_ppit = 'N' AND ( (in_cviu = 'Y' AND COALESCE(cviu_processing_status,'X') != 'Submitted') OR (in_cpui = 'Y' AND COALESCE(cpui_processing_status,'X') != 'Submitted') ) )
                   OR (in_cm043 = 'Y' AND UPPER(processing_status) = 'NEW') ) THEN 'Y' ELSE 'N' END app_pending
FROM raw_event)
SELECT raw_event_fn.*,
  CASE WHEN app_pending = 'Y' THEN mio.mio_prod_status ELSE miocmpl.mio_term_state END mio_prod_status,
  CASE WHEN app_pending = 'Y' THEN mio.mio_orig_status ELSE miocmpl.mio_term_orig_status END mio_orig_status,
  CASE WHEN app_pending = 'Y' THEN mio.mio_complete_date ELSE miocmpl.mio_term_complete_date END mio_complete_date,
  CASE WHEN app_pending = 'Y' THEN mio.mio_last_employee ELSE miocmpl.mio_term_last_employee END mio_last_employee,
  CASE WHEN app_pending = 'Y' THEN mio.mio_vcl_due_date ELSE miocmpl.mio_term_vcl_due_date END mio_vcl_due_date,
  miocmpl.mio_term_state
FROM raw_event_fn
--mio pending                         
LEFT JOIN (SELECT  tracking_number,mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee ,mio_vcl_due_date,mio_update_date--,mio_term_state
                           FROM(SELECT case_number tracking_number, ldap_id mio_last_employee,task_status mio_orig_status
                                  ,mio_current_state mio_prod_status
                                  ,CAST(disposition_date AS DATE) mio_complete_date  
                                  ,CAST(updated AS DATE) mio_update_date
                                  ,vcl_due mio_vcl_due_date
                                  ,mio_term_state     
                              FROM coverva_mio.mio_inventory_full_load_vw mio
                              WHERE status_rank = 1) ) mio ON mio.tracking_number = raw_event_fn.tracking_number AND raw_event_fn.event_date >= mio.mio_update_date
--mio complete                              
LEFT JOIN (SELECT case_number tracking_number, ldap_id mio_term_last_employee,task_status mio_term_orig_status                                 
                                  ,CAST(disposition_date AS DATE) mio_term_complete_date  
                                  ,CAST(updated AS DATE) mio_term_update_date
                                  ,vcl_due mio_term_vcl_due_date
                                  ,mio_term_state     
                              FROM coverva_mio.mio_inventory_full_load_vw mio
                              WHERE latest_dispo_rank = 1) miocmpl ON miocmpl.tracking_number = raw_event_fn.tracking_number AND raw_event_fn.event_date >= miocmpl.mio_term_update_date; 
                              
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
                         WHEN e.cp_inv_ad_disposition IN('DENIED','AUTO_DENIED') OR e.cp_iar_ad_disposition IN('DENIED','AUTO_DENIED') 
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
 

                              