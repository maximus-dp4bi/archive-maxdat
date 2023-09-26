CREATE OR REPLACE VIEW coverva_dmas.dmas_application_vcl_due_date_vw
AS
SELECT e.tracking_number,e.event_date,inv.latest_inventory_date,
  CASE WHEN inv.current_state = 'Waiting for Verification Documents' THEN
    CAST(CASE WHEN e.ppit_vcl_due_date IS NOT NULL THEN e.ppit_vcl_due_date
              WHEN e.mio_vcl_due_date IS NOT NULL THEN e.mio_vcl_due_date              
              WHEN cp_vcl_due IS NOT NULL OR iar_vcl_due IS NOT NULL OR mcpu_vcl_due IS NOT NULL OR mcviu_vcl_due IS NOT NULL
                THEN GREATEST(COALESCE(cp_vcl_due,iar_vcl_due,mcpu_vcl_due,mcviu_vcl_due)
                              ,COALESCE(iar_vcl_due,mcpu_vcl_due,mcviu_vcl_due,cp_vcl_due)
                              ,COALESCE(mcpu_vcl_due,mcviu_vcl_due,cp_vcl_due,iar_vcl_due)
                              ,COALESCE(mcviu_vcl_due,cp_vcl_due,iar_vcl_due,mcpu_vcl_due))
              WHEN pending_due_vcl_am = 'Y' THEN vcl_due_date_am
              WHEN pending_due_vcl_pw = 'Y' THEN vcl_due_date_pw         
              WHEN e.mpt_vcl_due IS NOT NULL THEN e.mpt_vcl_due
              WHEN o.vcl_due_date IS NOT NULL THEN o.vcl_due_date
            ELSE NULL END AS DATE)
   ELSE NULL END final_vcl_due_date            
  ,cp_inv_pend_complete_date,cp_iar_pend_status_date,mcpu_activity_date,mcviu_activity_date  
  ,cp_vcl_due_date,iar_vcl_due_date
  ,pending_due_vcl_am,vcl_due_date_am,pending_due_vcl_pw,vcl_due_date_pw
  ,o.vcl_due_date override_vcl_due_date,mpt_vcl_due, mio_vcl_due_date    
FROM (SELECT e.*, CASE WHEN e.mpt_complete_date < e.mpt_vcl_due_date THEN e.mpt_vcl_due_date ELSE NULL END mpt_vcl_due
         ,CASE WHEN CAST(cp_vcl_due_date AS DATE) > CAST(cp_inv_pend_complete_date AS DATE) THEN CAST(cp_vcl_due_date AS DATE) ELSE DATEADD(DAY,10,CAST(cp_inv_pend_complete_date AS DATE)) END cp_vcl_due
        -- ,CASE WHEN CAST(iar_vcl_due_date AS DATE) > CAST(cp_iar_pend_status_date AS DATE) THEN CAST(iar_vcl_due_date AS DATE) ELSE DATEADD(DAY,10,CAST(cp_iar_pend_status_date AS DATE)) END iar_vcl_due
         ,DATEADD(DAY,10,cp_iar_pend_status_date)  iar_vcl_due
         ,CASE WHEN manual_cpu_status = 'Waiting for Verification Documents' THEN DATEADD(DAY,10,mcpu_activity_date)  ELSE NULL END mcpu_vcl_due
         ,CASE WHEN manual_cviu_status = 'Waiting for Verification Documents' THEN DATEADD(DAY,10,mcviu_activity_date) ELSE NULL END mcviu_vcl_due         
        FROM coverva_dmas.dmas_raw_application_event_vw e ) e                      
    LEFT JOIN(SELECT DISTINCT tracking_number, vcl_due_date,file_date 
              FROM(SELECT tracking_number,DATEADD(DAY,10,CAST(CONCAT(REPLACE(LEFT(date(initial_review_complete_date),2),'00','20'),RIGHT(date(initial_review_complete_date),8)) AS DATE)) vcl_due_date, CAST(f.file_date AS DATE) file_date, 
                         RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                   FROM coverva_dmas.application_override_full_load o 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
              WHERE rnk = 1 AND vcl_due_date IS NOT NULL) o ON e.tracking_number = o.tracking_number AND e.event_date = o.file_date 
    LEFT JOIN (SELECT tracking_number,current_state,file_inventory_date latest_inventory_date 
               FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                    FROM coverva_dmas.dmas_application da) 
                    WHERE rnk = 1) inv ON e.tracking_number = inv.tracking_number;