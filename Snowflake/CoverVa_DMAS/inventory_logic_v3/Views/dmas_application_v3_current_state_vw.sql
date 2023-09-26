 CREATE OR REPLACE VIEW coverva_dmas.dmas_application_v3_current_state_vw
 AS 
 WITH cs AS(
 SELECT e.tracking_number,e.event_date               
               ,CASE WHEN NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND e.event_date >= cpi.sr_create_date )
                    AND NOT EXISTS(SELECT 1 FROM coverva_dmas.cp_initial_application_review cpi WHERE cpi.tracking_number = e.tracking_number AND e.event_date >= cpi.status_date ) THEN 
                      CASE WHEN (in_app_metric = 'N' AND in_rp190 = 'N' AND in_cm043 = 'Y' AND case_type = 'Renewal') THEN COALESCE(mio_term_state,'Waiting Initial Review') ELSE 'Intake' END
                    ELSE NULL END current_state_0
               ,CASE WHEN ( (in_app_metric = 'Y' AND (am_worker_id IS NULL OR (REGEXP_INSTR(am_worker_id, '900') > 0 AND am_wid_in_ldap = 'Y')) )
                     OR in_cm043 = 'Y' OR in_rp190 = 'Y' 
                   OR ( (in_cviu_liaison = 'Y'  OR (in_cviu_liaison = 'N' AND in_running_cviu_liaison = 'Y') )    
                        AND inv.filename_prefix = 'CVIU_LIAISON_SMARTSHEET'
                       AND in_app_metric = 'N' AND in_cm043 = 'N' AND in_rp190 = 'N' AND ame.last_date_in_file IS NULL
                       AND e.cp_inv_ad_disposition IS NULL AND e.cp_iar_ad_disposition IS NULL AND e.mio_term_state IS NULL AND e.cm_status IS NULL
                       AND e.cp_inv_action_taken IS NULL AND e.cp_iar_action_taken IS NULL AND e.cp_inv_ad_disposition IS NULL AND cp_iar_ad_disposition IS NULL
                       AND e.rp265_sending_agency IS NULL AND e.rp266_sending_agency IS NULL AND e.manual_cpu_status IS NULL) )
                   THEN 'current_state_1' ELSE NULL END current_state_1
               ,CASE WHEN (in_app_metric = 'N' AND in_rp190 = 'N' AND in_cm043 = 'Y' AND case_type = 'Renewal') THEN COALESCE(mio_term_state,'Waiting Initial Review')                      
                     WHEN (e.cp_inv_pend_disposition IS NOT NULL OR e.cp_iar_pend_disposition IS NOT NULL) 
                         OR (e.sd_stage = '6-Pending VCL')
                         OR (mio_prod_status = 'Waiting for Verification Documents')
                         OR (rp269_vcl_generation_date IS NOT NULL)
                         OR (rp270_vcl_generation_date IS NOT NULL)                        
                       THEN 'Waiting for Verification Documents'
                     WHEN mio_prod_status = 'Initial Review Complete' THEN mio_prod_status
                     WHEN (EXISTS(SELECT 1 FROM coverva_dmas.cp_application_inventory cpi WHERE cpi.tracking_number = e.tracking_number AND complete_task_date IS NULL) AND e.cp_inv_pend_disposition IS NULL)  
                        AND e.cp_iar_pend_disposition IS NULL                         
                        AND (mio_orig_status IS NULL OR (mio_prod_status) NOT IN('Waiting for Verification Documents','Initial Review Complete')) 
                      THEN 'Waiting Initial Review'
                  ELSE 'Waiting Initial Review' END  current_state_1a  
                ,CASE WHEN e.cm_status IS NOT NULL THEN e.cm_status ELSE NULL END current_state_2   
                ,CASE WHEN (e.cp_inv_action_taken IS NOT NULL OR e.cp_iar_action_taken IS NOT NULL OR e.cp_inv_ad_disposition = 'REFERRED' OR cp_iar_ad_disposition = 'REFERRED'
                     OR e.rp265_sending_agency = 'Central Office' OR e.rp266_sending_agency = 'Central Office' OR e.mio_term_state = 'Transferred to LDSS' OR COALESCE(am_processing_unit,running_am_processing_unit) = 'LDSS'
                     OR e.manual_cpu_status = 'Transferred to LDSS' OR e.manual_cviu_status = 'Transferred to LDSS')                      
                     OR ( (in_cm043 = 'N' AND in_rp190 = 'N' AND in_app_metric = 'Y' AND am_worker_id IS NOT NULL AND REGEXP_INSTR(am_worker_id, '900') = 0 )  
                    OR (in_cm043 = 'N' AND in_rp190 = 'N' AND in_app_metric = 'N' AND in_running_app_metric = 'Y' AND running_am_worker_id IS NOT NULL AND REGEXP_INSTR(running_am_worker_id, '900') = 0 
                          AND (in_cviu_liaison = 'N' OR ((in_cviu_liaison = 'Y' OR (in_cviu_liaison = 'N' AND in_running_cviu_liaison = 'Y')  ) AND e.manual_cpu_status IS NULL) ) ) ) 
                   THEN 'Transferred to LDSS' ELSE NULL END current_state_3
                ,CASE WHEN in_app_metric = 'Y' AND (REGEXP_INSTR(am_worker_id, '900') > 0 AND am_wid_in_ldap = 'N')  THEN 'Non Maximus Assigned' ELSE NULL END current_state_3b                   
                ,CASE WHEN ( (in_app_metric = 'N' AND in_cm043 = 'N' AND in_rp190 = 'N' )
                     AND (in_running_app_metric = 'Y' OR in_running_cm043 = 'Y' OR in_running_rp190 = 'Y') )
                     --if app is in cviu liaison but there is a disposition
                     OR ( (in_cviu_liaison = 'Y' OR (in_cviu_liaison = 'N' AND in_running_cviu_liaison = 'Y') )
                            AND in_app_metric = 'N' AND in_cm043 = 'N' AND in_rp190 = 'N'
                            AND inv.filename_prefix = 'CVIU_LIAISON_SMARTSHEET'
                         AND (e.cp_inv_ad_disposition IS NOT NULL OR e.cp_iar_ad_disposition IS NOT NULL OR e.mio_term_state IS NOT NULL OR ame.last_date_in_file IS NOT NULL OR e.manual_cpu_status IS NOT NULL))
                     THEN 'current_state_4' ELSE NULL END current_state_4
                --handle old applications
                ,CASE WHEN (in_app_metric = 'N' AND in_cm043 = 'N' AND in_rp190 = 'N' AND in_cviu_liaison = 'N')
                     AND (in_running_app_metric = 'N' AND in_running_cm043 = 'N' AND in_running_rp190 = 'N' AND in_running_cviu_liaison = 'N')
                     AND e.manual_cpu_status IS NOT NULL THEN e.manual_cpu_status ELSE NULL END  current_state_4b
                ,CASE WHEN (e.cp_inv_ad_disposition IS NOT NULL OR e.cp_iar_ad_disposition IS NOT NULL OR e.mio_term_state IS NOT NULL OR manual_cpu_status IS NOT NULL OR manual_cviu_status IS NOT NULL ) THEN 
                     CASE WHEN e.cp_inv_ad_disposition IN('APPROVED','AUTO_APPROVED') OR e.cp_iar_ad_disposition IN('APPROVED','AUTO_APPROVED') 
                            OR e.mio_term_state = 'Approved' 
                            OR e.manual_cpu_status = 'Approved' OR e.manual_cviu_status = 'Approved' THEN 'Approved'                             
                          WHEN e.cp_inv_ad_disposition IN('DENIED','AUTO_DENIED','DENIED_CLOSED') OR e.cp_iar_ad_disposition IN('DENIED','AUTO_DENIED','DENIED_CLOSED') 
                            OR e.mio_term_state = 'Denied' 
                            OR e.manual_cpu_status = 'Denied' OR e.manual_cviu_status = 'Denied' THEN 'Denied'
                     ELSE 'Complete - Needs Research' END 
                  ELSE 'Complete - Needs Research' END current_state_5
                ,cm_authorized_date
                ,CASE WHEN e.rp265_sending_agency = 'Central Office' OR e.rp266_sending_agency = 'Central Office' THEN
                   COALESCE(e.rp265_transfer_date,e.rp266_transfer_date)                  
                  ELSE LEAST(COALESCE(e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk)
                       ,COALESCE(e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date)
                       ,COALESCE(e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date)
                       ,COALESCE(e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date)
                       ,COALESCE(e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date)
                       ,COALESCE(e.mcviu_activity_date,am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date)
                       ,COALESCE(am_ldss_date,running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date)
                       ,COALESCE(running_am_ldss_date,last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date)
                       ,COALESCE(last_date_in_file_mwrk,e.cp_ai_ldss_date,e.cp_referred_dispo_date,e.cp_iar_ldss_end_date,e.mio_complete_date,e.mcpu_activity_date,e.mcviu_activity_date,am_ldss_date,running_am_ldss_date))   END ldss_end_date  
               ,LEAST(COALESCE(e.cp_ai_complete_date,e.cp_iar_ad_status_date),COALESCE(e.cp_iar_ad_status_date,e.cp_ai_complete_date)) ad_complete_date     
               ,override_app_end_date
               ,ame.last_date_in_file
               ,e.mio_complete_date
               ,e.mio_term_state
               ,wrk.last_date_in_file_mwrk    
               ,in_cm043,in_running_cm043,case_type,previous_vcl_sent      
               ,inv.previous_current_state,inv.previous_end_date,inv.latest_inventory_date   
               ,mcpu_activity_date,mcviu_activity_date
             FROM (SELECT tracking_number,file_inventory_date latest_inventory_date,state_app_received_date,previous_current_state,previous_end_date,previous_vcl_sent,min_file_id,fl.filename_prefix 
                            FROM(SELECT da.tracking_number,file_inventory_date,state_app_received_date, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk
                                      ,COALESCE(current_state,LEAD(current_state) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_current_state
                                      ,COALESCE(vcl_sent_date,LEAD(vcl_sent_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_vcl_sent
                                      ,COALESCE(previous_processing_end_date,LEAD(application_processing_end_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_end_date
                                      ,MIN(file_id) OVER (PARTITION BY tracking_number) min_file_id
                                 FROM coverva_dmas.dmas_application_v3_inventory da) da
                                JOIN dmas_file_log fl ON da.min_file_id = fl.file_id
                            WHERE rnk = 1) inv
             JOIN (SELECT e.*                   
                    ,CASE WHEN cp_inv_ad_disposition = 'REFERRED' OR cp_iar_ad_disposition = 'REFERRED' THEN COALESCE(cp_inv_ad_complete_date,cp_iar_ad_status_date,cp_inv_ad_status_date) ELSE NULL END cp_referred_dispo_date
                    ,COALESCE(cp_inv_ldss_end_date,cp_inv_ldss_status_date) cp_ai_ldss_date
                    ,COALESCE(cp_inv_ad_complete_date,cp_inv_ad_status_date) cp_ai_complete_date                    
                   ,ROW_NUMBER() OVER (PARTITION BY e.tracking_number ORDER BY event_date DESC) rnk
                   FROM coverva_dmas.dmas_application_v3_event e 
                   WHERE dayofweek(event_date) > 0) e ON e.tracking_number = inv.tracking_number
               LEFT JOIN(SELECT tracking_number,MAX(last_date_in_file) last_date_in_file
                         FROM(SELECT tracking_number,MAX(event_date) last_date_in_file
                              FROM coverva_dmas.dmas_application_v3_event ame
                              WHERE ((ame.in_app_metric = 'Y' OR ame.in_cm043 = 'Y' OR ame.in_rp190 = 'Y')  
                              AND EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_event mn JOIN public.d_dates dd ON mn.event_date = dd.d_date AND dd.project_id = 117 AND business_day_flag = 'Y'
                                         WHERE ame.tracking_number = mn.tracking_number
                                         AND mn.in_app_metric = 'N' AND mn.in_cm043 = 'N' AND mn.in_rp190 = 'N'
                                         AND mn.application_event_id > ame.application_event_id 
                                         AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_event my JOIN public.d_dates dd ON my.event_date = dd.d_date AND dd.project_id = 117 AND business_day_flag = 'Y'
                                                        WHERE my.tracking_number = mn.tracking_number                                    
                                                        AND (my.in_app_metric = 'Y' OR my.in_cm043 = 'Y' OR my.in_rp190 = 'Y') 
                                                        AND my.application_event_id > mn.application_event_id ) ))                                 
                              GROUP BY tracking_number
                              UNION
                              SELECT tracking_number,MAX(last_date_in_file) last_date_in_file
                              FROM coverva_dmas.dmas_application_v2_min_event
                              WHERE last_date_in_file IS NOT NULL
                              GROUP BY tracking_number
                              UNION
                              SELECT tracking_number,MIN(event_date) last_date_in_file
                              FROM coverva_dmas.dmas_application_v3_event e
                              WHERE in_cviu_liaison = 'Y' AND in_running_cviu_liaison = 'Y'
                              AND in_app_metric = 'N' AND in_cm043 = 'N' AND in_rp190 = 'N' 
                              AND in_running_app_metric = 'N' AND in_running_cm043 = 'N' AND in_running_rp190 = 'N'
                              AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_min_event v2min WHERE v2min.tracking_number = e.tracking_number AND v2min.last_date_in_file IS NOT NULL)
                              GROUP BY tracking_number )
                         GROUP BY tracking_number ) ame ON ame.tracking_number = e.tracking_number
              LEFT JOIN(SELECT tracking_number,MIN(last_date_in_file_mwrk) last_date_in_file_mwrk
                        FROM(SELECT tracking_number,MIN(event_date) last_date_in_file_mwrk
                             FROM coverva_dmas.dmas_application_v3_event wrk
                             WHERE  (wrk.in_app_metric = 'Y' AND (REGEXP_INSTR(am_worker_id, '900') = 0) )  
                             GROUP BY tracking_number
                             UNION
                             SELECT tracking_number,MIN(last_date_in_file_mwrk) last_date_in_file_mwrk
                             FROM coverva_dmas.dmas_application_v2_min_event
                             WHERE last_date_in_file_mwrk IS NOT NULL
                             GROUP BY tracking_number)
                        GROUP BY tracking_number  ) wrk ON wrk.tracking_number = e.tracking_number ),
final_cur_state AS                            
(SELECT cs.tracking_number
  ,cs.event_date,previous_current_state,previous_end_date,previous_vcl_sent,latest_inventory_date
  ,current_state_0,current_state_1,current_state_1a,current_state_2,current_state_3,current_state_4,current_state_5
  ,override_app_end_date,ldss_end_date,cm_authorized_date,ad_complete_date
  ,last_date_in_file last_date_in_any_file
  ,mio_complete_date,last_date_in_file_mwrk,mio_term_state,mcpu_activity_date,mcviu_activity_date
  ,CASE WHEN current_state_1 IS NOT NULL  THEN 
        CASE WHEN previous_current_state = 'Non Maximus Assigned' AND current_state_1a = 'Waiting Initial Review' THEN 'Initial Review Complete'
             WHEN previous_current_state IN('Initial Review Complete','Waiting for Verification Documents') AND current_state_1a = 'Waiting Initial Review' THEN previous_current_state
             WHEN previous_current_state = 'Waiting Initial Review' AND current_state_0 IS NOT NULL THEN previous_current_state
             WHEN current_state_0 IS NOT NULL THEN current_state_0 
          ELSE current_state_1a END       
       WHEN current_state_2 IS NOT NULL THEN current_state_2              
       WHEN current_state_3 IS NOT NULL THEN current_state_3  
       WHEN current_state_3b IS NOT NULL THEN current_state_3b  
       WHEN case_type = 'Renewal' AND current_state_4 IS NOT NULL THEN
         CASE WHEN in_cm043 = 'N' AND in_running_cm043 = 'Y' AND current_state_5 = 'Complete - Needs Research' THEN
           CASE WHEN mio_term_state IS NOT NULL THEN mio_term_state 
                WHEN previous_current_state IS NOT NULL THEN previous_current_state 
              ELSE 'Waiting Initial Review' END
          ELSE current_state_5 END       
       WHEN current_state_4 IS NOT NULL THEN current_state_5           
       WHEN previous_current_state IN('Approved','Denied','Complete - Needs Research','Transferred to LDSS') THEN previous_current_state
       WHEN current_state_4b IS NOT NULL THEN current_state_4b    
   ELSE 'Waiting Initial Review' END final_current_state
 FROM cs)   
 SELECT fcs.*,
   CAST(CASE WHEN final_current_state IN('Intake','Waiting Initial Review','Waiting for Verification Documents','Initial Review Complete','Non Maximus Assigned') THEN NULL             
             WHEN previous_end_date IS NOT NULL THEN previous_end_date
             WHEN current_state_2 IS NOT NULL THEN cm_authorized_date                         
             WHEN final_current_state = 'Transferred to LDSS' THEN CASE WHEN ldss_end_date IS NOT NULL THEN ldss_end_date ELSE NULL END                              
             WHEN final_current_state IN('Approved','Denied','Complete - Needs Research') THEN                                                 
                 LEAST(COALESCE(mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date),
                     COALESCE(ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date,mio_complete_date),
                     COALESCE(last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date,mio_complete_date,ad_complete_date),
                     COALESCE(fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date,mio_complete_date,ad_complete_date,last_date_in_file_mwrk),
                     COALESCE(mcpu_activity_date,mcviu_activity_date,mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file),
                     COALESCE(mcviu_activity_date,mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date))                                          
        ELSE NULL END AS DATE) final_end_date,
   CAST(CASE WHEN final_current_state IN('Intake','Waiting Initial Review','Waiting for Verification Documents','Initial Review Complete','Non Maximus Assigned') THEN NULL                          
             WHEN current_state_2 IS NOT NULL THEN cm_authorized_date                         
             WHEN final_current_state = 'Transferred to LDSS' THEN CASE WHEN ldss_end_date IS NOT NULL THEN ldss_end_date ELSE NULL END                              
             WHEN final_current_state IN('Approved','Denied','Complete - Needs Research') THEN                                                 
                 LEAST(COALESCE(mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date),
                     COALESCE(ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date,mio_complete_date),
                     COALESCE(last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date,mio_complete_date,ad_complete_date),
                     COALESCE(fcs.last_date_in_any_file,mcpu_activity_date,mcviu_activity_date,mio_complete_date,ad_complete_date,last_date_in_file_mwrk),
                     COALESCE(mcpu_activity_date,mcviu_activity_date,mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file),
                     COALESCE(mcviu_activity_date,mio_complete_date,ad_complete_date,last_date_in_file_mwrk,fcs.last_date_in_any_file,mcpu_activity_date))                                        
        ELSE NULL END AS DATE) actual_end_date,     
   CASE WHEN final_current_state IN('Approved','Denied','Transferred to LDSS','Complete - Needs Research') THEN
       CASE WHEN current_state_2 IS NOT NULL THEN 'Y' ELSE 'N' END 
     ELSE NULL END cm044_verified,
   CASE WHEN final_current_state = 'Non Maximus Assigned' THEN event_date ELSE NULL END non_maximus_initial_date,
   CASE WHEN previous_current_state = 'Non Maximus Assigned' AND final_current_state != previous_current_state THEN event_date ELSE NULL END non_maximus_returned_date   
 FROM final_cur_state fcs;
 

