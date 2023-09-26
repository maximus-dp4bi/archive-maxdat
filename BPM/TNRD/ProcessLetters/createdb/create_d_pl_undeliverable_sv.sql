CREATE OR REPLACE VIEW d_pl_undeliverable_sv
AS
SELECT TRUNC(s.letter_create_ts) create_date
       ,TRUNC(COALESCE(s.parent_lmreq_mailed_date,s.letter_mailed_date)) mailed_date
       ,TRUNC(s.letter_return_date) return_date
       ,TRUNC(COALESCE(s.parent_lmreq_mailed_date,s.letter_mailed_date, s.letter_create_ts)) report_date
       ,s.return_reason
       ,s.letter_case_id case_id
       ,s.letter_id letter_request_id
       ,s.letter_type
       ,s.letter_status
       ,CASE WHEN s.letter_request_type != 'L' AND s.letter_status_cd = 'MAIL' THEN s.letter_mailed_date ELSE null END reprint_mailed_date
       ,CASE WHEN s.letter_request_type = 'L' AND s.letter_status_cd = 'MAIL' THEN 1 ELSE 0 END mailed       
       ,CASE WHEN s.letter_request_type != 'L' AND s.letter_status_cd = 'MAIL' AND pr_return_reason IS NOT NULL THEN 1 ELSE 0 END remailed_undeliverable           
       ,CASE WHEN s.letter_request_type != 'L' AND s.letter_status_cd = 'MAIL' AND pr_return_reason IS NULL THEN 1 ELSE 0 END remailed_other 
       ,CASE  WHEN  (s.letter_return_date IS NOT NULL OR s.return_reason IS NOT NULL )
                  THEN 1 ELSE 0 END undeliverable                  
       ,CASE WHEN s.letter_request_type = 'L' AND (s.letter_return_date IS NOT NULL OR s.return_reason IS NOT NULL )
                  THEN 1 ELSE 0 END orig_ltr_undeliverable                  
       ,CASE WHEN s.letter_request_type = 'L' AND s.letter_status_cd = 'MAIL' THEN s.return_reason 
             WHEN s.letter_request_type != 'L' AND s.letter_status = 'MAIL' THEN pr_return_reason  
        ELSE NULL END orig_packet_return_reason
       ,s.latest_reprint_mailed_date
       ,s.count_reprint_sent
FROM (SELECT s.*
             ,(SELECT return_reason FROM letters_stg s1 WHERE s1.letter_id = s.reprint_parent_lmreq_id ) pr_return_reason            
             ,rr.latest_reprint_mailed_date
             ,rr.count_reprint_sent
       FROM letters_stg s              
         LEFT JOIN (SELECT reprint_parent_lmreq_id,MAX(letter_mailed_date) latest_reprint_mailed_date, COUNT(1) count_reprint_sent
               FROM letters_stg rr
               GROUP BY reprint_parent_lmreq_id) rr ON s.letter_id = rr.reprint_parent_lmreq_id        
       WHERE letter_status_cd = 'MAIL'       
      ) s;

GRANT SELECT ON d_pl_undeliverable_sv TO MAXDAT_READ_ONLY;