CREATE OR REPLACE VIEW coverva_dmas.dmas_application_v3_vcl_due_date_vw
AS
SELECT inv.tracking_number,e.event_date,inv.latest_inventory_date,inv.dmas_application_id,
  CASE WHEN inv.current_state = 'Waiting for Verification Documents' THEN
    CAST(CASE
              WHEN e.mio_vcl_due IS NOT NULL THEN e.mio_vcl_due              
              WHEN cp_vcl_due IS NOT NULL OR iar_vcl_due IS NOT NULL 
                THEN GREATEST(COALESCE(cp_vcl_due,iar_vcl_due),COALESCE(iar_vcl_due,cp_vcl_due) )
              WHEN o.vcl_due_date IS NOT NULL THEN o.vcl_due_date
            ELSE NULL END AS DATE)
   ELSE NULL END final_vcl_due_date            
  ,cp_inv_pend_complete_date,cp_iar_pend_status_date
  ,cp_vcl_due_date,iar_vcl_due_date  
  ,o.vcl_due_date override_vcl_due_date
  ,mio_vcl_due    
FROM (SELECT tracking_number,current_state,file_inventory_date latest_inventory_date,dmas_application_id
      FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
           FROM coverva_dmas.dmas_application_v3_inventory da) 
      WHERE rnk = 1) inv
   LEFT JOIN(SELECT e.* 
         ,CASE WHEN CAST(cp_vcl_due_date AS DATE) > CAST(cp_inv_pend_complete_date AS DATE) THEN CAST(cp_vcl_due_date AS DATE) ELSE DATEADD(DAY,10,CAST(cp_inv_pend_complete_date AS DATE)) END cp_vcl_due        
         ,DATEADD(DAY,10,cp_iar_pend_status_date)  iar_vcl_due
         ,CASE WHEN mio_prod_status = 'Waiting for Verification Documents' THEN mio_vcl_due_date
               WHEN mio_term_state = 'Waiting for Verification Documents' THEN mio_term_vcl_due_date ELSE NULL END mio_vcl_due         
        FROM coverva_dmas.dmas_raw_application_v3_event_vw e ) e ON e.tracking_number = inv.tracking_number                      
    LEFT JOIN(SELECT DISTINCT tracking_number, vcl_due_date,file_date 
              FROM(SELECT tracking_number,DATEADD(DAY,10,CAST(CONCAT(REPLACE(LEFT(date(initial_review_complete_date),2),'00','20'),RIGHT(date(initial_review_complete_date),8)) AS DATE)) vcl_due_date, CAST(f.file_date AS DATE) file_date, 
                         RANK() OVER(PARTITION BY tracking_number ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                   FROM coverva_dmas.application_override_full_load o 
                     JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
              WHERE rnk = 1 AND vcl_due_date IS NOT NULL) o ON e.tracking_number = o.tracking_number AND e.event_date >= o.file_date 
   ;