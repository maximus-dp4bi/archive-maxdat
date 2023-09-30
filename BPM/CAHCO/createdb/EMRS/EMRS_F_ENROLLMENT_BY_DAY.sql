CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_BY_DAY_SV
AS
SELECT d_date
       ,forms_received
       ,forms_processed
       ,LAG(forms_remaining, 1, 0) OVER (PARTITION BY d_month ORDER BY d_date) forms_inventory
       ,transfers_processed
       ,exemptions_processed      
        ,forms_avg_enroll_process_time
       ,forms_avg_manual_enroll_process_time
       ,forms_avg_process_time_in_days
       ,forms_processed_timely
       ,forms_processed_untimely 
       ,forms_remaining
FROM  
(SELECT f.*
       ,SUM(forms_remaining_cnt) OVER (PARTITION BY d_month ORDER BY d_date) forms_remaining
       ,COALESCE(ROUND(forms_enroll_process_time/CASE WHEN forms_enrolled = 0 THEN 1 ELSE forms_enrolled END,1),0) forms_avg_enroll_process_time
       ,COALESCE(ROUND(forms_manual_enrl_process_time/CASE WHEN forms_manual_enroll = 0 THEN 1 ELSE forms_manual_enroll END,1),0) forms_avg_manual_enroll_process_time
       ,COALESCE(ROUND(forms_process_time_days/CASE WHEN forms_processed = 0 THEN 1 ELSE forms_processed END,1),0) forms_avg_process_time_in_days
 FROM (SELECT d_date
             ,d_month
             ,COUNT(DISTINCT CASE WHEN f.dcn IS NOT NULL THEN f.dcn ELSE null END) forms_received
             ,COUNT(DISTINCT CASE WHEN processed_date IS NOT NULL THEN f.dcn ELSE null END) forms_processed
             ,COUNT(DISTINCT CASE WHEN f.dcn IS NOT NULL THEN f.dcn ELSE null END) - COUNT(DISTINCT CASE WHEN processed_date IS NOT NULL THEN f.dcn ELSE null END) forms_remaining_cnt
             ,COUNT(DISTINCT CASE WHEN selection_transaction_id IS NOT NULL THEN selection_transaction_id ELSE null END) transfers_processed
             ,COUNT(DISTINCT CASE WHEN exemption_id IS NOT NULL THEN exemption_id ELSE null END) exemptions_processed   
             ,SUM(days_to_process_enrl) forms_enroll_process_time
             ,SUM(CASE WHEN form_manually_entered = 'Y'  THEN days_to_process ELSE 0 END) forms_manual_enrl_process_time
             ,SUM(days_to_process) forms_process_time_days
             ,COUNT(DISTINCT CASE WHEN processed_date IS NOT NULL AND days_to_process <= TO_NUMBER(sla_days) THEN f.dcn ELSE null END) forms_processed_timely
             ,COUNT(DISTINCT CASE WHEN processed_date IS NOT NULL AND days_to_process > TO_NUMBER(sla_days) THEN f.dcn ELSE null END) forms_processed_untimely
             ,COUNT(DISTINCT CASE WHEN enrollment_id IS NOT NULL THEN f.dcn ELSE null END) forms_enrolled
             ,COUNT(DISTINCT CASE WHEN form_manually_entered = 'Y' THEN f.dcn ELSE null END) forms_manual_enroll    
         FROM  bpm_d_dates dd
          LEFT JOIN (SELECT DISTINCT df.dcn,processed_date,form_manually_entered,enrollment_id,cl.out_var sla_days,df.date_form_received,
                           CASE WHEN processed_date IS NOT NULL AND processed_date >= date_form_received THEN 
                            (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                              FROM D_DATES_SV
                              WHERE business_day_flag = 'Y'
                              AND d_date BETWEEN TRUNC(date_form_received) AND TRUNC(processed_date) ) ELSE 0 END days_to_process,
                           CASE WHEN enrollment_id IS NOT NULL AND transaction_date >= date_form_received THEN 
                            (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                             FROM D_DATES_SV
                             WHERE business_day_flag = 'Y'
                             AND d_date BETWEEN TRUNC(date_form_received) AND TRUNC(transaction_date) ) ELSE 0 END days_to_process_enrl,
                          null selection_Transaction_id,
                          null exemption_id
                      FROM (SELECT df.dcn,form_manually_entered,enrollment_id,df.date_form_received, df.form_type,df.selection_source_code,
                                 CASE WHEN reference_type = 'OCRRECORD' THEN df.record_date
                                       WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                                       WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
                                    ELSE df.processed_date END processed_date
                            FROM hco_d_form df) df
                        LEFT JOIN emrs_d_selection_trans st ON df.enrollment_id = st.selection_transaction_id
                        JOIN corp_etl_list_lkup cl ON df.form_type = cl.name AND cl.list_type = 'FORM_SLA_DAYS'
                      WHERE df.dcn IS NOT NULL
                      AND df.form_type = 'Choice Form'
                      AND TRUNC(df.date_form_received) >= TO_DATE('01/01/2017','mm/dd/yyyy')
                      --AND df.selection_source_code IN('Manual','OCR')
                      UNION ALL
                      SELECT null dcn, null processed_date,null form_manually_entered,null enrollment_id,null out_var,st.record_date date_form_received,
                        0 days_to_process, 0 days_to_process_enrl,selection_transaction_id,null exemption_id
                      FROM emrs_d_selection_trans st 
                      WHERE transfer_flag = 'Y'  
                      AND record_name  NOT IN ('errorusr', 'recon', 'newelig', 'newelg','errusr','errmed','rcnfix') 
                      AND st.plan_id <> st.prior_plan_id  
                      UNION ALL
                      SELECT null dcn, null processed_date,null form_manually_entered,null enrollment_id,null out_var,disposition_date date_form_received,
                        0 days_to_process, 0 days_to_process_enrl,null selection_transaction_id, exemption_id
                      FROM emrs_d_exemption_req  
                    ) f ON dd.d_date = TRUNC(f.date_form_received) 
          --WHERE weekend_flag = 'N'          
          GROUP BY d_date,d_month
      ) f
    );

GRANT SELECT ON "EMRS_F_ENROLLMENT_BY_DAY_SV" TO "MAXDAT_READ_ONLY";