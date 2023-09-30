CREATE TABLE d_mi_processing_timeliness
(doc_link_id NUMBER
 ,document_id NUMBER
 ,application_id NUMBER
 ,member_id VARCHAR2(32)
 ,app_receipt_date DATE
 ,reactivation_date DATE
 ,app_scan_date DATE
 ,application_status VARCHAR2(32)
 ,coverage_end_date DATE
 ,eligibility_outcome VARCHAR2(64)
 ,term_date DATE 
 ,mi_link_date DATE
 ,mi_receipt_date DATE
 ,mi_scan_date DATE
 ,forward_task_to_state_dt DATE
 ,mi_determination_dt DATE
 ,refer_to_hcfa_dt DATE
 ,processed_dt DATE 
 ,sla NUMBER
 ,multi_applying_member_flag VARCHAR2(1)
 ,callback_date DATE
 ,application_type VARCHAR2(64)
 ,app_link_date DATE
 ,cob_indicator VARCHAR2(5)
 ,hcfa_reactivation_flag  VARCHAR2(1)
 ,staff_completed_by VARCHAR2(100)
 ,de_task_create_date DATE
 ,de_task_complete_date DATE
 ,billable_outcome_date DATE 
 ,de_task_id NUMBER
 ,de_task_status VARCHAR2(64)
 ,de_claimed_unclaimed VARCHAR2(32)
 ,de_current_owner VARCHAR2(100)
 ,jeopardy_status VARCHAR2(1)
 ,last_mi_mailed_date DATE
 ,recent_doc_type VARCHAR2(64)
 ,de_task_type  VARCHAR2(100)
 ,document_type  VARCHAR2(64)
 ,document_form_type  VARCHAR2(64)
 ,app_receipt_dt_after_term DATE
 ,app_link_dt_after_term DATE
 ,app_scan_dt_after_term DATE
 ,term_ltr_mailed_date DATE
 ,fwd_task_id NUMBER 
 ,staff_fwd_by VARCHAR2(100)
 ,fwdby_staff_type VARCHAR2(32)      
 ,staff_fwd_to VARCHAR2(100)
 ,fwdto_staff_type VARCHAR2(32)  
 ,detask_cycle_stop_date DATE
 ,bo_staff_completed_by VARCHAR2(100)
 ,bo_outcome_cd VARCHAR2(32)
 ,rf_staff_completed_by VARCHAR2(100)
 ,rf_outcome_cd VARCHAR2(32)
 ,exception_type VARCHAR2(100)
 ,excp_new_cycle_start_date DATE
 ,excp_new_cycle_end_date DATE
 ,exclusion_flag VARCHAR2(1)
 ,jeopardy_days NUMBER
 ,rcvd_during_90day_prd VARCHAR2(1)
 ) TABLESPACE MAXDAT_DATA;
 
 CREATE INDEX IDX01_MIPROCTM ON d_mi_processing_timeliness(document_id) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX02_MIPROCTM ON d_mi_processing_timeliness(application_id) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX03_MIPROCTM ON d_mi_processing_timeliness(doc_link_id) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX04_MIPROCTM ON d_mi_processing_timeliness(exclusion_flag) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX05_MIPROCTM ON d_mi_processing_timeliness(de_task_id) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX06_MIPROCTM ON d_mi_processing_timeliness(TRUNC(mi_link_date)) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX07_MIPROCTM ON d_mi_processing_timeliness(processed_dt) TABLESPACE MAXDAT_INDX;
 
 GRANT SELECT ON D_MI_PROCESSING_TIMELINESS to MAXDAT_READ_ONLY;
 