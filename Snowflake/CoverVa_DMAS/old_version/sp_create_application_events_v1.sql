use schema coverva_dmas;
create or replace procedure SP_CREATE_APPLICATION_EVENT(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
                     
       /* Insert events for the date */
       var strSQLText = "INSERT INTO coverva_dmas.dmas_application_event(tracking_number,event_date,in_app_metric,in_app_metric_pw,in_ppit,in_cm043,in_cm044,in_cviu,in_cpu_incarcerated, "
           +"                in_cpu,cpu_status,cpu_app_received_date,cpu_worker,cm044_status,cm044_authorized_date,override_status,cviu_processing_status,cpui_processing_status,pending_due_vcl_pw, "
           +"                pending_due_vcl_am,ppit_worker,cpui_worker,cviu_worker,am_worker,pw_worker,in_app_override,cm044_worker,vcl_due_date_am,vcl_due_date_pw,override_last_employee,"
           +"                override_app_end_date,cm043_status,prev_current_state,prev_app_end_date,running_cpu_status,running_cpu_app_received_date,event_create_date,event_update_date) "
           +" SELECT DISTINCT da.tracking_number, da.event_date "
           +"   ,CASE WHEN am.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_metric "
           +"   ,CASE WHEN pw.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_metric_pw "
           +"   ,CASE WHEN p.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_ppit "
           +"   ,CASE WHEN cmd.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm043 "    
           +"   ,CASE WHEN cm.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm044 "  
           +"   ,CASE WHEN cviu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cviu "  
           +"   ,CASE WHEN cpui.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cpui "
           +"   ,CASE WHEN cpu.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cpu, cpu.cpu_status, cpu.cpu_app_received_date,cpu.cpu_worker "           
           +"   ,cm.cm044_status,cm.cm044_authorized_date,o.override_current_state "
           +"   ,cviu.cviu_processing_status,cpui.cpui_processing_status, pw.pending_due_to_vcl pending_due_vcl_pw "
           +"   ,am.pending_due_to_vcl pending_due_vcl_am,p.worker_id ppit_worker_id,cpui.cpui_worker,cviu.cviu_worker,am.worker_id,pw.worker pw_worker "
           +"   ,CASE WHEN o.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_override "
           +"   ,cm.cm044_worker,am.vcl_due_date_am, pw.vcl_due_date_pw, o.override_last_employee, o.override_app_end_date,cmd.processing_status,da.current_state,da.application_processing_end_date"
           +"   ,rcpu.running_cpu_status,rcpu.running_cpu_app_received_date,current_timestamp(),current_timestamp() "
           +" FROM (SELECT tracking_number, current_state,application_processing_end_date,event_date "
           +"       FROM (SELECT tracking_number,CAST(:1 AS DATE) event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk "
           +"                  ,FIRST_VALUE(file_inventory_date) OVER (PARTITION BY tracking_number ORDER BY file_inventory_date) fv_inventory_date "
           +"                  ,CASE WHEN current_state IS NULL THEN LAG(current_state) OVER(PARTITION BY tracking_number ORDER BY file_inventory_date,dmas_application_id) ELSE current_state END current_state "
           +"                  ,CASE WHEN current_state IS NULL THEN LAG(application_processing_end_date) OVER (PARTITION BY tracking_number ORDER BY file_inventory_date,dmas_application_id) "
           +"                       ELSE application_processing_end_date END application_processing_end_date  "         
           +"             FROM coverva_dmas.dmas_application ) d "
           +"       WHERE rnk = 1 AND event_date >= fv_inventory_date "
           +"       UNION "
           +"       SELECT DISTINCT tracking_number, null current_state,null application_processing_end_date,file_date event_date "
           +"       FROM(SELECT tracking_number, CAST(f.file_date AS DATE) file_date "
           +"             ,RANK() OVER(PARTITION BY cm.tracking_number,f.file_date ORDER BY UPPER(LEFT(cm.status,1))) rnk "
           +"            FROM coverva_dmas.cm044_data_full_load cm "
           +"             JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) "
           +"            WHERE CAST(f.file_date AS DATE) = CAST(:1 AS DATE) "
           +"            AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application da WHERE da.tracking_number = cm.tracking_number and da.file_inventory_date = CAST(f.file_date AS DATE))) "
           +"       WHERE rnk = 1 ) da "
           +"   LEFT JOIN (SELECT DISTINCT tracking_number, worker_id, pending_due_to_vcl,vcl_due_date vcl_due_date_am,CAST(f.file_date AS DATE) file_date "
           +"              FROM coverva_dmas.app_metric_full_load am "
           +"                JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) ) am ON da.tracking_number = am.tracking_number AND da.event_date = am.file_date "
           +"   LEFT JOIN (SELECT DISTINCT tracking_number, worker, pending_due_to_vcl,vcl_due_date vcl_due_date_pw,CAST(f.file_date AS DATE) file_date "
           +"              FROM coverva_dmas.app_metric_pw_full_load pw "
           +"                JOIN coverva_dmas.dmas_file_log f ON UPPER(pw.filename) = UPPER(f.filename)) pw ON da.tracking_number = pw.tracking_number AND da.event_date = pw.file_date "
           +"   LEFT JOIN (SELECT DISTINCT tracking_number, worker_id,CAST(f.file_date AS DATE) file_date "
           +"              FROM coverva_dmas.ppit_data_full_load p "
           +"                JOIN coverva_dmas.dmas_file_log f ON UPPER(p.filename) = UPPER(f.filename)) p ON da.tracking_number = p.tracking_number AND da.event_date = p.file_date "
           +"   LEFT JOIN (SELECT DISTINCT tracking_number,processing_status,CAST(f.file_date AS DATE) file_date "
           +"              FROM coverva_dmas.cm043_data_full_load cmd "
           +"                JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)) cmd ON da.tracking_number = cmd.tracking_number AND da.event_date = cmd.file_date "
           +"   LEFT JOIN (SELECT DISTINCT tracking_number,cm044_status,cm044_authorized_date,file_date,cm044_worker "
           +"              FROM(SELECT tracking_number,status cm044_status,authorized_date cm044_authorized_date,authorized_worker_id cm044_worker, CAST(f.file_date AS DATE) file_date "
           +"                     ,RANK() OVER(PARTITION BY cm.tracking_number,f.file_date ORDER BY UPPER(LEFT(cm.status,1))) rnk "
           +"                   FROM coverva_dmas.cm044_data_full_load cm "
           +"                    JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) ) "
           +"              WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number AND da.event_date = cm.file_date "     
           +"   LEFT JOIN (SELECT DISTINCT tracking_number,assigned_to cviu_worker,processing_status cviu_processing_status, CAST(f.file_date AS DATE) file_date "
           +"              FROM coverva_dmas.cviu_data_full_load cviu "
           +"                JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date "
           +"   LEFT JOIN (SELECT DISTINCT tracking_number,assigned_to cpui_worker,processing_status cpui_processing_status, CAST(f.file_date AS DATE) file_date "
           +"              FROM coverva_dmas.cpu_incarcerated_full_load cpui "
           +"                JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename)) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date "
           +"   LEFT JOIN (SELECT tracking_number,cpu_worker,cpu_status, cpu_app_received_date,file_date "
           +"              FROM(SELECT tracking_number,assigned_to cpu_worker,status cpu_status,app_received_date cpu_app_received_date, CAST(f.file_date AS DATE) file_date "
           +"                      ,ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY f.filename,cpu_data_id) rnk "
           +"                   FROM coverva_dmas.cpu_data_full_load cpu "
           +"                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) ) "
           +"              WHERE rnk = 1) cpu ON da.tracking_number = cpu.tracking_number AND da.event_date = cpu.file_date "           
           +"   LEFT JOIN (SELECT tracking_number,running_cpu_status,running_cpu_app_received_date,file_date "
           +"              FROM(SELECT tracking_number,status running_cpu_status,app_received_date running_cpu_app_received_date, CAST(f.file_date AS DATE) file_date "
           +"                      ,RANK() OVER(PARTITION BY cpu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,UPPER(f.filename),cpu.cpu_data_id DESC) rnk "
           +"                   FROM coverva_dmas.cpu_data_full_load cpu "
           +"                      JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) ) "
           +"              WHERE rnk = 1) rcpu ON da.tracking_number = rcpu.tracking_number AND da.event_date >= rcpu.file_date"
           +"   LEFT JOIN (SELECT DISTINCT tracking_number, override_current_state,override_last_employee,override_app_end_date,file_date "
           +"              FROM(SELECT tracking_number,current_state override_current_state, last_employee override_last_employee, end_date override_app_end_date,CAST(f.file_date AS DATE) file_date " 
           +"                     ,RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk "
           +"                   FROM coverva_dmas.application_override_full_load o "
           +"                     JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) "
           +"              WHERE rnk = 1 AND override_current_state IS NOT NULL) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date " 
           +" WHERE (am.tracking_number IS NOT NULL OR pw.tracking_number IS NOT NULL OR cpu.tracking_number IS NOT NULL OR cpui.tracking_number IS NOT NULL OR cviu.tracking_number IS NOT NULL "
           +"         OR p.tracking_number IS NOT NULL OR cmd.tracking_number IS NOT NULL OR cm.tracking_number IS NOT NULL OR o.tracking_number IS NOT NULL "
           +"         OR COALESCE(da.current_state,'X') NOT IN('Denied','Approved','Transferred to LDSS') OR COALESCE(rcpu.running_cpu_status,'X') != 'Submitted' ) "
           +" AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event ae WHERE ae.tracking_number = da.tracking_number AND ae.event_date = da.event_date);";
         var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
         var ret_value = strSQLStmt.execute();

          strSQLText = "UPDATE coverva_dmas.dmas_application_event dae"
           +" SET cm044_status = cm.cm044_status, cm044_authorized_date = cm.cm044_authorized_date, cm044_worker = cm.cm044_worker, in_cm043 = cm.in_cm043, in_cm044 = cm.in_cm044, cm043_status = cm.processing_status,event_update_date = current_timestamp() "
           +" FROM(SELECT DISTINCT da.tracking_number, da.event_date "          
           +"        ,CASE WHEN cmd.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm043 "    
           +"        ,CASE WHEN cm.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_cm044 "             
           +"        ,cm.cm044_status,cm.cm044_authorized_date "           
           +"        ,cm.cm044_worker,cmd.processing_status "           
           +"      FROM coverva_dmas.dmas_application_event da "           
           +"        LEFT JOIN (SELECT DISTINCT tracking_number,processing_status,CAST(f.file_date AS DATE) file_date "
           +"                   FROM coverva_dmas.cm043_data_full_load cmd "
           +"                      JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)) cmd ON da.tracking_number = cmd.tracking_number AND da.event_date = cmd.file_date "
           +"        LEFT JOIN (SELECT DISTINCT tracking_number,cm044_status,cm044_authorized_date,file_date,cm044_worker "
           +"                   FROM(SELECT tracking_number,status cm044_status,authorized_date cm044_authorized_date,authorized_worker_id cm044_worker, CAST(f.file_date AS DATE) file_date "
           +"                          ,RANK() OVER(PARTITION BY cm.tracking_number,f.file_date ORDER BY UPPER(LEFT(cm.status,1))) rnk "
           +"                       FROM coverva_dmas.cm044_data_full_load cm "
           +"                         JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) ) "
           +"                    WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number AND da.event_date = cm.file_date "
           +"       WHERE da.event_date = CAST(:1 AS DATE) ) cm "                
           +"  WHERE dae.tracking_number = cm.tracking_number AND dae.event_date = cm.event_date ;";
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
         ret_value = strSQLStmt.execute();

      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;