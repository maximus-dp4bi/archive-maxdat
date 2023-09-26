CREATE OR REPLACE VIEW d_mi_processing_timeliness_sv
AS 
SELECT *
FROM (
 SELECT document_id
       ,application_id
       ,member_id
       ,app_receipt_date       
       ,reactivation_date
       ,app_scan_date
       ,application_status
       ,coverage_end_date
       ,eligibility_outcome
       ,term_date
       ,rcvd_during_90day_prd
       ,mi_link_date
       ,mi_receipt_date
       ,mi_scan_date
       ,forward_task_to_state_dt
       ,TRUNC(mi_determination_dt) mi_determination_dt
       ,TRUNC(CASE WHEN rf_outcome_cd = 'PENDING' THEN refer_to_hcfa_dt ELSE NULL END) refer_to_hcfa_dt
       ,processed_dt
       ,TRUNC(processed_dt) cycle_time_stop_dt
       ,sla
       ,CASE WHEN COALESCE(processed_dt,TRUNC(SYSDATE)) - TRUNC(mi_link_date) < 0 THEN 0 ELSE COALESCE(processed_dt,TRUNC(SYSDATE)) - TRUNC(mi_link_date) END calendar_days_cycle_age 
       ,(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(mi_link_date) AND  COALESCE(processed_dt,TRUNC(SYSDATE))) business_days_cycle_age
       ,CASE WHEN processed_dt IS NULL THEN 'Not Processed' 
             WHEN CASE WHEN COALESCE(processed_dt,TRUNC(SYSDATE)) - TRUNC(mi_link_date) < 0 THEN 0 ELSE COALESCE(processed_dt,TRUNC(SYSDATE)) - TRUNC(mi_link_date) END <= sla THEN 'Timely' 
          ELSE 'Untimely' END calendar_day_timeliness 
       ,CASE WHEN processed_dt IS NULL THEN 'Not Processed' 
         ELSE CASE WHEN (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                         FROM D_DATES
                         WHERE business_day_flag = 'Y'
                         AND d_date BETWEEN TRUNC(mi_link_date) AND  COALESCE(processed_dt,TRUNC(SYSDATE))) <= sla THEN 'Timely' ELSE 'Untimely' END END business_day_timeliness       
       ,TRUNC(app_receipt_date,'MM') app_receipt_month
       ,TRUNC(mi_receipt_date,'MM') mi_receipt_month
       ,TRUNC(processed_dt,'MM') processed_month
       ,multi_applying_member_flag
       ,callback_date
       ,application_type
       ,app_link_date
       ,cob_indicator
       ,hcfa_reactivation_flag    
       ,COALESCE(rf_staff_completed_by,bo_staff_completed_by) staff_completed_by
       ,de_task_create_date
       ,de_task_complete_date       
       ,TRUNC(CASE WHEN refer_to_hcfa_dt IS NULL THEN billable_outcome_date ELSE LEAST(refer_to_hcfa_dt,COALESCE(billable_outcome_date,refer_to_hcfa_dt)) END) billable_outcome_date
       ,TRUNC(mi_link_date) cycle_start_date
       ,TRUNC(mi_link_date,'mm') cycle_start_month
       ,de_task_id
       ,de_task_status
       ,de_claimed_unclaimed
       ,de_current_owner
       ,CASE WHEN processed_dt IS NOT NULL THEN 'NA'
         ELSE CASE WHEN (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                   FROM D_DATES
                   WHERE business_day_flag = 'Y'
                   AND d_date BETWEEN TRUNC(mi_link_date) AND TRUNC(SYSDATE) ) < jeopardy_days THEN 'N' ELSE 'Y' END END jeopardy_status
       ,last_mi_mailed_date
       ,recent_doc_type    
       ,de_task_type  
       ,document_type
       ,document_form_type
       ,ROW_NUMBER() OVER (PARTITION BY application_id,de_task_id ORDER BY ABS(mi_link_date-de_task_create_date) ) mirn
  FROM d_mi_processing_timeliness  
  WHERE  TRUNC(mi_link_date) >= TRUNC(de_task_create_date-1)
  AND exclusion_flag = 'N'
  AND application_id >= 320)
WHERE mirn = 1  ;

GRANT SELECT ON D_MI_PROCESSING_TIMELINESS_SV to MAXDAT_READ_ONLY;