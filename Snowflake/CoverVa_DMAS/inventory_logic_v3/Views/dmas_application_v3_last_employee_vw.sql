CREATE OR REPLACE VIEW COVERVA_DMAS.DMAS_APPLICATION_V3_LAST_EMPLOYEE_VW
AS
WITH lemp AS(
SELECT e.tracking_number, e.event_date,inv.latest_inventory_date  
  ,e.override_last_employee
  ,CASE WHEN REGEXP_INSTR(am_worker_id, '900') = 0 THEN 'non-900'
        WHEN e.am_worker_id IS NOT NULL AND amstf.am_worker_name IS NULL THEN 'not maximus' ELSE amstf.am_worker_name END am_worker_name
  ,CASE WHEN REGEXP_INSTR(cm_worker, '900') = 0 THEN 'non-900'
        WHEN e.cm_worker IS NOT NULL AND cm44st.cm044_worker_name IS NULL THEN 'not maximus' ELSE cm44st.cm044_worker_name END cm044_worker_name
  ,CASE WHEN REGEXP_INSTR(e.mio_last_employee, '900') = 0 THEN 'non-900'
        WHEN e.mio_last_employee IS NOT NULL AND miost.mio_worker_name IS NULL THEN 'not maximus' ELSE miost.mio_worker_name END mio_worker_name        
  ,cp_inv_ldss_worker,cp_iar_ldss_worker,cp_inv_ad_worker,cp_iar_ad_worker,cp_inv_pend_worker,cp_iar_pend_worker  
  ,completed_by_name cp_last_employee,e.cviu_liaison_worker
  ,inv.dmas_application_id
FROM coverva_dmas.dmas_raw_application_v3_event_vw e
  LEFT JOIN (SELECT tracking_number,dmas_application_id,file_inventory_date latest_inventory_date 
                            FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                 FROM coverva_dmas.dmas_application_v3_inventory da) 
                            WHERE rnk = 1) inv ON e.tracking_number = inv.tracking_number 
  LEFT JOIN (SELECT worker_name am_worker_name,ldap ,rnk  
             FROM coverva_dmas.dmas_mms_ldap_full_load_vw ldap 
             WHERE rnk = 1) amstf ON UPPER(e.am_worker_id) = UPPER(amstf.ldap) 
  LEFT JOIN (SELECT worker_name cm044_worker_name,ldap ,rnk  
             FROM coverva_dmas.dmas_mms_ldap_full_load_vw 
             WHERE rnk = 1) cm44st ON UPPER(e.cm_worker) = UPPER(cm44st.ldap)  
  LEFT JOIN (SELECT worker_name mio_worker_name,ldap ,rnk  
             FROM coverva_dmas.dmas_mms_ldap_full_load_vw  
             WHERE rnk = 1) miost ON UPPER(e.mio_last_employee) = UPPER(miost.ldap)             
  LEFT JOIN(SELECT *
              FROM(SELECT tracking_number,cp_inv_status_date,completed_by_name,ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY cp_inv_status_date DESC) rnk
                   FROM(SELECT tracking_number,cp_inv_status_date,completed_by_name
                        FROM (SELECT tracking_number,CAST(COALESCE(complete_task_date,sr_status_date) AS DATE) cp_inv_status_date,INITCAP(completed_by_name) completed_by_name,RANK() OVER(PARTITION BY tracking_number ORDER BY COALESCE(complete_task_date,sr_status_date) DESC,sr_id DESC) rnk
                              FROM coverva_dmas.cp_application_inventory 
                              WHERE completed_by_name IS NOT NULL)
                        WHERE rnk = 1
                  UNION
                  SELECT tracking_number,cp_iar_status_date,completed_by_name
                  FROM (SELECT tracking_number,completed_by_name,CAST(status_date AS DATE) cp_iar_status_date,RANK() OVER(PARTITION BY tracking_number ORDER BY status_date DESC,task_id DESC) rnk
                        FROM coverva_dmas.cp_initial_application_review 
                        WHERE completed_by_name IS NOT NULL)
                  WHERE rnk = 1)) 
              WHERE rnk = 1) cp ON cp.tracking_number = e.tracking_number AND e.event_date >= cp.cp_inv_status_date 
)
SELECT lemp.*,
COALESCE(mio_worker_name,override_last_employee,cm044_worker_name,cp_last_employee,am_worker_name,'--') last_employee       
FROM lemp;  
