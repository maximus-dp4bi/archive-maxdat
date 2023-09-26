CREATE OR REPLACE VIEW coverva_dmas.dmas_application_v2_review_date_vw AS
WITH tlist AS(
SELECT dd.d_date event_date,tracking_number,prev_business_date,current_state,inv_min_review_date,application_processing_end_date,state_app_received_date,inv_min_non_maximus_initial_date
FROM public.d_dates dd
 JOIN (SELECT tracking_number,file_inventory_date,current_state,inv_min_review_date,application_processing_end_date,state_app_received_date,inv_min_non_maximus_initial_date
       FROM(SELECT da.*, irvw.inv_min_review_date,nmid.inv_min_non_maximus_initial_date,RANK() OVER (PARTITION BY da.tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk                               
            FROM coverva_dmas.dmas_application_v2_inventory da
               LEFT JOIN(SELECT tracking_number, MIN(initial_review_complete_date) inv_min_review_date
                         FROM coverva_dmas.dmas_application_v2_inventory
                         WHERE initial_review_complete_date IS NOT NULL
                         GROUP BY tracking_number) irvw ON da.tracking_number = irvw.tracking_number
                LEFT JOIN(SELECT tracking_number, MIN(non_maximus_initial_date) inv_min_non_maximus_initial_date
                         FROM coverva_dmas.dmas_application_v2_inventory
                         WHERE non_maximus_initial_date IS NOT NULL
                         GROUP BY tracking_number) nmid ON da.tracking_number = nmid.tracking_number         )
            WHERE rnk = 1 ) da on dd.d_date >= da.file_inventory_date AND dd.d_date <= current_date()
 JOIN(SELECT d_date,LAG(d_date) OVER(ORDER BY d_date) prev_business_date
      FROM PUBLIC.D_DATES
      WHERE project_id = 117
      AND business_day_flag = 'Y') ddprev ON dd.d_date = ddprev.d_date  
WHERE dd.project_id = 117   ),
rvw_date AS
(SELECT da.*    
     ,CASE WHEN da.current_state IN('Intake', 'Waiting Initial Review') THEN 'In Application Inventory but waiting initial review'
        ELSE null END initial_review_dt_null_reason  
     ,CASE WHEN da.current_state NOT IN('Waiting Initial Review','Intake') THEN
         CASE WHEN da.inv_min_non_maximus_initial_date IS NOT NULL AND da.inv_min_review_date IS NULL THEN da.inv_min_non_maximus_initial_date
           ELSE COALESCE(COALESCE(da.inv_min_review_date,LEAST(COALESCE(mio.mio_initial_review_date,cp.app_initial_review_date,mpt.mpt_initial_review_date,o.ovr_initial_review_complete_date),
                         COALESCE(cp.app_initial_review_date,mpt.mpt_initial_review_date,o.ovr_initial_review_complete_date,mio.mio_initial_review_date),
                         COALESCE(mpt.mpt_initial_review_date,o.ovr_initial_review_complete_date,mio.mio_initial_review_date,cp.app_initial_review_date),
                         COALESCE(o.ovr_initial_review_complete_date,mio.mio_initial_review_date,cp.app_initial_review_date,mpt.mpt_initial_review_date))), da.application_processing_end_date) END
       ELSE NULL END drv_initial_review_date
     ,CASE WHEN o.ovr_initial_review_complete_date IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
     ,o.ovr_initial_review_complete_date,mpt.mpt_initial_review_date,cp.app_initial_review_date,mio.mio_initial_review_date                       
FROM tlist da
  LEFT JOIN  (SELECT tracking_number,MIN(app_initial_review_date) app_initial_review_date 
                                 FROM(SELECT tracking_number,CAST(FIRST_VALUE(complete_task_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY complete_task_date,sr_id) AS DATE) app_initial_review_date 
                                      FROM coverva_dmas.cp_application_inventory 
                                      UNION 
                                      SELECT tracking_number,CAST(FIRST_VALUE(status_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY status_date,task_id) AS DATE) app_initial_review_date 
                                      FROM coverva_dmas.cp_initial_application_review 
                                      UNION 
                                      SELECT DISTINCT application_number,mcpu_activity_date 
                                      FROM(SELECT application_number,vcl 
                                            ,CAST(activity_date AS DATE) mcpu_activity_date 
                                            ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(activity_date AS DATE),record_id) rnk 
                                           FROM coverva_dmas.manual_cpu_tracking
                                           WHERE sent_to_ldss = '1' OR approved = '1' OR denied = '1' OR vcl = '1' OR noa = '1' ) 
                                      WHERE rnk = 1  
                                      UNION 
                                      SELECT DISTINCT application_number,mcviu_activity_date 
                                      FROM(SELECT application_number         
                                             ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM CAST('01/01/2021' as date))) AS DATE) mcviu_activity_date 
                                             ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM CAST('01/01/2021' as date))) AS DATE),record_id) rnk 
                                           FROM coverva_dmas.manual_cviu_tracking
                                           WHERE (LEFT(UPPER(sent_to_ldss_1yes_0no),1) IN('Y','1') OR UPPER(status) LIKE 'APPROVED%' OR UPPER(status) LIKE 'DENIED%' OR LEFT(UPPER(vcl_1yes_0no),1) IN('Y','1') OR LEFT(UPPER(manual_vcl_1yes_0no),1) IN('Y','1') ) )
                                      WHERE rnk = 1 ) 
             GROUP BY tracking_number) cp ON da.tracking_number = cp.tracking_number AND da.event_date >= app_initial_review_date 
 LEFT JOIN(SELECT tracking_number,MIN(initial_review_complete_date) ovr_initial_review_complete_date
             FROM coverva_dmas.application_override_full_load o 
             WHERE initial_review_complete_date IS NOT NULL
             GROUP  BY tracking_number) o ON da.tracking_number = o.tracking_number
 LEFT JOIN(SELECT DISTINCT tracking_number,mpt_initial_review_date,file_date                                   
           FROM(SELECT tracking_number 
                  ,CASE WHEN UPPER(status) LIKE 'PENDING%VCL%' OR UPPER(status) LIKE 'NONE%' THEN CAST(completion_time AS DATE) ELSE NULL END mpt_initial_review_date 
                  ,CAST(completion_time AS DATE) mpt_complete_date, CAST(f.file_date AS DATE) file_date 
                  ,ROW_NUMBER() OVER(PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY completion_time DESC,record_id DESC) rnk 
                FROM coverva_dmas.manual_prod_tracker_full_load p  
                  JOIN coverva_dmas.dmas_file_log f ON UPPER(p.filename) = UPPER(f.filename) ) 
           WHERE rnk = 1 AND mpt_initial_review_date IS NOT NULL) mpt ON da.tracking_number = mpt.tracking_number AND da.prev_business_date = mpt.file_date
 LEFT JOIN(SELECT case_number tracking_number,MIN(disposition_date) mio_initial_review_date                                   
           FROM coverva_mio.mio_inventory_full_load_vw mio
           WHERE mio_current_state NOT IN('Waiting Initial Review','Intake')  
           GROUP BY case_number) mio ON da.tracking_number = mio.tracking_number)
SELECT rvw.*
  ,CASE WHEN rvw.drv_initial_review_date < rvw.state_app_received_date THEN rvw.state_app_received_date ELSE rvw.drv_initial_review_date  END final_app_initial_review_date
FROM rvw_date rvw;