update dmas_application_current
set case_type = 'Application'
where case_type is null;

update dmas_application
set case_type = 'Application'
where case_type is null;

INSERT INTO coverva_dmas.dmas_application_v2_inventory(tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
                                                       last_employee,applicant_name,case_number,override_value_indicator,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,
                                                       initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,
                                                       state_app_received_date,cp_application_type,dmas_application_id,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,vcl_sent_date,case_type,sd_stage,
                                                       renewal_closure_date,auto_closure_date,denial_reason)
SELECT tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
  last_employee,applicant_name,case_number,override_value_indicator,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,
  initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,
  state_app_received_date,cp_application_type,dmas_application_id,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,vcl_sent_date,case_type,sd_stage,
  renewal_closure_date,auto_closure_date,denial_reason
FROM coverva_dmas.dmas_application;


INSERT INTO coverva_dmas.dmas_application_v2_current(tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
                                                     last_employee,applicant_name,case_number,override_value_indicator,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,
                                                     initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,
                                                     state_app_received_date,cp_application_type,dmas_application_current_id,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,vcl_sent_date,
                                                     case_type,sd_stage,renewal_closure_date,auto_closure_date,denial_reason)
SELECT tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
  last_employee,applicant_name,case_number,override_value_indicator,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,
  initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,
  state_app_received_date,cp_application_type,dmas_application_current_id,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,vcl_sent_date,
  case_type,sd_stage,renewal_closure_date,auto_closure_date,denial_reason
FROM coverva_dmas.dmas_application_current;
