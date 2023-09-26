CREATE OR REPLACE VIEW coverva_dmas.dmas_application_last_employee_vw
AS
SELECT da.tracking_number, da.event_date, latest_inventory_date  
                      ,COALESCE(mpt.mpt_worker_name,override_last_employee,cm044_worker_name,mcpu.mcpu_worker_name,air.staff_name,cviu_worker_name,cpui_worker_name,am_worker_name,COALESCE(cpu_worker_name,'blank'),'--') last_employee 
                      ,CASE WHEN o.override_last_employee IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                      ,mpt.mpt_worker_name,override_last_employee,cm044_worker_name,mcpu.mcpu_worker_name,air.staff_name,cviu_worker_name,cpui_worker_name,am_worker_name,COALESCE(cpu_worker_name,'blank') cpu_worker_name
                    FROM (SELECT tracking_number, event_date,latest_inventory_date,latest_record 
                          FROM (SELECT tracking_number,file_inventory_date event_date, RANK() OVER(PARTITION BY tracking_number,file_inventory_date ORDER BY file_inventory_date DESC, dmas_application_id DESC) rnk 
                                    ,FIRST_VALUE(file_inventory_date) OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC, dmas_application_id DESC) latest_inventory_date
                                    ,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) latest_record
                                FROM coverva_dmas.dmas_application ) d  
                           WHERE rnk = 1 ) da  
                      LEFT JOIN (SELECT tracking_number, worker_id, am_worker_name, file_date  
                                 FROM(SELECT tracking_number, worker_id, stf.worker_name am_worker_name,CAST(f.file_date AS DATE) file_date 
                                       ,RANK() OVER(PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY CAST(f.file_date AS DATE) DESC,appmetric_data_id DESC) rnk 
                                      FROM coverva_dmas.app_metric_full_load am  
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)  
                                        LEFT JOIN (SELECT worker_name,ldap ,rnk  
                                                   FROM(SELECT CONCAT(first_name,' ',last_name) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_date DESC) rnk  
                                                        FROM coverva_dmas.mms_ldap_full_load ldap  
                                                         JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename)  
                                                   WHERE rnk = 1) stf ON UPPER(am.worker_id) = UPPER(stf.ldap)) 
                                 WHERE rnk = 1) am ON da.tracking_number = am.tracking_number AND da.event_date = am.file_date 
                      LEFT JOIN(SELECT tracking_number, cpui_worker_name, file_date 
                                FROM(SELECT tracking_number, ldap.worker_name cpui_worker_name,CAST(lf.file_date AS DATE) file_date 
                                       ,RANK() OVER (PARTITION BY tracking_number,CAST(lf.file_date AS DATE) ORDER BY CAST(lf.file_date AS DATE) DESC,cpu_incarcerated_id DESC) rnk  
                                     FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                       JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpui.filename) = UPPER(lf.filename) 
                                       JOIN(SELECT worker_name,ldap  
                                            FROM(SELECT CONCAT(first_name,' ',last_name) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_date DESC) rnk  
                                                 FROM coverva_dmas.mms_ldap_full_load ldap  
                                                   JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = UPPER(lf.filename)) 
                                                 WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cpui.assigned_to))  
                                            WHERE rnk =1) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date 
                      LEFT JOIN(SELECT tracking_number, cviu_worker_name, file_date 
                                FROM(SELECT tracking_number, ldap.worker_name cviu_worker_name,CAST(lf.file_date AS DATE) file_date 
                                       ,RANK() OVER (PARTITION BY tracking_number,CAST(lf.file_date AS DATE) ORDER BY CAST(lf.file_date AS DATE) DESC,cviu_data_id DESC) rnk  
                                     FROM coverva_dmas.cviu_data_full_load cviu  
                                       JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = UPPER(lf.filename)  
                                       JOIN(SELECT worker_name,ldap  
                                            FROM(SELECT CONCAT(first_name,' ',last_name) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_date DESC) rnk  
                                                 FROM coverva_dmas.mms_ldap_full_load ldap  
                                                   JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = UPPER(lf.filename))  
                                            WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cviu.assigned_to)) 
                                     WHERE rnk =1) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date 
                      LEFT JOIN (SELECT tracking_number,cm044_worker_name,file_date  
                                 FROM(SELECT tracking_number,worker_name cm044_worker_name, CAST(f.file_date AS DATE) file_date  
                                        ,RANK() OVER(PARTITION BY cm.tracking_number ORDER BY  CAST(f.file_date AS DATE) DESC, cm044_data_id DESC) rnk  
                                      FROM coverva_dmas.cm044_data_full_load cm  
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename)  
                                        JOIN(SELECT worker_name,ldap  
                                             FROM(SELECT CONCAT(first_name,' ',last_name) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_date DESC) rnk  
                                                  FROM coverva_dmas.mms_ldap_full_load ldap  
                                                    JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename)  
                                                  WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cm.authorized_worker_id) )  
                                 WHERE rnk = 1) cm ON da.tracking_number = cm.tracking_number --AND da.event_date = cm.file_date  
                      LEFT JOIN (SELECT tracking_number,cpu_worker_name,file_date  
                                FROM(SELECT tracking_number,worker_name cpu_worker_name, CAST(f.file_date AS DATE) file_date  
                                       ,RANK() OVER(PARTITION BY cpu.tracking_number,CAST(f.file_date AS DATE) ORDER BY  CAST(f.file_date AS DATE) DESC, cpu_data_id DESC) rnk  
                                     FROM coverva_dmas.cpu_data_full_load cpu  
                                       JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename)  
                                       JOIN(SELECT worker_name,ldap  
                                            FROM(SELECT CONCAT(first_name,' ',last_name) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_date DESC) rnk  
                                                 FROM coverva_dmas.mms_ldap_full_load ldap  
                                                   JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename)  
                                                 WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cpu.assigned_to) )  
                                WHERE rnk = 1) cpu ON da.tracking_number = cpu.tracking_number AND da.event_date = cpu.file_date
                      LEFT JOIN (SELECT DISTINCT tracking_number, override_last_employee,file_date  
                                 FROM(SELECT tracking_number,last_employee override_last_employee, CAST(f.file_date AS DATE) file_date   
                                       ,RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk  
                                      FROM coverva_dmas.application_override_full_load o  
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) )  
                                 WHERE rnk = 1 AND override_last_employee IS NOT NULL) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date
                      LEFT JOIN(SELECT tracking_number,staff_name,complete_task_date,sr_create_date
                                FROM(SELECT tracking_number,complete_task_date,sr_create_date, INITCAP(completed_by_name) staff_name, ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY sr_id DESC) rnk  
                                     FROM coverva_dmas.cp_application_inventory)  
                                WHERE rnk = 1 AND staff_name IS NOT NULL) air  ON da.tracking_number = air.tracking_number --AND da.event_date >= CAST(COALESCE(air.complete_task_date,air.sr_create_date) AS DATE) 
                 LEFT JOIN (SELECT DISTINCT tracking_number,mpt_worker_name,mpt_complete_date                                  
                              FROM(SELECT tracking_number, name mpt_worker_name                                     
                                     ,CAST(completion_time AS DATE) mpt_complete_date
                                     ,ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY completion_time DESC,record_id DESC) rnk 
                                  FROM coverva_dmas.manual_prod_tracker_full_load) 
                              WHERE rnk = 1 ) mpt ON mpt.tracking_number = da.tracking_number --AND da.event_date >= mpt.mpt_complete_date  
               LEFT JOIN (SELECT DISTINCT application_number,mcpu_worker_name,mcpu_activity_date                                    
                              FROM(SELECT application_number,ew mcpu_worker_name                                    
                                     ,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) mcpu_activity_date
                                     ,ROW_NUMBER() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC,record_id DESC) rnk 
                                  FROM coverva_dmas.manual_cpu_tracking) 
                              WHERE rnk = 1) mcpu ON mcpu.application_number = da.tracking_number --AND da.event_date >= mcpu.mcpu_activity_date 
  ;                              