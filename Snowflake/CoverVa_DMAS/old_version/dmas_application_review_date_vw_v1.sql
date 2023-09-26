CREATE OR REPLACE VIEW coverva_dmas.dmas_application_review_date_vw AS
WITH tlist AS(
SELECT dd.d_date event_date,tracking_number,prev_business_date,current_state
FROM public.d_dates dd
 JOIN (SELECT tracking_number,file_inventory_date,current_state
                            FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk                               
                                 FROM coverva_dmas.dmas_application da) 
                            WHERE rnk = 1 ) da on dd.d_date >= da.file_inventory_date AND dd.d_date <= current_date()
 JOIN(SELECT d_date,LAG(d_date) OVER(ORDER BY d_date) prev_business_date
      FROM PUBLIC.D_DATES
      WHERE project_id = 117
      AND business_day_flag = 'Y') ddprev ON dd.d_date = ddprev.d_date  
WHERE dd.project_id = 117   )
SELECT da.*
 ,CASE WHEN LEAST(COALESCE(o.ovr_initial_review_complete_date,mio.mio_initial_review_date,mpt.mpt_initial_review_date)
                  ,COALESCE(mio.mio_initial_review_date,mpt.mpt_initial_review_date,o.ovr_initial_review_complete_date)
                  ,COALESCE(mpt.mpt_initial_review_date,o.ovr_initial_review_complete_date,mio.mio_initial_review_date)) IS NOT NULL THEN NULL ELSE 
                            CASE WHEN da.current_state = 'Waiting Initial Review' AND cp.tracking_number IS NOT NULL THEN 'In Application Inventory but waiting initial review' 
                                 WHEN cp.tracking_number IS NULL THEN 'Not found in Application Inventory' 
                                 WHEN cp.tracking_number IS NOT NULL AND app_initial_review_date IS NULL THEN 'Research' 
                              ELSE NULL END END initial_review_dt_null_reason                       
                        ,CASE WHEN o.ovr_initial_review_complete_date IS NOT NULL THEN 
                                LEAST(COALESCE(o.ovr_initial_review_complete_date,mpt.mpt_initial_review_date,mio.mio_initial_review_date),
                                      COALESCE(mpt.mpt_initial_review_date,mio.mio_initial_review_date,o.ovr_initial_review_complete_date),
                                      COALESCE(mio.mio_initial_review_date,o.ovr_initial_review_complete_date,mpt.mpt_initial_review_date)) 
                              WHEN da.current_state = 'Waiting Initial Review' THEN
                                CASE WHEN mpt.mpt_initial_review_date IS NOT NULL THEN mpt.mpt_initial_review_date ELSE NULL END
                          ELSE LEAST(COALESCE(cp.app_initial_review_date,mpt.mpt_initial_review_date,mio.mio_initial_review_date),
                                     COALESCE(mpt.mpt_initial_review_date,mio.mio_initial_review_date,cp.app_initial_review_date),
                                     COALESCE(mio.mio_initial_review_date,cp.app_initial_review_date,mpt.mpt_initial_review_date)) END final_app_initial_review_date                                               
                        ,CASE WHEN o.ovr_initial_review_complete_date IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                        ,o.ovr_initial_review_complete_date,mpt.mpt_initial_review_date,cp.app_initial_review_date                        
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
                                            ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcpu_activity_date 
                                            ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE),record_id) rnk 
                                           FROM coverva_dmas.manual_cpu_tracking
                                           WHERE sent_to_ldss = '1' OR approved = '1' OR denied = '1' OR vcl = '1' OR noa = '1' ) 
                                      WHERE rnk = 1  
                                      UNION 
                                      SELECT DISTINCT application_number,mcviu_activity_date 
                                      FROM(SELECT application_number         
                                             ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcviu_activity_date 
                                             ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE),record_id) rnk 
                                           FROM coverva_dmas.manual_cviu_tracking
                                           WHERE (LEFT(UPPER(sent_to_ldss_1yes_0no),1) IN('Y','1') OR UPPER(status) LIKE 'APPROVED%' OR UPPER(status) LIKE 'DENIED%' OR LEFT(UPPER(vcl_1yes_0no),1) IN('Y','1') OR LEFT(UPPER(manual_vcl_1yes_0no),1) IN('Y','1') ) )
                                      WHERE rnk = 1 ) 
             GROUP BY tracking_number) cp ON da.tracking_number = cp.tracking_number AND da.event_date >= app_initial_review_date
 /*LEFT JOIN (SELECT tracking_number, ovr_initial_review_complete_date,file_date 
            FROM(SELECT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(initial_review_complete_date),2),'00','20'),RIGHT(date(initial_review_complete_date),8)) AS DATE) ovr_initial_review_complete_date, CAST(f.file_date AS DATE) file_date 
                     ,RANK() OVER(PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                 FROM coverva_dmas.application_override_full_load o 
                   JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
            WHERE rnk = 1 AND ovr_initial_review_complete_date IS NOT NULL )  o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date   */
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
 LEFT JOIN(SELECT case_number tracking_number,MIN(CONVERT_TIMEZONE('UTC', 'America/New_York',mio.bucket_date)) mio_initial_review_date                                   
           FROM coverva_mio.case_pool_log mio
           WHERE (CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%'         
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'
               OR UPPER(task_status) = 'OTHER')
           GROUP BY case_number) mio ON da.tracking_number = mio.tracking_number;