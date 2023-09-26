CREATE OR REPLACE VIEW EMRS_F_EDERS_BY_DAY_SV
AS
SELECT d_date  
  ,eders_med_processed  
  ,CASE WHEN eders_med_remaining < 0 THEN 0 ELSE LAG(eders_med_remaining, 1, 0) OVER (ORDER BY d_date) END eders_med_inventory
  ,eders_med_received
  ,eders_med_remaining
  ,eders_med_received_back
  ,eders_med_denied
  ,eders_med_approved
  ,eders_med_processed_timely
  ,eders_med_processed_untimely
  ,eders_den_processed
  ,CASE WHEN eders_den_remaining < 0 THEN 0 ELSE LAG(eders_den_remaining, 1, 0) OVER (ORDER BY d_date) END eders_den_inventory
  ,eders_den_received
  ,eders_den_remaining
  ,eders_den_received_back
  ,eders_den_denied
  ,eders_den_approved
  ,eders_den_processed_timely
  ,eders_den_processed_untimely
  ,eders_retro_processed
  ,CASE WHEN eders_retro_remaining < 0 THEN 0 ELSE LAG(eders_retro_remaining, 1, 0) OVER (ORDER BY d_date) END eders_retro_inventory
  ,eders_retro_received
  ,eders_retro_remaining
  ,eders_retro_received_back
  ,eders_retro_denied
  ,eders_retro_approved
  ,eders_retro_processed_timely
  ,eders_retro_processed_untimely  
  ,eders_med_avg_process_time
  ,eders_den_avg_process_time
  ,eders_med_pending
  ,eders_den_pending
  ,eders_retro_avg_process_time
  ,eders_med_retro_received 
  ,eders_den_retro_received 
  ,eders_med_retro_processed
  ,eders_den_retro_processed
FROM (
SELECT d_date  
  ,COALESCE(eders_med_processed,0)eders_med_processed   
  ,COALESCE(eders_med_received,0) eders_med_received  
  ,COALESCE(eders_med_received_back,0) eders_med_received_back
  ,COALESCE(eders_med_denied,0) eders_med_denied
  ,COALESCE(eders_med_approved,0) eders_med_approved
  ,COALESCE(eders_med_processed_timely,0) eders_med_processed_timely
  ,COALESCE(eders_med_processed_untimely,0) eders_med_processed_untimely
  ,COALESCE(eders_den_processed,0) eders_den_processed  
  ,COALESCE(eders_den_received,0) eders_den_received  
  ,COALESCE(eders_den_received_back,0) eders_den_received_back
  ,COALESCE(eders_den_denied,0) eders_den_denied
  ,COALESCE(eders_den_approved,0) eders_den_approved
  ,COALESCE(eders_den_processed_timely,0) eders_den_processed_timely
  ,COALESCE(eders_den_processed_untimely,0) eders_den_processed_untimely
  ,COALESCE(eders_retro_processed,0) eders_retro_processed
  ,COALESCE(eders_retro_received,0) eders_retro_received  
  ,COALESCE(eders_retro_received_back,0) eders_retro_received_back
  ,COALESCE(eders_retro_denied,0) eders_retro_denied
  ,COALESCE(eders_retro_approved,0) eders_retro_approved
  ,COALESCE(eders_retro_processed_timely,0) eders_retro_processed_timely
  ,COALESCE(eders_retro_processed_untimely,0)  eders_retro_processed_untimely 
  ,COALESCE(ROUND(eders_med_process_time/CASE WHEN (eders_med_processed_timely + eders_med_processed_untimely) = 0 THEN 1 ELSE (eders_med_processed_timely + eders_med_processed_untimely) END,1),0) eders_med_avg_process_time
  ,COALESCE(ROUND(eders_den_process_time/CASE WHEN (eders_den_processed_timely + eders_den_processed_untimely) = 0 THEN 1 ELSE (eders_den_processed_timely + eders_den_processed_untimely)  END,1),0) eders_den_avg_process_time 
  ,COALESCE(eders_med_pending,0) eders_med_pending
  ,COALESCE(eders_den_pending,0) eders_den_pending  
  ,COALESCE(ROUND(eders_retro_process_time/CASE WHEN (eders_retro_processed_timely + eders_retro_processed_untimely) = 0 THEN 1 ELSE (eders_retro_processed_timely + eders_retro_processed_untimely) END,1),0) eders_retro_avg_process_time
  ,SUM(COALESCE(eders_med_received,0) - COALESCE(eders_med_processed,0)) over (order by d_date)  eders_med_remaining
  ,SUM(COALESCE(eders_den_received,0) - COALESCE(eders_den_processed,0)) over (order by d_date)  eders_den_remaining
  ,SUM(COALESCE(eders_retro_received,0) - COALESCE(eders_retro_processed,0)) over (order by d_date)  eders_retro_remaining
  ,COALESCE(eders_med_retro_received,0) eders_med_retro_received 
  ,COALESCE(eders_den_retro_received,0) eders_den_retro_received 
  ,COALESCE(eders_med_retro_processed,0) eders_med_retro_processed
  ,COALESCE(eders_den_retro_processed,0) eders_den_retro_processed
FROM bpm_d_dates dd
  LEFT JOIN (SELECT TRUNC(d.record_date) record_date
               ,COUNT(DISTINCT CASE WHEN d.plan_type = 'M' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_med_received     
               ,COUNT(DISTINCT CASE WHEN d.plan_type = 'D' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_den_received
               ,COUNT(DISTINCT CASE WHEN d.retro_disenroll = 'Y' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_retro_received
               ,COUNT(DISTINCT CASE WHEN d.plan_type = 'M' AND d.retro_disenroll = 'Y' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_med_retro_received
               ,COUNT(DISTINCT CASE WHEN d.plan_type = 'D' AND d.retro_disenroll = 'Y' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_den_retro_received
             FROM emrs_d_emrgcy_disenroll d 
             WHERE TRUNC(d.record_date) >= to_date('01/01/2017','mm/dd/yyyy')
             GROUP BY TRUNC(d.record_date)) d  ON dd.d_date = TRUNC(d.record_date)
  LEFT JOIN(
      SELECT processed_date     
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','B','D','M') AND proc.plan_type = 'M' THEN proc.emrgcy_disenroll_id ELSE null END) eders_med_processed    
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','D') AND proc.plan_type = 'M' THEN proc.emrgcy_disenroll_id ELSE null END) eders_med_denied
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('B','M') AND proc.plan_type = 'M' THEN proc.emrgcy_disenroll_id ELSE null END) eders_med_approved
       ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process <= TO_NUMBER(cl.out_var) AND proc.plan_type = 'M' THEN proc.emrgcy_disenroll_id ELSE NULL END) eders_med_processed_timely
       ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process > TO_NUMBER(cl.out_var) AND proc.plan_type = 'M' THEN proc.emrgcy_disenroll_id ELSE NULL END) eders_med_processed_untimely       
       
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','B','D','M') AND proc.plan_type = 'D' THEN proc.emrgcy_disenroll_id ELSE null END) eders_den_processed          
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','D') AND proc.plan_type = 'D' THEN proc.emrgcy_disenroll_id ELSE null END) eders_den_denied
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('B','M') AND proc.plan_type = 'D' THEN proc.emrgcy_disenroll_id ELSE null END) eders_den_approved
       ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process <= TO_NUMBER(cl.out_var) AND proc.plan_type = 'D' THEN proc.emrgcy_disenroll_id ELSE NULL END) eders_den_processed_timely
       ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process > TO_NUMBER(cl.out_var) AND proc.plan_type = 'D' THEN proc.emrgcy_disenroll_id ELSE NULL END) eders_den_processed_untimely       
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','B','D','M') AND proc.retro_disenroll = 'Y' THEN proc.emrgcy_disenroll_id ELSE null END) eders_retro_processed    
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','B','D','M') AND proc.plan_type = 'M' AND proc.retro_disenroll = 'Y' THEN proc.emrgcy_disenroll_id ELSE null END) eders_med_retro_processed                  
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','B','D','M') AND proc.plan_type = 'D' AND proc.retro_disenroll = 'Y' THEN proc.emrgcy_disenroll_id ELSE null END) eders_den_retro_processed                         
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('2','4','D') AND proc.retro_disenroll = 'Y'  THEN proc.emrgcy_disenroll_id ELSE null END) eders_retro_denied
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code IN('B','M') AND proc.retro_disenroll = 'Y'  THEN proc.emrgcy_disenroll_id ELSE null END) eders_retro_approved
       ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process <= TO_NUMBER(cl.out_var) AND proc.retro_disenroll = 'Y' THEN proc.emrgcy_disenroll_id ELSE NULL END) eders_retro_processed_timely
       ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process > TO_NUMBER(cl.out_var) AND proc.retro_disenroll = 'Y' THEN proc.emrgcy_disenroll_id ELSE NULL END) eders_retro_processed_untimely       
       ,SUM(CASE WHEN proc.row_num = 1 AND proc.plan_type = 'M' THEN proc.days_to_process ELSE 0 END) eders_med_process_time
       ,SUM(CASE WHEN proc.row_num = 1 AND proc.plan_type = 'D' THEN proc.days_to_process ELSE 0 END) eders_den_process_time
       ,SUM(CASE WHEN proc.row_num = 1 AND proc.retro_disenroll = 'Y' THEN proc.days_to_process ELSE 0 END) eders_retro_process_time
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code NOT IN('2','4','B','D','M') AND proc.plan_type = 'M' THEN proc.emrgcy_disenroll_id ELSE null END) eders_med_pending
       ,COUNT(DISTINCT CASE WHEN proc.emrgcy_denr_status_code NOT IN('2','4','B','D','M') AND proc.plan_type = 'D' THEN proc.emrgcy_disenroll_id ELSE null END) eders_den_pending
    FROM(SELECT d.retro_disenroll,
                   d.plan_type,
                   d.dcn,
                   h.emrgcy_denr_status_code,
                   h.record_date,
                   d.approved_status_date,
                   d.denial_status_date,
                   d.pending_status_date,
                   h.emrgcy_disenroll_id,
                   TRUNC(h.record_date) processed_date,                 
                 /*  CASE WHEN h.record_date >= h.prev_status_hist_date THEN 
                     (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                      FROM D_DATES_SV
                      WHERE business_day_flag = 'Y'
                      AND d_date BETWEEN TRUNC(COALESCE(h.prev_status_hist_date,h.record_date)) AND TRUNC(h.record_date) ) ELSE 0 END days_to_process*/
                    CASE WHEN d.record_date >= d.date_form_received THEN 
                     (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                      FROM D_DATES_SV
                      WHERE business_day_flag = 'Y'
                      AND d_date BETWEEN TRUNC(COALESCE(date_form_received,d.record_date)) AND TRUNC(d.record_date) ) ELSE 0 END days_to_process
                     ,row_num 
            FROM (SELECT rr.*
                         ,CASE WHEN SUBSTR(rr.dcn,1,5) NOT LIKE '%[^0-9]%' AND LENGTH(SUBSTR(rr.dcn,1,5)) = 5 THEN     
                          TO_DATE(SUBSTR(rr.dcn,1,2)||'0101','yymmdd') + substr(rr.dcn,3,3)-1 
                        ELSE rr.record_date END date_form_received
                  FROM emrs_d_emrgcy_disenroll rr
                  WHERE  TRUNC(rr.record_date) >= to_date('01/01/2017','mm/dd/yyyy')) d
              JOIN (SELECT emrgcy_disenroll_id,emrgcy_denr_status_code,LAG(record_date,1) OVER (PARTITION BY h.emrgcy_disenroll_id ORDER BY record_date) prev_status_hist_date,record_date,row_num --status_hist_date
                    FROM(SELECT h.emrgcy_denr_id emrgcy_disenroll_id,emrgcy_denr_status_code,record_date
                          ,ROW_NUMBER() OVER (PARTITION BY emrgcy_denr_id,emrgcy_denr_status_code ORDER BY record_date DESC) rn    
                          ,ROW_NUMBER() OVER (PARTITION BY emrgcy_denr_id ORDER BY record_date ) row_num  
                         FROM emrs_d_emrgcy_denr_hist h 
                         WHERE TRUNC(h.record_date) >= to_date('01/01/2017','mm/dd/yyyy')
                         AND h.emrgcy_denr_status_code IN('2','4','B','D','M','5','N','P','R') ) h
                    WHERE ((rn = 1 AND h.emrgcy_denr_status_code IN('2','4','B','D','M')) OR h.emrgcy_denr_status_code NOT IN('2','4','B','D','M'))                    
                    ) h ON d.emrgcy_disenroll_id = h.emrgcy_disenroll_id     
              WHERE 1=1            
              AND h.emrgcy_denr_status_code IN('2','4','B','D','M','5','N','P','R')              
             ) proc
            JOIN corp_etl_list_lkup cl ON cl.name = 'EDER' AND cl.list_type = 'FORM_SLA_DAYS' 
      GROUP BY  processed_date ) proc ON dd.d_date = proc.processed_date
   LEFT JOIN (SELECT TRUNC(h.record_date) received_back_date
                    ,COUNT(DISTINCT CASE WHEN d.plan_type = 'M' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_med_received_back
                    ,COUNT(DISTINCT CASE WHEN d.plan_type = 'D' THEN d.emrgcy_disenroll_id ELSE NULL END) eders_den_received_back
                    ,COUNT(DISTINCT CASE WHEN d.retro_disenroll = 'Y' THEN emrgcy_disenroll_id ELSE NULL END) eders_retro_received_back                    
             FROM emrs_d_emrgcy_denr_hist h
               JOIN emrs_d_emrgcy_disenroll d ON h.emrgcy_denr_id = d.emrgcy_disenroll_id
             WHERE h.emrgcy_denr_status_code IN('1','R','3')
             AND TRUNC(d.record_date) >= to_date('01/01/2017','mm/dd/yyyy')
             GROUP BY TRUNC(h.record_date))  rb ON dd.d_date = rb.received_back_date 
 ) f;
 
 GRANT SELECT ON "EMRS_F_EDERS_BY_DAY_SV" TO "MAXDAT_READ_ONLY";
 