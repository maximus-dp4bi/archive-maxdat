CREATE OR REPLACE VIEW coverva_dmas.dmas_raw_application_v3_event_vw
AS
WITH tlist AS(
SELECT dd.d_date event_date,tracking_number,case_type,prev_case_type,prev_business_date,ddate_last_sat,day_of_week
FROM public.d_dates dd
 JOIN (SELECT tracking_number,file_inventory_date,case_type,prev_case_type
                            FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date ,dmas_application_id) rnk                              
                                   ,COALESCE(case_type,FIRST_VALUE(case_type) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) prev_case_type                                   
                                 FROM coverva_dmas.dmas_application_v3_inventory da) 
                            WHERE rnk = 1 )  da on dd.d_date >= da.file_inventory_date AND dd.d_date <= current_date()     
 LEFT JOIN(SELECT d_date,LAG(d_date) OVER(ORDER BY d_date) prev_business_date,NEXT_DAY(d_date - 7, 'sat') ddate_last_sat
           FROM PUBLIC.D_DATES
           WHERE project_id = 117
           AND business_day_flag = 'Y') ddprev ON dd.d_date = ddprev.d_date  
WHERE dd.project_id = 117   )
SELECT da.tracking_number, da.event_date,COALESCE(am.case_type,runam.case_type,cm043.cm043_case_type,running_cm043_case_type,da.case_type,da.prev_case_type,'Application') case_type
       ,CASE WHEN am.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_metric
       ,CASE WHEN runam.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_app_metric
       ,CASE WHEN cm043.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm043
       ,CASE WHEN rcmd.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_cm043
       ,CASE WHEN rp190.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_rp190
       ,CASE WHEN runrp190.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_rp190       
       ,CASE WHEN cvl.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cviu_liaison, cvl.liaison_worker cviu_liaison_worker
       ,CASE WHEN rcvl.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_running_cviu_liaison
       ,am_worker_id,running_am_worker_id,am_wid_in_ldap,am.sd_stage,am_processing_unit,running_am_processing_unit,am_ldss_date,running_am_ldss_date
       ,cm_status,cm_authorized_date,cm_worker 
       ,override_current_state,override_last_employee,override_app_end_date
       ,apldss.cp_inv_action_taken,apldss.cp_inv_ldss_create_date,apldss.cp_inv_ldss_status_date,apldss.cp_inv_ldss_end_date,apldss.cp_inv_ldss_worker
       ,iarldss.cp_iar_action_taken,iarldss.cp_iar_ldss_created_on,iarldss.cp_iar_ldss_end_date,iarldss.cp_iar_ldss_worker              
       ,cpd.cp_inv_ad_disposition,cpd.cp_inv_ad_create_date,cpd.cp_inv_ad_status_date,cpd.cp_inv_ad_complete_date,cpd.cp_inv_ad_worker
       ,iard.cp_iar_ad_disposition,iard.cp_iar_ad_created_on,iard.cp_iar_ad_status_date,iard.cp_iar_ad_worker
       ,cpmi.cp_inv_pend_disposition,cpmi.cp_inv_pend_create_date,cpmi.cp_inv_pend_status_date,cpmi.cp_inv_pend_complete_date,cpmi.cp_inv_pend_worker,cpmi.cp_vcl_due_date                        
       ,iarmi.cp_iar_pend_disposition,iarmi.cp_iar_pend_created_on,iarmi.cp_iar_pend_status_date, iarmi.cp_iar_pend_worker,iarmi.iar_vcl_due_date 
       ,rp265.rp265_sending_agency,rp265.rp265_transfer_date
       ,rp266.rp266_sending_agency,rp266.rp266_transfer_date
       ,rp269.rp269_vcl_generation_date
       ,rp270.rp270_vcl_generation_date
       ,mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee ,mio_vcl_due_date,mio_update_date
       ,mio_term_last_employee,mio_term_orig_status,mio_term_complete_date,mio_term_update_date,mio_term_vcl_due_date,mio_term_state        
       ,manual_cviu_status,manual_cpu_status,mcviu_activity_date,mcpu_activity_date
FROM tlist da
--am
  LEFT JOIN (SELECT tracking_number, worker_id am_worker_id, pending_due_to_vcl,vcl_due_date_am, file_date,am_wid_in_ldap,
                         ma_pg_indicator,sd_stage,case_type,am_processing_status,filename_prefix,am_processing_unit,am_ldss_date
              FROM(SELECT tracking_number, worker_id
                      ,CASE WHEN UPPER(pending_due_to_vcl) IN('YES','Y') THEN 'Y'
                            WHEN UPPER(pending_due_to_vcl) IN('NO','N') THEN 'N' ELSE NULL END pending_due_to_vcl
                      ,vcl_due_date vcl_due_date_am,CAST(f.file_date AS DATE) file_date,ma_pg_indicator
                      ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number,CAST(f.file_date AS DATE) ORDER BY am.appmetric_data_id DESC) rnk
                      ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END am_wid_in_ldap                             
                      ,stage sd_stage
                      ,application_type case_type
                      ,application_status am_processing_status
                      ,f.filename_prefix
                      ,processing_unit am_processing_unit
                      ,CASE WHEN am.processing_unit = 'LDSS' THEN CAST(f.file_date AS DATE) ELSE NULL END am_ldss_date
                    FROM coverva_dmas.app_metric_v2_full_load am 
                       JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                          LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON am.worker_id = ldap.ldap)
                     WHERE rnk = 1) am ON da.tracking_number = am.tracking_number AND da.event_date = am.file_date
  LEFT JOIN (SELECT tracking_number, running_am_worker_id, pending_due_to_vcl,vcl_due_date_am, file_date, running_am_wid_in_ldap,
                         ma_pg_indicator,sd_stage,case_type,am_processing_status,filename_prefix,running_am_processing_unit,running_am_ldss_date
              FROM(SELECT tracking_number, worker_id running_am_worker_id
                      ,CASE WHEN UPPER(pending_due_to_vcl) IN('YES','Y') THEN 'Y'
                            WHEN UPPER(pending_due_to_vcl) IN('NO','N') THEN 'N' ELSE NULL END pending_due_to_vcl
                      ,vcl_due_date vcl_due_date_am,CAST(f.file_date AS DATE) file_date,ma_pg_indicator
                      ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY f.file_date DESC,am.appmetric_data_id DESC) rnk
                      ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_am_wid_in_ldap                             
                      ,stage sd_stage
                      ,application_type case_type
                      ,application_status am_processing_status
                      ,f.filename_prefix
                      ,am.processing_unit running_am_processing_unit
                      ,CASE WHEN am.processing_unit = 'LDSS' THEN CAST(f.file_date AS DATE) ELSE NULL END running_am_ldss_date
                    FROM coverva_dmas.app_metric_v2_full_load am 
                       JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                          LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON am.worker_id = ldap.ldap                    
                    UNION ALL
                    SELECT tracking_number, worker_id running_am_worker, null pending_due_vcl_pw,null vcl_due_date_pw
                             ,CAST(f.file_date AS DATE) file_date,'NO' ma_pg_indicator
                             ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,am.appmetric_data_id DESC) rnk
                             ,CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END running_am_wid_in_ldap                               
                             ,stage sd_stage
                             ,'Application' case_type 
                             ,application_status running_am_processing_status
                             ,f.filename_prefix
                             ,null running_am_processing_unit
                             ,CASE WHEN REGEXP_INSTR(worker_id, '900') = 0 THEN CAST(f.file_date AS DATE) ELSE NULL END running_am_ldss_date
                     FROM coverva_dmas.app_metric_full_load am 
                        JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                        LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON am.worker_id = ldap.ldap
                     WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_v2_full_load amv WHERE amv.tracking_number = am.tracking_number) 
                     UNION ALL
                     SELECT tracking_number, null running_am_worker,pending_due_to_vcl pending_due_vcl_pw,vcl_due_date vcl_due_date_pw,
                          CAST(f.file_date AS DATE) file_date,'YES' ma_pg_indicator
                          ,ROW_NUMBER() OVER(PARTITION BY am.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,am.appmetric_pw_data_id DESC) rnk
                          ,'N' running_am_wid_in_ldap
                          ,stage sd_stage
                          ,'Application' case_type 
                          ,null running_am_processing_status
                          ,f.filename_prefix
                          ,null running_am_processing_unit
                          ,NULL running_am_ldss_date
                      FROM coverva_dmas.app_metric_pw_full_load am 
                         JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)                               
                      WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_v2_full_load amv WHERE amv.tracking_number = am.tracking_number)
                      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amv WHERE amv.tracking_number = am.tracking_number) )
                     WHERE rnk = 1) runam ON da.tracking_number = runam.tracking_number AND da.event_date > runam.file_date
--cm43
  LEFT JOIN (SELECT tracking_number,processing_status,file_date,case_type cm043_case_type
             FROM(SELECT tracking_number,application_type as case_type,processing_status,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number,CAST(f.file_date AS DATE) ORDER BY cmd.cm043_data_id DESC) rnk
                  FROM coverva_dmas.cm043_data_full_load cmd 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)
                  WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application x WHERE x.tracking_number = cmd.tracking_number AND CAST(x.file_inventory_date AS DATE) = CAST(f.file_date AS DATE)) ) 
                  WHERE rnk = 1) cm043 ON da.tracking_number = cm043.tracking_number AND da.event_date = cm043.file_date                  
--running cm043
              LEFT JOIN (SELECT tracking_number,processing_status,file_date,case_type running_cm043_case_type 
                         FROM(SELECT tracking_number,application_type as case_type,processing_status,CAST(f.file_date AS DATE) file_date 
                                  ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,cmd.cm043_data_id DESC) rnk
                              FROM coverva_dmas.cm043_data_full_load cmd 
                               JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1) rcmd ON da.tracking_number = rcmd.tracking_number AND da.event_date > rcmd.file_date                  
--rp190
  LEFT JOIN (SELECT tracking_number,processing_status,file_date
             FROM(SELECT tracking_number,processing_status,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number,CAST(f.file_date AS DATE) ORDER BY cmd.rp190_data_id DESC) rnk
                  FROM coverva_dmas.rp190_data_full_load cmd 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename) ) 
                  WHERE rnk = 1) rp190 ON da.tracking_number = rp190.tracking_number AND da.event_date = rp190.file_date                       
--running rp190
  LEFT JOIN (SELECT tracking_number,processing_status,file_date
             FROM(SELECT tracking_number,processing_status,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY cmd.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC, cmd.rp190_data_id DESC) rnk
                  FROM coverva_dmas.rp190_data_full_load cmd 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename) ) 
                  WHERE rnk = 1) runrp190 ON da.tracking_number = runrp190.tracking_number AND da.event_date > runrp190.file_date 
--cviu liaison
LEFT JOIN (SELECT tracking_number,liaison_worker,file_date
             FROM(SELECT tracking_number,liaison_worker,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY cvl.tracking_number,CAST(f.file_date AS DATE) ORDER BY cvl.cviu_liaison_id DESC) rnk
                  FROM coverva_dmas.cviu_liaison_data_full_load cvl 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cvl.filename) = UPPER(f.filename)
                  WHERE 1=1
                  AND UPPER(paper_application) LIKE 'PAPER%'
                  AND tracking_number IS NOT NULL  ) 
                  WHERE rnk = 1) cvl ON da.tracking_number = cvl.tracking_number AND da.event_date = cvl.file_date                         
--running cviu liaison                  
LEFT JOIN (SELECT tracking_number,liaison_worker,file_date
             FROM(SELECT tracking_number,liaison_worker,CAST(f.file_date AS DATE) file_date                         
                        ,ROW_NUMBER() OVER(PARTITION BY rcvl.tracking_number ORDER BY f.file_date DESC, rcvl.cviu_liaison_id DESC) rnk
                  FROM coverva_dmas.cviu_liaison_data_full_load rcvl 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rcvl.filename) = UPPER(f.filename)
                  WHERE 1=1
                  AND UPPER(paper_application) LIKE 'PAPER%'
                  AND tracking_number IS NOT NULL  )  
                  WHERE rnk = 1) rcvl ON da.tracking_number = rcvl.tracking_number AND da.event_date >= rcvl.file_date                                           
--rp265                 
  LEFT JOIN (SELECT tracking_number,sending_agency rp265_sending_agency,transfer_date rp265_transfer_date,file_date
             FROM(SELECT tracking_number,sending_agency,transfer_date,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY rp265.tracking_number ORDER BY f.file_date DESC,rp265.rp265_data_id DESC) rnk
                  FROM coverva_dmas.rp265_data_full_load rp265 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp265.filename) = UPPER(f.filename)
                  WHERE status NOT IN('Approved','Closed','Denied')   ) 
              WHERE rnk = 1) rp265 ON da.tracking_number = rp265.tracking_number AND da.event_date >= rp265.file_date                   
--rp266                 
  LEFT JOIN (SELECT tracking_number,sending_agency rp266_sending_agency,transfer_date rp266_transfer_date,file_date
             FROM(SELECT tracking_number,sending_agency,transfer_date,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY rp266.tracking_number ORDER BY f.file_date DESC,rp266.rp266_data_id DESC) rnk
                  FROM coverva_dmas.rp266_data_full_load rp266 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp266.filename) = UPPER(f.filename)
                  WHERE status NOT IN('Approved','Closed','Denied')   ) 
             WHERE rnk = 1) rp266 ON da.tracking_number = rp266.tracking_number AND da.event_date >= rp266.file_date   

--rp269                  
  LEFT JOIN (SELECT tracking_number,vcl_generation_date rp269_vcl_generation_date,file_date
             FROM(SELECT tracking_number,vcl_generation_date,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY rp269.tracking_number ORDER BY f.file_date DESC,rp269.rp269_data_id DESC) rnk
                  FROM coverva_dmas.rp269_data_full_load rp269 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp269.filename) = UPPER(f.filename)
                  WHERE UPPER(vcl_status) NOT LIKE '%SUPPRESSED%') 
             WHERE rnk = 1) rp269 ON da.tracking_number = rp269.tracking_number AND da.event_date >= rp269.file_date 
--rp270                  
  LEFT JOIN (SELECT tracking_number,vcl_generation_date rp270_vcl_generation_date,file_date
             FROM(SELECT tracking_number,vcl_generation_date,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY rp270.tracking_number ORDER BY f.file_date DESC,rp270.rp270_data_id DESC) rnk
                  FROM coverva_dmas.rp270_data_full_load rp270 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp270.filename) = UPPER(f.filename)
                  WHERE UPPER(vcl_status) NOT LIKE '%SUPPRESSED%') 
                  WHERE rnk = 1) rp270 ON da.tracking_number = rp270.tracking_number AND da.event_date >= rp270.file_date                   
--cm44,45,46
  LEFT JOIN (SELECT DISTINCT tracking_number,cm_status,cm_authorized_date,file_date,cm_worker 
             FROM(SELECT tracking_number,
                       CASE WHEN UPPER(status) LIKE '%APPROVED%' THEN 'Approved'
                            WHEN UPPER(status) LIKE '%DENIED%' THEN 'Denied' 
                         ELSE status END cm_status,
                       authorized_date cm_authorized_date,authorized_worker_id cm_worker, CAST(f.file_date AS DATE) file_date,                        
                       ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,cm_status_rank,cm.cm_pt_data_id DESC) rnk 
                  FROM (SELECT tracking_number,status,authorized_date,authorized_worker_id,filename,cm_pt_data_id,
                           CASE WHEN UPPER(status) LIKE '%APPROVED%' THEN 1
                            WHEN UPPER(status) LIKE '%DENIED%' THEN 2 
                         ELSE 3 END cm_status_rank
                        FROM coverva_dmas.cm_processing_time_full_load) cm 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) 
                  WHERE (UPPER(status) LIKE '%APPROVED%' OR UPPER(status) LIKE '%DENIED%')) 
             WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number AND da.event_date >= cm.file_date              
             
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
                                ,RANK() OVER(PARTITION BY tracking_number ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                              FROM coverva_dmas.application_override_full_load o 
                                JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                         WHERE rnk = 1 AND override_current_state IS NOT NULL) o ON da.tracking_number = o.tracking_number AND da.event_date >= o.file_date 
--inv ldss                         
              LEFT JOIN(SELECT tracking_number,cp_inv_ldss_end_date,sr_create_date cp_inv_ldss_create_date,sr_status_date cp_inv_ldss_status_date ,staff_name cp_inv_ldss_worker,'Transferred to LDSS' cp_inv_action_taken
                         FROM(SELECT tracking_number, complete_task_date cp_inv_ldss_end_date,sr_create_date ,sr_status_date,INITCAP(completed_by_name) staff_name
                               ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY complete_task_date ASC,sr_id ASC) rn 
                              FROM coverva_dmas.cp_application_inventory cp 
                              WHERE action_taken = 'TRANSFERRED_TO_LDSS' ) 
                         WHERE rn =1) apldss ON apldss.tracking_number = da.tracking_number  AND da.event_date >= CAST(COALESCE(apldss.cp_inv_ldss_end_date,apldss.cp_inv_ldss_status_date) AS DATE)  
--iar ldss                         
              LEFT JOIN(SELECT tracking_number,cp_iar_ldss_end_date,created_on cp_iar_ldss_created_on,'Transferred to LDSS' cp_iar_action_taken,cp_iar_ldss_worker
                         FROM(SELECT tracking_number, status_date cp_iar_ldss_end_date,created_on,completed_by_name cp_iar_ldss_worker 
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY status_date ASC,task_id ASC) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                              WHERE action_taken = 'TRANSFERRED_TO_LDSS'  ) iar 
                         WHERE rn = 1 ) iarldss ON iarldss.tracking_number = da.tracking_number AND da.event_date >= CAST(COALESCE(iarldss.cp_iar_ldss_end_date,iarldss.cp_iar_ldss_created_on) AS DATE)
--inv appr denied                         
               LEFT JOIN(SELECT tracking_number,disposition cp_inv_ad_disposition,complete_task_date cp_inv_ad_complete_date,sr_create_date cp_inv_ad_create_date,sr_status_date cp_inv_ad_status_date,staff_name cp_inv_ad_worker
                         FROM(SELECT tracking_number, disposition,complete_task_date,sr_create_date,sr_status_date, INITCAP(completed_by_name) staff_name 
                               ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,'DENIED_CLOSED',2,3),complete_task_date ASC,sr_id ASC) rn 
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
                                ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,'DENIED_CLOSED',2,3),status_date ASC,task_id ASC) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                              WHERE disposition NOT IN('PENDING_MI') ) cp 
                         WHERE rn = 1 ) iard ON iard.tracking_number = da.tracking_number AND da.event_date >= CAST(COALESCE(iard.cp_iar_ad_status_date,iard.cp_iar_ad_created_on) AS DATE)
--iar pend                         
               LEFT JOIN(SELECT tracking_number,cp_iar_pend_disposition,status_date cp_iar_pend_status_date,created_on cp_iar_pend_created_on,cp_iar_pend_worker,iar_vcl_due_date
                         FROM(SELECT cp.tracking_number, cp.disposition cp_iar_pend_disposition,cp.created_on,cp.status_date,cp.completed_by_name cp_iar_pend_worker,ai.vcl_due_date iar_vcl_due_date                      
                                ,ROW_NUMBER() OVER (PARTITION BY cp.tracking_number ORDER BY cp.status_date ASC,cp.task_id ASC) rn 
                              FROM coverva_dmas.cp_initial_application_review cp 
                                LEFT JOIN coverva_dmas.cp_application_inventory ai ON cp.task_id = ai.complete_task_id) cp  
                         WHERE rn = 1 AND cp_iar_pend_disposition = 'PENDING_MI') iarmi ON iarmi.tracking_number = da.tracking_number AND da.event_date >= CAST(iarmi.cp_iar_pend_status_date AS DATE)                          
--mio pending                           
LEFT JOIN (SELECT  tracking_number,mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee ,mio_vcl_due_date,mio_update_date--,mio_term_state
                           FROM(SELECT case_number tracking_number, ldap_id mio_last_employee,task_status mio_orig_status
                                  ,mio_current_state mio_prod_status
                                  ,CAST(disposition_date AS DATE) mio_complete_date  
                                  ,CAST(updated AS DATE) mio_update_date
                                  ,vcl_due mio_vcl_due_date
                                  ,mio_term_state     
                              FROM coverva_mio.mio_inventory_full_load_vw mio
                              WHERE status_rank = 1) ) mio ON mio.tracking_number = da.tracking_number AND da.event_date >= mio.mio_update_date
--mio complete                              
LEFT JOIN (SELECT case_number tracking_number, ldap_id mio_term_last_employee,task_status mio_term_orig_status                                 
                                  ,CAST(disposition_date AS DATE) mio_term_complete_date  
                                  ,CAST(updated AS DATE) mio_term_update_date
                                  ,vcl_due mio_term_vcl_due_date
                                  ,mio_term_state     
                              FROM coverva_mio.mio_inventory_full_load_vw mio
                              WHERE latest_dispo_rank = 1) miocmpl ON miocmpl.tracking_number = da.tracking_number AND da.event_date >= miocmpl.mio_term_update_date
                              
LEFT JOIN (SELECT DISTINCT application_number,manual_cpu_status,mcpu_activity_date,mcpu_last_employee
                                    ,CASE WHEN manual_cpu_status = 'Transferred to LDSS' THEN mcpu_activity_date ELSE NULL END mcpu_ldss_date
                                    ,CASE WHEN manual_cpu_status IN('Approved','Denied') THEN mcpu_activity_date ELSE NULL END mcpu_complete_date
                          FROM(SELECT application_number
                                     ,CASE WHEN sent_to_ldss = '1' THEN 'Transferred to LDSS'
                                           WHEN approved = '1' THEN 'Approved' 
                                           WHEN denied = '1' THEN 'Denied'
                                           WHEN vcl = '1' THEN 'Waiting for Verification Documents'
                                       ELSE NULL END manual_cpu_status
                                     ,CAST(activity_date AS DATE) mcpu_activity_date
                                     ,CASE WHEN sent_to_ldss = '1' OR approved = '1' OR denied = '1' OR vcl = '1' OR noa = '1' THEN NULL ELSE ew END mcpu_last_employee
                                     ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(activity_date AS DATE) DESC,record_id DESC) rnk 
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
                           WHERE rnk = 1) mcviu ON mcviu.application_number = da.tracking_number AND da.event_date >= mcviu.mcviu_activity_date                               ;  