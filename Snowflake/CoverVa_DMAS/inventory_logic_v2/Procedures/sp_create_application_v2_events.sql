use schema coverva_dmas;
create or replace procedure SP_CREATE_APPLICATION_V2_EVENT(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
                     
       /* Insert events for the date */
       var strSQLText = `INSERT INTO coverva_dmas.dmas_application_v2_event(tracking_number,event_date,in_app_metric,in_app_metric_pw,in_ppit,in_cm043,in_cm044,in_cviu,in_cpu_incarcerated, 
                           in_cpu,cpu_status,cpu_app_received_date,cpu_worker,cm044_status,cm044_authorized_date,override_status,cviu_processing_status,cpui_processing_status,pending_due_vcl_pw, 
                           pending_due_vcl_am,ppit_worker,cpui_worker,cviu_worker,am_worker,pw_worker,in_app_override,cm044_worker,vcl_due_date_am,vcl_due_date_pw,override_last_employee,
                           override_app_end_date,cm043_status,prev_current_state,prev_app_end_date,running_cpu_status,running_cpu_app_received_date, 
                           cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker, 
                           cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,               
                           cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker, 
                           cp_iar_ad_disposition,cp_iar_ad_created_on,cp_iar_ad_status_date, 
                           cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker, 
                           cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date, 
                           manual_cpu_status,mcpu_activity_date,mcpu_last_employee, 
                           manual_cviu_status,mcviu_activity_date, 
                           manual_prod_status,mpt_orig_status,mpt_complete_date,mpt_last_employee,event_create_date,event_update_date, 
                           running_cpu_worker,running_cpu_file_date,mpt_vcl_due_date,cp_vcl_due_date,iar_vcl_due_date, 
                           running_am_worker,running_ppit_worker,running_cviu_worker,running_cviu_status, 
                           running_cpui_worker,running_cpui_status,in_running_am,in_running_ppit,in_running_pw, 
                           in_running_cm043,in_running_cviu,in_running_cpui,in_running_cpu, 
                           mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee,mio_vcl_due_date,case_type,sd_stage)            
            SELECT tracking_number,event_date,in_app_metric,in_app_metric_pw,in_ppit,in_cm043,in_cm044,in_cviu,in_cpui, 
                           in_cpu,cpu_status,cpu_app_received_date,cpu_worker, 
                           cm044_status,cm044_authorized_date,override_current_state,cviu_processing_status,cpui_processing_status,pending_due_vcl_pw, 
                           pending_due_vcl_am,ppit_worker_id,cpui_worker,cviu_worker,worker_id am_worker,pw_worker,in_override, 
                           cm044_worker,vcl_due_date_am,vcl_due_date_pw,override_last_employee, 
                           override_app_end_date,processing_status cm043_status,prev_current_state,prev_end_date,running_cpu_status,running_cpu_app_received_date,  
                           cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker, 
                           cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,                
                           cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker, 
                           cp_iar_ad_disposition,cp_iar_ad_created_on,cp_iar_ad_status_date, 
                           cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker, 
                           cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date, 
                           manual_cpu_status,mcpu_activity_date,mcpu_last_employee, 
                           manual_cviu_status,mcviu_activity_date, 
                           manual_prod_status,mpt_orig_status,mpt_complete_date,mpt_last_employee,current_timestamp(),current_timestamp(), 
                           running_cpu_worker,running_cpu_file_date,mpt_vcl_due_date,cp_vcl_due_date,iar_vcl_due_date, 
                           running_am_worker,running_ppit_worker,running_cviu_worker,running_cviu_status, 
                           running_cpui_worker,running_cpui_status,in_running_am,in_running_ppit,in_running_pw, 
                           in_running_cm043,in_running_cviu,in_running_cpui,in_running_cpu, 
                           mio_prod_status,mio_orig_status,mio_complete_date ,mio_last_employee,mio_vcl_due_date,case_type,sd_stage 
            FROM coverva_dmas.dmas_raw_application_v2_event_vw v 
            WHERE event_date = CAST(:1 AS DATE)            
            AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v2_event e WHERE e.tracking_number = v.tracking_number AND e.event_date = v.event_date);`;
         var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
         var ret_value = strSQLStmt.execute();

          strSQLText = `UPDATE coverva_dmas.dmas_application_v2_event dae 
            SET dae.in_app_metric = cm.in_app_metric, dae.in_app_metric_pw = cm.in_app_metric_pw, dae.in_ppit = cm.in_ppit, 
                dae.in_cm043 = cm.in_cm043, dae.in_cm044 = cm.in_cm044, dae.in_cviu = cm.in_cviu, dae.in_cpu_incarcerated = cm.in_cpui, 
                dae.in_cpu = cm.in_cpu, dae.cpu_status = cm.cpu_status, dae.cpu_app_received_date = cm.cpu_app_received_date, dae.cpu_worker = cm.cpu_worker, 
                dae.cm044_status = cm.cm044_status, dae.cm044_authorized_date = cm.cm044_authorized_date, dae.override_status = cm.override_current_state, 
                dae.cviu_processing_status = cm.cviu_processing_status, dae.cpui_processing_status = cm.cpui_processing_status, dae.pending_due_vcl_pw = cm.pending_due_vcl_pw, 
                dae.pending_due_vcl_am = cm.pending_due_vcl_am, dae.ppit_worker = cm.ppit_worker_id,dae.cpui_worker = cm.cpui_worker, 
                dae.cviu_worker = cm.cviu_worker, dae.am_worker = cm.am_worker, dae.pw_worker = cm.pw_worker, 
                dae.in_app_override = cm.in_override, dae.cm044_worker = cm.cm044_worker, dae.vcl_due_date_am = cm.vcl_due_date_am, 
                dae.vcl_due_date_pw = cm.vcl_due_date_pw, dae.override_last_employee = cm.override_last_employee, dae.override_app_end_date = cm.override_app_end_date, 
                dae.cm043_status = cm.cm043_status, dae.prev_current_state = cm.prev_current_state, dae.prev_app_end_date = cm.prev_end_date, 
                dae.running_cpu_status = cm.running_cpu_status, dae.running_cpu_app_received_date = cm.running_cpu_app_received_date, dae.cp_inv_action_taken = cm.cp_inv_action_taken,
                dae.cp_inv_ldss_create_date = cm.cp_inv_ldss_create_date, dae.cp_inv_ldss_status_date = cm.cp_inv_ldss_status_date, dae.cp_inv_ldss_end_date = cm.cp_inv_ldss_end_date, 
                dae.cp_inv_ldss_worker = cm.cp_inv_ldss_worker, dae.cp_iar_action_taken = cm.cp_iar_action_taken, dae.cp_iar_ldss_created_on = cm.cp_iar_ldss_created_on,               
                dae.cp_iar_ldss_end_date = cm.cp_iar_ldss_end_date, dae.cp_inv_ad_disposition = cm.cp_inv_ad_disposition, dae.cp_inv_ad_create_date = cm.cp_inv_ad_create_date, 
                dae.cp_inv_ad_status_date = cm.cp_inv_ad_status_date, dae.cp_inv_ad_complete_date = cm.cp_inv_ad_complete_date, dae.cp_inv_ad_worker = cm.cp_inv_ad_worker, 
                dae.cp_iar_ad_disposition = cm.cp_iar_ad_disposition, dae.cp_iar_ad_created_on = cm.cp_iar_ad_created_on, dae.cp_iar_ad_status_date = cm.cp_iar_ad_status_date, 
                dae.cp_inv_pend_disposition = cm.cp_inv_pend_disposition, dae.cp_inv_pend_create_date = cm.cp_inv_pend_create_date, dae.cp_inv_pend_status_date = cm.cp_inv_pend_status_date, 
                dae.cp_inv_pend_complete_date = cm.cp_inv_pend_complete_date, dae.cp_inv_pend_worker = cm.cp_inv_pend_worker, dae.cp_iar_pend_disposition = cm.cp_iar_pend_disposition, 
                dae.cp_iar_pend_created_on = cm.cp_iar_pend_created_on, dae.cp_iar_pend_status_date = cm.cp_iar_pend_status_date, 
                dae.manual_cpu_status = cm.manual_cpu_status, dae.mcpu_activity_date = cm.mcpu_activity_date, dae.mcpu_last_employee = cm.mcpu_last_employee, 
                dae.manual_cviu_status = cm.manual_cviu_status, dae.mcviu_activity_date = cm.mcviu_activity_date, 
                dae.manual_prod_status = cm.manual_prod_status, dae.mpt_orig_status = cm.mpt_orig_status, dae.mpt_complete_date = cm.mpt_complete_date, 
                dae.mpt_last_employee = cm.mpt_last_employee ,dae.event_update_date = current_timestamp(), 
                dae.running_cpu_worker = cm.running_cpu_worker, dae.running_cpu_file_date = cm.running_cpu_file_date, 
                dae.mpt_vcl_due_date = cm.mpt_vcl_due_date, dae.cp_vcl_due_date = cm.cp_vcl_due_date, 
                dae.iar_vcl_due_date = cm.iar_vcl_due_date, dae.running_am_worker = cm.running_am_worker, 
                dae.running_ppit_worker = cm.running_ppit_worker, dae.running_cviu_worker = cm.running_cviu_worker, 
                dae.running_cviu_status = cm.running_cviu_status, dae.running_cpui_worker = cm.running_cpui_worker, 
                dae.running_cpui_status = cm.running_cpui_status, dae.in_running_am = cm.in_running_am, 
                dae.in_running_ppit = cm.in_running_ppit, dae.in_running_pw = cm.in_running_pw,    
                dae.in_running_cm043 = cm.in_running_cm043, dae.in_running_cviu = cm.in_running_cviu,dae.in_running_cpui = cm.in_running_cpui,dae.in_running_cpu = cm.in_running_cpu, 
                dae.mio_prod_status = cm.mio_prod_status, dae.mio_orig_status = cm.mio_orig_status, dae.mio_complete_date = cm.mio_complete_date, 
                dae.mio_last_employee = cm.mio_last_employee, dae.mio_vcl_due_date = cm.mio_vcl_due_date,
                dae.case_type = cm.case_type,dae.sd_stage = cm.sd_stage
            FROM(SELECT tracking_number,event_date,in_app_metric,in_app_metric_pw,in_ppit,in_cm043,in_cm044,in_cviu,in_cpui, 
                           in_cpu,cpu_status,cpu_app_received_date,cpu_worker, 
                           cm044_status,cm044_authorized_date,override_current_state,cviu_processing_status,cpui_processing_status,pending_due_vcl_pw, 
                           pending_due_vcl_am,ppit_worker_id,cpui_worker,cviu_worker,worker_id am_worker,pw_worker,in_override, 
                           cm044_worker,vcl_due_date_am,vcl_due_date_pw,override_last_employee, 
                           override_app_end_date,processing_status cm043_status,prev_current_state,prev_end_date,running_cpu_status,running_cpu_app_received_date,  
                           cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker, 
                           cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,                
                           cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker, 
                           cp_iar_ad_disposition,cp_iar_ad_created_on,cp_iar_ad_status_date, 
                           cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker, 
                           cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date, 
                           manual_cpu_status,mcpu_activity_date,mcpu_last_employee, 
                           manual_cviu_status,mcviu_activity_date, 
                           manual_prod_status,mpt_orig_status,mpt_complete_date,mpt_last_employee, 
                           running_cpu_worker,running_cpu_file_date,mpt_vcl_due_date,cp_vcl_due_date,iar_vcl_due_date, 
                           running_am_worker,running_ppit_worker,running_cviu_worker,running_cviu_status, 
                           running_cpui_worker,running_cpui_status,in_running_am,in_running_ppit,in_running_pw, 
                           in_running_cm043,in_running_cviu,in_running_cpui,in_running_cpu, 
                           mio_prod_status,mio_orig_status,mio_complete_date,mio_last_employee,mio_vcl_due_date,case_type,sd_stage 
                FROM coverva_dmas.dmas_raw_application_v2_event_vw v 
                WHERE event_date = CAST(:1 AS DATE) ) cm                 
             WHERE dae.tracking_number = cm.tracking_number AND dae.event_date = cm.event_date;`;
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
         ret_value = strSQLStmt.execute();

      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;