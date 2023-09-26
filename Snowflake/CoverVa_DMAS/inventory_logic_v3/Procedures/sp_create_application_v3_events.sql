use schema coverva_dmas;
create or replace procedure SP_CREATE_APPLICATION_V3_EVENT(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
                     
       /* Insert events for the date */
       var strSQLText = `INSERT INTO coverva_dmas.dmas_application_v3_event(tracking_number,event_date,case_type,in_app_metric,in_running_app_metric,in_cm043,in_running_cm043,in_rp190,in_running_rp190,
                                 am_worker_id,running_am_worker_id,am_wid_in_ldap,
                                 sd_stage,cm_status,cm_authorized_date,cm_worker,override_status,override_last_employee,override_app_end_date,
                                 cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker,cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,
                                 cp_iar_ldss_worker,cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker,cp_iar_ad_disposition,cp_iar_ad_created_on,
                                 cp_iar_ad_status_date,cp_iar_ad_worker,cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker,cp_vcl_due_date,
                                 cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date,cp_iar_pend_worker,iar_vcl_due_date,
                                 rp265_sending_agency,rp265_transfer_date,rp266_sending_agency,rp266_transfer_date,rp269_vcl_generation_date,rp270_vcl_generation_date,
                                 mio_prod_status,mio_orig_status,mio_complete_date,mio_last_employee,mio_vcl_due_date,mio_update_date,mio_term_last_employee,mio_term_orig_status,mio_term_complete_date,
                                 mio_term_update_date,mio_term_vcl_due_date,mio_term_state,am_processing_unit,running_am_processing_unit,am_ldss_date,running_am_ldss_date,
                                 in_cviu_liaison,in_running_cviu_liaison,cviu_liaison_worker,
                                 manual_cviu_status,manual_cpu_status,mcviu_activity_date,mcpu_activity_date)
                         SELECT tracking_number,event_date,case_type,in_app_metric,in_running_app_metric,in_cm043,in_running_cm043,in_rp190,in_running_rp190,am_worker_id,running_am_worker_id,am_wid_in_ldap,
                              sd_stage,cm_status,cm_authorized_date,cm_worker,override_current_state,override_last_employee,override_app_end_date,
                              cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker,cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,
                              cp_iar_ldss_worker,cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker,cp_iar_ad_disposition,cp_iar_ad_created_on,
                              cp_iar_ad_status_date,cp_iar_ad_worker,cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker,cp_vcl_due_date,
                              cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date,cp_iar_pend_worker,iar_vcl_due_date,
                              rp265_sending_agency,rp265_transfer_date,rp266_sending_agency,rp266_transfer_date,rp269_vcl_generation_date,rp270_vcl_generation_date,
                              mio_prod_status,mio_orig_status,mio_complete_date,mio_last_employee,mio_vcl_due_date,mio_update_date,mio_term_last_employee,mio_term_orig_status,mio_term_complete_date,
                              mio_term_update_date,mio_term_vcl_due_date,mio_term_state,am_processing_unit,running_am_processing_unit,am_ldss_date,running_am_ldss_date,
                              in_cviu_liaison,in_running_cviu_liaison,cviu_liaison_worker,
                              manual_cviu_status,manual_cpu_status,mcviu_activity_date,mcpu_activity_date
                         FROM coverva_dmas.dmas_raw_application_v3_event_vw v
                         WHERE event_date = CAST(:1 AS DATE)            
                         AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_event e WHERE e.tracking_number = v.tracking_number AND e.event_date = v.event_date);`;
         var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
         var ret_value = strSQLStmt.execute();

          strSQLText = `UPDATE coverva_dmas.dmas_application_v3_event dae 
            SET dae.tracking_number = cm.tracking_number,
               dae.event_date = cm.event_date,
               dae.case_type = cm.case_type,
               dae.in_app_metric = cm.in_app_metric,
               dae.in_running_app_metric = cm.in_running_app_metric,
               dae.in_cm043 = cm.in_cm043,
               dae.in_running_cm043 = cm.in_running_cm043,
               dae.in_rp190 = cm.in_rp190,
               dae.in_running_rp190 = cm.in_running_rp190,
               dae.am_worker_id = cm.am_worker_id,
               dae.running_am_worker_id = cm.running_am_worker_id,
               dae.am_wid_in_ldap = cm.am_wid_in_ldap,
               dae.sd_stage = cm.sd_stage,
               dae.cm_status = cm.cm_status,
               dae.cm_authorized_date = cm.cm_authorized_date,
               dae.cm_worker = cm.cm_worker,
               dae.override_status = cm.override_current_state,
               dae.override_last_employee = cm.override_last_employee,
               dae.override_app_end_date = cm.override_app_end_date,
               dae.cp_inv_action_taken = cm.cp_inv_action_taken,
               dae.cp_inv_ldss_create_date = cm.cp_inv_ldss_create_date,
               dae.cp_inv_ldss_status_date = cm.cp_inv_ldss_status_date,
               dae.cp_inv_ldss_end_date = cm.cp_inv_ldss_end_date,
               dae.cp_inv_ldss_worker = cm.cp_inv_ldss_worker,
               dae.cp_iar_action_taken = cm.cp_iar_action_taken,
               dae.cp_iar_ldss_created_on = cm.cp_iar_ldss_created_on,
               dae.cp_iar_ldss_end_date = cm.cp_iar_ldss_end_date,
               dae.cp_iar_ldss_worker = cm.cp_iar_ldss_worker,
               dae.cp_inv_ad_disposition = cm.cp_inv_ad_disposition,
               dae.cp_inv_ad_create_date = cm.cp_inv_ad_create_date,
               dae.cp_inv_ad_status_date = cm.cp_inv_ad_status_date,
               dae.cp_inv_ad_complete_date = cm.cp_inv_ad_complete_date,
               dae.cp_inv_ad_worker = cm.cp_inv_ad_worker,
               dae.cp_iar_ad_disposition = cm.cp_iar_ad_disposition,
               dae.cp_iar_ad_created_on = cm.cp_iar_ad_created_on,
               dae.cp_iar_ad_status_date = cm.cp_iar_ad_status_date,
               dae.cp_iar_ad_worker = cm.cp_iar_ad_worker,
               dae.cp_inv_pend_disposition = cm.cp_inv_pend_disposition,
               dae.cp_inv_pend_create_date = cm.cp_inv_pend_create_date,
               dae.cp_inv_pend_status_date = cm.cp_inv_pend_status_date,
               dae.cp_inv_pend_complete_date = cm.cp_inv_pend_complete_date,
               dae.cp_inv_pend_worker = cm.cp_inv_pend_worker,
               dae.cp_vcl_due_date = cm.cp_vcl_due_date,
               dae.cp_iar_pend_disposition = cm.cp_iar_pend_disposition,
               dae.cp_iar_pend_created_on = cm.cp_iar_pend_created_on,
               dae.cp_iar_pend_status_date = cm.cp_iar_pend_status_date,
               dae.cp_iar_pend_worker = cm.cp_iar_pend_worker,
               dae.iar_vcl_due_date = cm.iar_vcl_due_date,
               dae.rp265_sending_agency = cm.rp265_sending_agency,
               dae.rp265_transfer_date = cm.rp265_transfer_date,
               dae.rp266_sending_agency = cm.rp266_sending_agency,
               dae.rp266_transfer_date = cm.rp266_transfer_date,
               dae.rp269_vcl_generation_date = cm.rp269_vcl_generation_date,
               dae.rp270_vcl_generation_date = cm.rp270_vcl_generation_date,
               dae.mio_prod_status = cm.mio_prod_status,
               dae.mio_orig_status = cm.mio_orig_status,
               dae.mio_complete_date = cm.mio_complete_date,
               dae.mio_last_employee = cm.mio_last_employee,
               dae.mio_vcl_due_date = cm.mio_vcl_due_date,
               dae.mio_update_date = cm.mio_update_date,
               dae.mio_term_last_employee = cm.mio_term_last_employee,
               dae.mio_term_orig_status = cm.mio_term_orig_status,
               dae.mio_term_complete_date = cm.mio_term_complete_date,
               dae.mio_term_update_date = cm.mio_term_update_date,
               dae.mio_term_vcl_due_date = cm.mio_term_vcl_due_date,
               dae.mio_term_state = cm.mio_term_state,
               dae.am_processing_unit = cm.am_processing_unit,
               dae.running_am_processing_unit = cm.running_am_processing_unit,
               dae.am_ldss_date = cm.am_ldss_date,
               dae.running_am_ldss_date = cm.running_am_ldss_date,
               dae.in_cviu_liaison = cm.in_cviu_liaison,
               dae.in_running_cviu_liaison = cm.in_running_cviu_liaison,
               dae.cviu_liaison_worker = cm.cviu_liaison_worker,               
               dae.manual_cviu_status = cm.manual_cviu_status,
               dae.manual_cpu_status = cm.manual_cpu_status,
               dae.mcviu_activity_date = cm.mcviu_activity_date,
               dae.mcpu_activity_date = cm.mcpu_activity_date
            FROM(SELECT tracking_number,event_date,case_type,in_app_metric,in_running_app_metric,in_cm043,in_running_cm043,in_rp190,in_running_rp190,am_worker_id,running_am_worker_id,am_wid_in_ldap,
                              sd_stage,cm_status,cm_authorized_date,cm_worker,override_current_state,override_last_employee,override_app_end_date,
                              cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker,cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,
                              cp_iar_ldss_worker,cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker,cp_iar_ad_disposition,cp_iar_ad_created_on,
                              cp_iar_ad_status_date,cp_iar_ad_worker,cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker,cp_vcl_due_date,
                              cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date,cp_iar_pend_worker,iar_vcl_due_date,
                              rp265_sending_agency,rp265_transfer_date,rp266_sending_agency,rp266_transfer_date,rp269_vcl_generation_date,rp270_vcl_generation_date,
                              mio_prod_status,mio_orig_status,mio_complete_date,mio_last_employee,mio_vcl_due_date,mio_update_date,mio_term_last_employee,mio_term_orig_status,mio_term_complete_date,
                              mio_term_update_date,mio_term_vcl_due_date,mio_term_state,am_processing_unit,running_am_processing_unit,am_ldss_date,running_am_ldss_date,
                              in_cviu_liaison,in_running_cviu_liaison,cviu_liaison_worker,manual_cviu_status,manual_cpu_status,mcviu_activity_date,mcpu_activity_date
                         FROM coverva_dmas.dmas_raw_application_v3_event_vw v
                         WHERE event_date = CAST(:1 AS DATE)  ) cm                 
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