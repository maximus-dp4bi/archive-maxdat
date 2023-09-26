 CREATE OR REPLACE VIEW d_app_processing_timeliness_sv
 AS 
SELECT application_id
       ,member_id
       ,receipt_date
       ,reactivation_event_date reactivation_date
       ,scan_date scan_dt
       ,application_status
       ,coverage_end_date
       ,eligibility_outcome
       ,term_date
       ,rcvd_during_90day_prd
       ,TRUNC(forward_task_to_state_dt) forward_task_to_state_dt
     --  ,TRUNC(mi_determination_dt) mi_determination_dt
       ,TRUNC(modified_mi_added_date) mi_determination_dt
       ,CASE WHEN rf_outcome_cd = 'PENDING' THEN TRUNC(refer_to_hcfa_date) ELSE NULL END refer_to_hcfa_dt
     --  ,TRUNC(cycle_stop) processed_dt
     --  ,TRUNC(cycle_stop) cycle_time_stop_dt
       ,TRUNC(modified_cycle_stop) processed_dt
       ,TRUNC(modified_cycle_stop) cycle_time_stop_dt
       ,sla
        ,CASE WHEN COALESCE(modified_cycle_stop,TRUNC(SYSDATE)) - modified_cycle_start < 0 THEN 0 ELSE COALESCE(modified_cycle_stop,TRUNC(SYSDATE)) - modified_cycle_start END calendar_days_cycle_age 
       ,(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(modified_cycle_start) AND COALESCE(TRUNC(modified_cycle_stop), TRUNC(sysdate)) )  business_days_cycle_age           
       ,CASE WHEN modified_cycle_stop IS NULL THEN 'Not Processed'
             WHEN CASE WHEN COALESCE(modified_cycle_stop,TRUNC(SYSDATE)) - modified_cycle_start < 0 THEN 0 ELSE COALESCE(modified_cycle_stop,TRUNC(SYSDATE)) - modified_cycle_start END <= sla THEN 'Timely' 
          ELSE 'Untimely' END calendar_day_timeliness
       ,CASE WHEN modified_cycle_stop IS NULL THEN 'Not Processed'
             WHEN (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                   FROM D_DATES
                   WHERE business_day_flag = 'Y'
                   AND d_date BETWEEN TRUNC(modified_cycle_start) AND COALESCE(TRUNC(modified_cycle_stop), TRUNC(sysdate)) ) <= sla THEN 'Timely' 
              ELSE 'Untimely' END business_day_timeliness          
       ,TRUNC(receipt_date,'MM') receipt_month
       ,TRUNC(modified_cycle_stop,'MM') processed_month
       ,multi_applying_member_flag
       ,callback_date
       ,COALESCE(application_type,app_form_cd) application_type
       ,link_date
       ,cob_indicator
       ,hcfa_reactivation_flag    
       ,COALESCE(rf_staff_completed_by,bo_staff_completed_by) staff_completed_by
       ,de_task_create_date
       ,CASE WHEN refer_to_hcfa_date IS NULL THEN billable_outcome_date ELSE LEAST(refer_to_hcfa_date,COALESCE(billable_outcome_date,refer_to_hcfa_date)) END billable_outcome_date
       ,TRUNC(modified_cycle_start) cycle_start_date
       ,TRUNC(modified_cycle_start,'mm') cycle_start_month
       ,CASE WHEN (modified_cycle_stop IS NOT NULL or application_status = 'Timeout') THEN 'NA'             
         ELSE CASE WHEN (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(modified_cycle_start) AND COALESCE(TRUNC(modified_cycle_stop), TRUNC(sysdate)) ) >= jeopardy_days THEN 'Y' ELSE 'N' END END app_jeopardy_status
       ,TRUNC(recon_period_end_date) recon_period_end_date
       ,TRUNC(TN411_mailed_date) TN411_mailed_date
       ,TRUNC(ftp_mailed_date) ftp_mailed_date
       ,recent_doc_type
       ,open_task_name
       ,open_task_bu_name
       ,open_task_status
       ,open_task_owner_name
       ,open_task_owner_type       
       ,document_form_type
       ,document_type
       ,open_task_id
       ,de_task_id
       ,reactivation_reason
FROM d_app_processing_timeliness
WHERE exclusion_flag = 'N'
AND application_id >= 320
 ;
 
GRANT SELECT ON D_APP_PROCESSING_TIMELINESS_SV to MAXDAT_READ_ONLY;

