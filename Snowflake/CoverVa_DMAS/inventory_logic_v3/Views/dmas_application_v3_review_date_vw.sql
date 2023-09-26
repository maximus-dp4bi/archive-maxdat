CREATE OR REPLACE VIEW coverva_dmas.dmas_application_v3_review_date_vw AS
WITH tlist AS(
SELECT dd.d_date event_date,tracking_number,prev_business_date,current_state,inv_min_review_date,application_processing_end_date,state_app_received_date,
  inv_min_non_maximus_initial_date,previous_vcl_sent_date,previous_initial_review_date
FROM public.d_dates dd
 JOIN (SELECT tracking_number,dmas_application_id,file_inventory_date,current_state,inv_min_review_date,application_processing_end_date,state_app_received_date,
         inv_min_non_maximus_initial_date,previous_vcl_sent_date,previous_initial_review_date
       FROM(SELECT da.*, irvw.inv_min_review_date,nmid.inv_min_non_maximus_initial_date,RANK() OVER (PARTITION BY da.tracking_number ORDER BY file_inventory_date,dmas_application_id DESC) rnk   
              ,COALESCE(vcl_sent_date,LEAD(vcl_sent_date) IGNORE NULLS OVER(PARTITION BY da.tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_vcl_sent_date
            FROM coverva_dmas.dmas_application_v3_inventory da
               LEFT JOIN(SELECT tracking_number, MIN(initial_review_complete_date) inv_min_review_date
                         FROM coverva_dmas.dmas_application_v3_inventory
                         WHERE initial_review_complete_date IS NOT NULL
                         GROUP BY tracking_number) irvw ON da.tracking_number = irvw.tracking_number
                LEFT JOIN(SELECT tracking_number, MIN(non_maximus_initial_date) inv_min_non_maximus_initial_date
                         FROM coverva_dmas.dmas_application_v3_inventory
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
         CASE WHEN da.previous_initial_review_date IS NOT NULL THEN previous_initial_review_date
              WHEN da.inv_min_review_date IS NOT NULL THEN da.inv_min_review_date
              WHEN da.inv_min_non_maximus_initial_date IS NOT NULL AND da.inv_min_review_date IS NULL THEN da.inv_min_non_maximus_initial_date
              WHEN o.ovr_initial_review_complete_date IS NOT NULL THEN o.ovr_initial_review_complete_date              
           ELSE COALESCE(LEAST(COALESCE(mio.mio_initial_review_date,cp.app_initial_review_date,rp269.rp269_vcl_generation_date,rp270.rp270_vcl_generation_date),
                               COALESCE(cp.app_initial_review_date,rp269.rp269_vcl_generation_date,rp270.rp270_vcl_generation_date,mio.mio_initial_review_date),
                               COALESCE(rp269.rp269_vcl_generation_date,rp270.rp270_vcl_generation_date,mio.mio_initial_review_date,cp.app_initial_review_date),
                               COALESCE(rp270.rp270_vcl_generation_date,mio.mio_initial_review_date,cp.app_initial_review_date,rp269.rp269_vcl_generation_date)),da.application_processing_end_date) END
       ELSE NULL END drv_initial_review_date     
     ,o.ovr_initial_review_complete_date,cp.app_initial_review_date,mio.mio_initial_review_date,rp269.rp269_vcl_generation_date,rp270.rp270_vcl_generation_date                       
FROM tlist da
  LEFT JOIN  (SELECT tracking_number,MIN(app_initial_review_date) app_initial_review_date 
               FROM(SELECT tracking_number,CAST(FIRST_VALUE(complete_task_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY complete_task_date,sr_id) AS DATE) app_initial_review_date 
                    FROM coverva_dmas.cp_application_inventory 
                    UNION 
                    SELECT tracking_number,CAST(FIRST_VALUE(status_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY status_date,task_id) AS DATE) app_initial_review_date 
                    FROM coverva_dmas.cp_initial_application_review ) 
             GROUP BY tracking_number) cp ON da.tracking_number = cp.tracking_number AND da.event_date >= app_initial_review_date 
 LEFT JOIN(SELECT tracking_number,MIN(initial_review_complete_date) ovr_initial_review_complete_date
             FROM coverva_dmas.application_override_full_load o 
             WHERE initial_review_complete_date IS NOT NULL
             GROUP  BY tracking_number) o ON da.tracking_number = o.tracking_number
 LEFT JOIN(SELECT case_number tracking_number,MIN(disposition_date) mio_initial_review_date                                   
           FROM coverva_mio.mio_inventory_full_load_vw mio
           WHERE mio_current_state NOT IN('Waiting Initial Review','Intake')  
           GROUP BY case_number) mio ON da.tracking_number = mio.tracking_number
  LEFT JOIN (SELECT tracking_number,vcl_generation_date rp269_vcl_generation_date,file_date
             FROM(SELECT tracking_number,vcl_generation_date,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY rp269.tracking_number ORDER BY f.file_date DESC,rp269.rp269_data_id DESC) rnk
                  FROM coverva_dmas.rp269_data_full_load rp269 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp269.filename) = UPPER(f.filename)) 
                  WHERE rnk = 1) rp269 ON da.tracking_number = rp269.tracking_number AND da.event_date >= rp269.file_date          
  LEFT JOIN (SELECT tracking_number,vcl_generation_date rp270_vcl_generation_date,file_date
             FROM(SELECT tracking_number,vcl_generation_date,CAST(f.file_date AS DATE) file_date 
                        ,ROW_NUMBER() OVER(PARTITION BY rp270.tracking_number ORDER BY f.file_date DESC,rp270.rp270_data_id DESC) rnk
                  FROM coverva_dmas.rp270_data_full_load rp270 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp270.filename) = UPPER(f.filename)) 
                  WHERE rnk = 1) rp270 ON da.tracking_number = rp270.tracking_number AND da.event_date >= rp270.file_date           
           
           )
SELECT rvw.*
  ,CASE WHEN rvw.drv_initial_review_date < rvw.state_app_received_date THEN rvw.state_app_received_date ELSE rvw.drv_initial_review_date  END final_app_initial_review_date
  ,CASE WHEN current_state = 'Waiting for Verification Documents' AND previous_vcl_sent_date IS NULL THEN
    CASE WHEN rvw.drv_initial_review_date < rvw.state_app_received_date THEN rvw.state_app_received_date ELSE rvw.drv_initial_review_date  END
    ELSE previous_vcl_sent_date END final_vcl_sent_date
FROM rvw_date rvw;