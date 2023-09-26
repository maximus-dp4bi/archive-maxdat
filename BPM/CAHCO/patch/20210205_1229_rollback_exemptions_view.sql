
CREATE OR REPLACE VIEW emrs_f_exemptions_by_day_sv
AS
SELECT d_date
     ,exemptions_med_processed
   --  ,CASE WHEN exemptions_med_remaining < 0 THEN 0 ELSE LAG(exemptions_med_remaining, 1, 0) OVER (ORDER BY d_date) END exemptions_med_inventory  
     ,LAG(exemptions_med_remaining, 1, 0) OVER (ORDER BY d_date)  exemptions_med_inventory     
     ,exemptions_med_received
     ,exemptions_med_remaining  
     ,exemptions_med_pending_mmcd
     ,exemptions_med_processed_prior
     ,exemptions_med_disenrollment
     ,exemptions_med_denied
     ,exemptions_med_approved  
     ,exemptions_med_pending_maximus
     ,exemptions_med_avg_process_time
     ,exemptions_med_processed_timely
     ,exemptions_med_processed_untimely
     ,exemptions_den_processed
   --  ,CASE WHEN exemptions_den_remaining < 0 THEN 0 ELSE LAG(exemptions_den_remaining, 1, 0) OVER (ORDER BY d_date) END exemptions_den_inventory 
     ,LAG(exemptions_den_remaining, 1, 0) OVER (ORDER BY d_date)  exemptions_den_inventory
     ,exemptions_den_received
     ,exemptions_den_remaining  
     ,exemptions_den_pending_mmcd
     ,exemptions_den_processed_prior
     ,exemptions_den_disenrollment
     ,exemptions_den_denied
     ,exemptions_den_approved
     ,exemptions_den_pending_maximus
     ,exemptions_den_avg_process_time
     ,exemptions_den_processed_timely
     ,exemptions_den_processed_untimely          
FROM (     
  SELECT dd.d_date
    ,dd.d_month
    ,COALESCE(exemptions_med_processed,0) exemptions_med_processed
    ,COALESCE(exemptions_med_received,0) exemptions_med_received
    ,COALESCE(exemptions_med_pending_mmcd,0) exemptions_med_pending_mmcd
    ,COALESCE(exemptions_med_processed_prior,0) exemptions_med_processed_prior
    ,COALESCE(exemptions_med_disenrollment,0) exemptions_med_disenrollment
    ,COALESCE(exemptions_med_denied,0) exemptions_med_denied
    ,COALESCE(exemptions_med_approved,0) exemptions_med_approved
    ,COALESCE(exemptions_med_pending_maximus,0) exemptions_med_pending_maximus
    ,COALESCE(ROUND(exemptions_med_process_time/CASE WHEN (exemptions_med_processed_timely + exemptions_med_processed_untimely) = 0 THEN 1 ELSE (exemptions_med_processed_timely + exemptions_med_processed_untimely) END,1),0) exemptions_med_avg_process_time
    ,COALESCE(exemptions_med_processed_timely,0) exemptions_med_processed_timely
    ,COALESCE(exemptions_med_processed_untimely,0) exemptions_med_processed_untimely
    ,COALESCE(exemptions_den_processed,0) exemptions_den_processed
    ,COALESCE(exemptions_den_received,0) exemptions_den_received
    ,COALESCE(exemptions_den_pending_mmcd,0) exemptions_den_pending_mmcd
    ,COALESCE(exemptions_den_processed_prior,0) exemptions_den_processed_prior
    ,COALESCE(exemptions_den_disenrollment,0) exemptions_den_disenrollment
    ,COALESCE(exemptions_den_denied,0) exemptions_den_denied
    ,COALESCE(exemptions_den_approved,0) exemptions_den_approved
    ,COALESCE(exemptions_den_pending_maximus,0) exemptions_den_pending_maximus
    ,COALESCE(ROUND(exemptions_den_process_time/CASE WHEN (exemptions_den_processed_timely + exemptions_den_processed_untimely) = 0 THEN 1 ELSE (exemptions_den_processed_timely + exemptions_den_processed_untimely) END,1),0) exemptions_den_avg_process_time
    ,COALESCE(exemptions_den_processed_timely,0) exemptions_den_processed_timely
    ,COALESCE(exemptions_den_processed_untimely,0) exemptions_den_processed_untimely    
    ,SUM(COALESCE(exemptions_med_received,0) - COALESCE(exemptions_med_processed,0)) OVER (ORDER BY d_date)  exemptions_med_remaining
    ,SUM(COALESCE(exemptions_den_received,0) - COALESCE(exemptions_den_processed,0)) OVER (ORDER BY d_date)  exemptions_den_remaining 
 
FROM bpm_d_dates dd 
    LEFT JOIN (SELECT TRUNC(d.record_date) record_date,
                  COUNT(DISTINCT CASE WHEN d.plan_type = 'M' THEN d.exemption_id ELSE NULL END) exemptions_med_received     
                 ,COUNT(DISTINCT CASE WHEN d.plan_type = 'D' THEN d.exemption_id ELSE NULL END) exemptions_den_received
               FROM emrs_d_exemption_req d 
               WHERE TRUNC(d.record_date)>= to_date('01/01/2017','mm/dd/yyyy')               
               GROUP BY TRUNC(d.record_date)) d  ON dd.d_date = TRUNC(d.record_date) 
    LEFT JOIN(SELECT processed_date
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('A','B','S','T','U','R') AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_processed                      
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('D') AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_pending_mmcd
           ,COUNT(DISTINCT CASE WHEN proc.enrollment_status NOT IN('U','E','F','G','I') AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_processed_prior
           ,COUNT(DISTINCT CASE WHEN proc.disenrollment_id > 0 AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_disenrollment
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('S','T','U','R') AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_denied       
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('A','B') AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_approved
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code NOT IN('A','B','S','T','U','R','D') AND proc.plan_type = 'M' THEN proc.exemption_id ELSE null END) exemptions_med_pending_maximus
           ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process <= TO_NUMBER(cl.out_var) AND proc.plan_type = 'M' THEN proc.exemption_id ELSE NULL END) exemptions_med_processed_timely
           ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process > TO_NUMBER(cl.out_var) AND proc.plan_type = 'M' THEN proc.exemption_id ELSE NULL END) exemptions_med_processed_untimely       
       
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('A','B','S','T','U','R') AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_processed                         
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('D') AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_pending_mmcd
           ,COUNT(DISTINCT CASE WHEN proc.enrollment_status NOT IN('U','E','F','G','I') AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_processed_prior
           ,COUNT(DISTINCT CASE WHEN proc.disenrollment_id > 0 AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_disenrollment
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('S','T','U','R') AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_denied
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code IN('A','B') AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_approved
           ,COUNT(DISTINCT CASE WHEN proc.exemption_status_code NOT IN('A','B','S','T','U','R','D') AND proc.plan_type = 'D' THEN proc.exemption_id ELSE null END) exemptions_den_pending_maximus
           ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process <= TO_NUMBER(cl.out_var) AND proc.plan_type = 'D' THEN proc.exemption_id ELSE NULL END) exemptions_den_processed_timely
           ,COUNT(DISTINCT CASE WHEN proc.row_num = 1 AND proc.days_to_process > TO_NUMBER(cl.out_var) AND proc.plan_type = 'D' THEN proc.exemption_id ELSE NULL END) exemptions_den_processed_untimely              
           ,SUM(CASE WHEN proc.row_num = 1 AND proc.plan_type = 'M' THEN proc.days_to_process ELSE 0 END) exemptions_med_process_time
           ,SUM(CASE WHEN proc.row_num = 1 AND proc.plan_type = 'D' THEN proc.days_to_process ELSE 0 END) exemptions_den_process_time             
        FROM (SELECT d.plan_type,
                   d.dcn,
                   h.exemption_status_code,
                   h.status_hist_date record_date,
                   d.approved_status_date,
                   d.denial_status_date,
                   d.pending_status_date,
                   h.exemption_id,
                   d.disenrollment_id,
                   d.enrollment_status,
                   TRUNC(status_hist_date) processed_date,        
                   TRUNC(prev_status_hist_date) prev_status_hist_date,             
                   CASE WHEN d.record_date >= COALESCE(d.date_form_received,d.record_date) THEN 
                     (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                      FROM bpm_d_dates s
                      WHERE business_day_flag = 'Y'
                      AND s.d_date BETWEEN TRUNC(COALESCE(d.date_form_received,d.record_date)) AND TRUNC(d.record_date)  ) ELSE 0 END days_to_process 
                   ,row_num
            FROM (SELECT rr.*,
                     CASE WHEN SUBSTR(rr.dcn,1,5) NOT LIKE '%[^0-9]%' AND LENGTH(SUBSTR(rr.dcn,1,5)) = 5 THEN     
                          TO_DATE(SUBSTR(rr.dcn,1,2)||'0101','yymmdd') + substr(rr.dcn,3,3)-1 
                        ELSE rr.record_date END date_form_received
                  FROM emrs_d_exemption_req rr
                  WHERE TRUNC(rr.record_date) >= to_date('01/01/2017','mm/dd/yyyy')) d              
              JOIN (SELECT exemption_id,exemption_status_code,LAG(record_date,1) OVER (PARTITION BY h.exemption_id ORDER BY record_date) prev_status_hist_date,record_date status_hist_date,row_num
                    FROM(SELECT exemption_id,exemption_status_code,record_date
                          ,ROW_NUMBER() OVER (PARTITION BY exemption_id,exemption_status_code ORDER BY record_date DESC) rn 
                          ,ROW_NUMBER() OVER (PARTITION BY exemption_id ORDER BY record_date ) row_num   
                         FROM emrs_d_exempt_status_hist h 
                         WHERE exemption_status_code NOT IN('1','4','UK','X') ) h
                    WHERE ((rn = 1 AND exemption_status_code IN('A','B','S','T','U','R')) OR exemption_status_code NOT IN('1','4','UK','X','A','B','S','T','U','R') ) ) h ON d.exemption_id = h.exemption_id              
            WHERE 1=1
            AND h.exemption_status_code NOT IN('1','4','UK','X') 
            AND TRUNC(h.status_hist_date) >= to_date('01/01/2017','mm/dd/yyyy') 
            ) proc
            JOIN corp_etl_list_lkup cl ON cl.name = 'Exemption' AND cl.list_type = 'FORM_SLA_DAYS'            
    GROUP BY processed_date ) proc ON dd.d_date = proc.processed_date        
);

GRANT SELECT ON "EMRS_F_EXEMPTIONS_BY_DAY_SV" TO "MAXDAT_READ_ONLY";
