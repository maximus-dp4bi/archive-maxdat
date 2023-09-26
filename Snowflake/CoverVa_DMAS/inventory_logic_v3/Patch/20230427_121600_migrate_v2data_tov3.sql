UPDATE dmas_file_Load_lkup
SET use_in_v3_inventory = 'Y'
WHERE filename_prefix in('RP274','APPMETRIC_REPORT','CM_043','AUTO_CLOSURE_REPORT','CM_044','RUNNING_MASTER_OVERRIDE');

UPDATE coverva_dmas.dmas_file_load_lkup
SET select_fields = 'source,name,physical_address,locality,filename,CASE WHEN LENGTH(date_received) > 8 THEN TRY_TO_DATE(date_received,''mm/dd/yyyy'') ELSE TRY_TO_DATE(date_received,''mm/dd/yy'') END AS date_received,processing_status,REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),application_type'
WHERE filename_prefix = 'CM_043';

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_V3_FILE_DATE','03/09/2023','D',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_V3_SWITCH','N','V',current_timestamp(),current_timestamp());

UPDATE dmas_file_log da
SET cdc_v3_processed = cdc_v2_processed,cdc_v3_processed_date = cdc_v2_processed_date
FROM(SELECT d.file_id
     FROM dmas_file_log d
      JOIN dmas_file_load_lkup l on d.filename_prefix = l.filename_prefix
     WHERE l.use_in_v3_inventory = 'Y'
      OR d.filename_prefix = 'CM_044') d
WHERE da.file_id = d.file_id;

--Bump the sequences before migrating data?

--CM44 migrate data from existing CM44 to the new table CM_PROCESSING_TIME_FULL_LOAD
INSERT INTO cm_processing_time_full_load(tracking_number,case_number,source,locality,status,denial_closure_reason,aid_category,application_date,authorized_date,number_of_days,authorized_worker_id,ma_pregnancy_indicator,
                                        processing_unit,authorized_office,filename,filename_prefix)
SELECT tracking_number,case_number,source,locality,status,NULL denial_closure_reason,NULL aid_category,application_date,authorized_date,number_of_days,authorized_worker_id,potential_pregnancy,
processing_unit,authorized_office,filename,SUBSTR(filename,1,6) filename_prefix
FROM cm044_data_full_load f
WHERE NOT EXISTS(SELECT 1 FROM cm_processing_time_full_load l WHERE f.tracking_number = l.tracking_number AND UPPER(f.filename) = UPPER(l.filename))
ORDER BY cm044_data_id;

--App Inv/Current/Events Tables  --Migrate current data from V2 into V3 tables

INSERT INTO coverva_dmas.dmas_application_v3_event(tracking_number,event_date,case_type,in_app_metric,in_running_app_metric,in_cm043,in_running_cm043,in_rp190,in_running_rp190,
                                 am_worker_id,running_am_worker_id,am_wid_in_ldap,
                                 sd_stage,cm_status,cm_authorized_date,cm_worker,override_status,override_last_employee,override_app_end_date,
                                 cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker,cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,
                                 cp_iar_ldss_worker,cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker,cp_iar_ad_disposition,cp_iar_ad_created_on,
                                 cp_iar_ad_status_date,cp_iar_ad_worker,cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker,cp_vcl_due_date,
                                 cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date,cp_iar_pend_worker,iar_vcl_due_date,
                                 rp265_sending_agency,rp265_transfer_date,rp266_sending_agency,rp266_transfer_date,rp269_vcl_generation_date,rp270_vcl_generation_date,
                                 mio_prod_status,mio_orig_status,mio_complete_date,mio_last_employee,mio_vcl_due_date,mio_update_date,mio_term_last_employee,mio_term_orig_status,mio_term_complete_date,
                                 mio_term_update_date,mio_term_vcl_due_date,mio_term_state,previous_current_state,previous_end_date,manual_cviu_status,manual_cpu_status,mcviu_activity_date,mcpu_activity_date)
select tracking_number, event_date, case_type,in_app_metric,in_running_am in_running_app_metric,in_cm043,in_running_cm043,'N' in_rp190, 'N' in_running_rp190,am_worker am_worker_id,running_am_worker running_am_worker_id,
 CASE WHEN ldap IS NOT NULL THEN 'Y' ELSE 'N' END am_wid_in_ldap,
 sd_stage,cm044_status cm_status,cm044_authorized_date cm_authorized_date,cm044_worker cm_worker,override_status override_current_state,override_last_employee,override_app_end_date,
 cp_inv_action_taken,cp_inv_ldss_create_date,cp_inv_ldss_status_date,cp_inv_ldss_end_date,cp_inv_ldss_worker,cp_iar_action_taken,cp_iar_ldss_created_on,cp_iar_ldss_end_date,
 NULL cp_iar_ldss_worker,cp_inv_ad_disposition,cp_inv_ad_create_date,cp_inv_ad_status_date,cp_inv_ad_complete_date,cp_inv_ad_worker,cp_iar_ad_disposition,cp_iar_ad_created_on,
 cp_iar_ad_status_date,NULL cp_iar_ad_worker,cp_inv_pend_disposition,cp_inv_pend_create_date,cp_inv_pend_status_date,cp_inv_pend_complete_date,cp_inv_pend_worker,cp_vcl_due_date,
 cp_iar_pend_disposition,cp_iar_pend_created_on,cp_iar_pend_status_date,NULL cp_iar_pend_worker,iar_vcl_due_date,
 NULL rp265_sending_agency,NULL rp265_transfer_date,NULL rp266_sending_agency,NULL rp266_transfer_date,NULL rp269_vcl_generation_date,NULL rp270_vcl_generation_date,
 mio_prod_status,mio_orig_status,mio_complete_date,mio_last_employee,mio_vcl_due_date,NULL mio_update_date,NULL mio_term_last_employee,NULL mio_term_orig_status,NULL mio_term_complete_date,
 NULL mio_term_update_date,NULL mio_term_vcl_due_date,NULL mio_term_state,prev_current_state,prev_app_end_date,manual_cviu_status,manual_cpu_status,mcviu_activity_date,mcpu_activity_date
FROM coverva_dmas.dmas_application_v2_event v
  LEFT JOIN coverva_dmas.dmas_mms_ldap_full_load_vw ldap ON v.am_worker = ldap.ldap
WHERE NOT EXISTS(SELECT 1 FROM dmas_application_v3_event e WHERE v.tracking_number = e.tracking_number AND v.event_date = e.event_date)  
ORDER BY application_event_id;

INSERT INTO dmas_application_v3_inventory(tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
last_employee,applicant_name,case_number,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,
vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,state_app_received_date,cp_application_type,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,
vcl_sent_date,case_type,sd_stage,noa_generation_date,application_incarcerated_indicator,case_incarcerated_indicator,renewal_closure_date,auto_closure_date,denial_reason,actual_app_end_date,
previous_processing_end_date,previous_initial_review_date,previous_current_state)
SELECT tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
last_employee,applicant_name,case_number,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,
vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,state_app_received_date,cp_application_type,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,
vcl_sent_date,case_type,sd_stage,NULL noa_generation_date,NULL application_incarcerated_indicator,NULL case_incarcerated_indicator,renewal_closure_date,auto_closure_date,denial_reason,application_processing_end_date,
application_processing_end_date,initial_review_complete_date,current_state
FROM dmas_application_v2_inventory
ORDER BY dmas_application_id;

INSERT INTO dmas_application_v3_current(tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
last_employee,applicant_name,case_number,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,
vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,state_app_received_date,cp_application_type,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,
vcl_sent_date,case_type,sd_stage,noa_generation_date,application_incarcerated_indicator,case_incarcerated_indicator,renewal_closure_date,auto_closure_date,denial_reason,actual_app_end_date)
SELECT tracking_number,source,app_received_date,processing_unit,application_type,current_state,initial_review_complete_date,application_processing_end_date,
last_employee,applicant_name,case_number,fp_create_dt,fp_update_dt,file_id,in_cp_indicator,migrated_app_indicator,initial_review_dt_null_reason,last_employee_null_reason,end_date_null_reason,
vcl_due_date,intake_date,complete_date,file_inventory_date,maximus_source_date,state_app_received_date,cp_application_type,cm044_verified,non_maximus_initial_date,non_maximus_returned_date,
vcl_sent_date,case_type,sd_stage,NULL noa_generation_date,NULL application_incarcerated_indicator,NULL case_incarcerated_indicator,renewal_closure_date,auto_closure_date,denial_reason,application_processing_end_date
FROM dmas_application_v2_current
ORDER BY dmas_application_current_id;

INSERT INTO dmas_excluded_v3_application(tracking_number,ignore_application_reason,file_id,file_inventory_date,fp_create_dt,fp_update_dt)
SELECT tracking_number,ignore_application_reason,file_id,file_inventory_date,fp_create_dt,fp_update_dt
FROM dmas_excluded_v2_application
ORDER BY dmas_excluded_application_id;

UPDATE dmas_application_v3_inventory dmas
SET dmas.intake_state_first_date = da.intake_state_first_dt,
  dmas.wir_state_first_date = da.wir_state_first_dt,
  dmas.wfvd_state_first_date = da.wfvd_state_first_dt,
  dmas.irc_state_first_date = da.irc_state_first_dt,
  dmas.nma_state_first_date = da.nma_state_first_dt,
  dmas.ttldss_state_first_date = da.ttldss_state_first_dt,
  dmas.approved_state_first_date = da.approved_state_first_dt,
  dmas.denied_state_first_date = da.denied_state_first_dt,
  dmas.complete_state_first_date = da.complete_state_first_dt
FROM(  
SELECT da.tracking_number,current_state,da.dmas_application_id,file_inventory_date,
  CASE WHEN intake_state_first_dt > wfvd_state_first_dt THEN wfvd_state_first_dt ELSE intake_state_first_dt END intake_state_first_dt,
  CASE WHEN wir_state_first_dt < intake_state_first_dt THEN intake_state_first_dt
       WHEN wir_state_first_dt > wfvd_state_first_dt THEN wfvd_state_first_dt ELSE wir_state_first_dt END wir_state_first_dt,
  wfvd_state_first_dt,nma_state_first_dt,
  irc_state_first_dt,ttldss_state_first_dt,approved_state_first_dt,denied_state_first_dt,complete_state_first_dt
FROM (SELECT *
      FROM dmas_application_v3_inventory 
      QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC, dmas_application_id DESC) = 1) da
  LEFT JOIN (SELECT tracking_number,MIN(file_inventory_date) intake_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Intake'           
        GROUP BY tracking_number) ink ON ink.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(file_inventory_date) wir_state_first_dt 
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Waiting Initial Review'
        GROUP BY tracking_number) wir ON wir.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(initial_review_complete_date) wfvd_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Waiting for Verification Documents'
        AND initial_review_complete_date IS NOT NULL
        GROUP BY tracking_number) wfvd ON wfvd.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(initial_review_complete_date) irc_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Initial Review Complete'
        AND initial_review_complete_date IS NOT NULL
        GROUP BY tracking_number) irc ON irc.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(non_maximus_initial_date) nma_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Waiting Initial Review'
        GROUP BY tracking_number) nma ON nma.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(application_processing_end_date) ttldss_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Transferred to LDSS'
        AND application_processing_end_date IS NOT NULL     
        GROUP BY tracking_number) ttldss ON ttldss.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(application_processing_end_date) approved_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Approved'
        AND application_processing_end_date IS NOT NULL
        GROUP BY tracking_number) apr ON apr.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(application_processing_end_date) denied_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Denied'
        AND application_processing_end_date IS NOT NULL             
        GROUP BY tracking_number) dnr ON dnr.tracking_number = da.tracking_number
  LEFT JOIN (SELECT tracking_number,MIN(application_processing_end_date) complete_state_first_dt
        FROM dmas_application_v3_inventory
        WHERE current_state = 'Complete - Needs Research'
        AND application_processing_end_date IS NOT NULL             
        GROUP BY tracking_number) cnr ON cnr.tracking_number = da.tracking_number) da WHERE dmas.dmas_application_id = da.dmas_application_id;
        
--for apps that are in WIR current state bu have already been approved a long time ago        
insert into manual_cpu_tracking(t,application_number,activity_date,denied,approved,comments)
select t,t,activity_date,denied,approved,CONCAT('Researched by ',researched_by,' on ', research_date,'; Application Age: ',calendar_age,' ; Inserted manually to this table on 6/1/2023 to force current state in inventory report') comments
from "MARS_DP4BI_PROD"."COVERVA_DMAS"."OLD_INVENTORY_APPLICATIONS_20230601";      

 --for apps that are in CVIU Liaison Smartsheet that have dispositions
insert into manual_cpu_tracking(t,application_number,activity_date,denied,approved,comments)
select t,t,cast(activity_date as date),denied,approved,'Inserted manually to this table on 6/2/2023 to force current states for applications in CVIU Liaison Smartsheet file'
from "MARS_DP4BI_PROD"."COVERVA_DMAS"."CVIU_LIAISON_APPLICATIONS_DETERMINATION_20230602";