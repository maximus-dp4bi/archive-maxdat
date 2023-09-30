CREATE TABLE d_app_processing_timeliness(
application_id NUMBER
,reactivation_date DATE
,receipt_date DATE
,scan_date DATE
,application_status VARCHAR2(64)
,application_status_cd VARCHAR2(32)
,application_type VARCHAR2(64)
,member_id VARCHAR2(32)
,coverage_end_date DATE
,eligibility_outcome VARCHAR2(64)
,app_form_cd VARCHAR2(64)
,forward_task_to_state_dt DATE
,fwd_task_id NUMBER 
,staff_fwd_by VARCHAR2(100)
,fwdby_staff_type VARCHAR2(32)      
,staff_fwd_to VARCHAR2(100)
,fwdto_staff_type VARCHAR2(32)         
,term_date DATE
,billable_outcome_date DATE
,mi_determination_dt DATE
,refer_to_hcfa_date DATE
,callback_date DATE
,new_cycle_start_date DATE
,new_cycle_end_date DATE
,hcfa_reactivation_flag  VARCHAR2(1)
,exception_type VARCHAR2(100)
,exclusion_flag VARCHAR2(1)
,multi_applying_member_flag VARCHAR2(1)
,link_date DATE
,cob_indicator VARCHAR2(5)
,cycle_stop DATE
,cycle_start DATE
,sla NUMBER
,jeopardy_days NUMBER
,recon_period_end_date DATE
,staff_completed_by VARCHAR2(100)
,de_task_create_date DATE
,open_task_name VARCHAR2(100)
,open_task_bu_name VARCHAR2(100)
,open_task_status VARCHAR2(64)
,open_task_owner_name VARCHAR2(100)
,open_task_owner_type VARCHAR2(32)
,document_form_type VARCHAR2(64)
,document_type VARCHAR2(64)
,open_task_id NUMBER
,term_ltr_mailed_date DATE
,TN411_mailed_date DATE
,ftp_mailed_date DATE
,recent_doc_type VARCHAR2(64)
,detask_cycle_stop_date DATE
,de_task_complete_date DATE
,de_task_status VARCHAR2(64)
,de_task_id NUMBER
,bo_outcome_cd VARCHAR2(32)
,bo_staff_completed_by VARCHAR2(100)
,rf_staff_completed_by VARCHAR2(100)
,rf_outcome_cd VARCHAR2(32)
,excp_new_cycle_start_date DATE
,excp_new_cycle_end_date DATE
,rcvd_during_90day_prd VARCHAR2(1)
,reactivation_reason VARCHAR2(256)
,reactivation_event_date DATE
,link_date_after_trm DATE
,trm_event_end_date DATE     
,mi_voided_date DATE
,modified_cycle_start DATE
,modified_cycle_stop DATE
,modified_mi_added_date DATE
,modified_fwd_to_state_dt DATE
,mi_added_dt_after_trm DATE
,modified_callback_date DATE
,modified_detask_stop_date DATE
,modified_refer_to_hcfa_date DATE
,modified_billable_outcome_date DATE 
,modified_excp_cycle_end_date DATE
,trm_event_start_date DATE
) TABLESPACE MAXDAT_DATA;

 CREATE INDEX IDX01_APPPROCTM ON d_app_processing_timeliness(application_id) TABLESPACE MAXDAT_INDX; 
 CREATE INDEX IDX02_APPPROCTM ON d_app_processing_timeliness(application_status_cd) TABLESPACE MAXDAT_INDX; 
 CREATE INDEX IDX03_APPPROCTM ON d_app_processing_timeliness(exclusion_flag) TABLESPACE MAXDAT_INDX; 
 CREATE INDEX IDX04_APPPROCTM ON d_app_processing_timeliness(de_task_id) TABLESPACE MAXDAT_INDX; 
 
 GRANT SELECT ON D_APP_PROCESSING_TIMELINESS to MAXDAT_READ_ONLY;
 
 