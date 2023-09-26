USE SCHEMA COVERVA_MIO;
CREATE OR REPLACE VIEW mio_inventory_full_load_vw AS
SELECT cpl.*,
  RANK() OVER(PARTITION BY cpl.case_number ORDER BY DECODE(cpl.mio_current_state,'Waiting for Verification Documents',1,'Initial Review Complete',2,'Waiting Initial Review',3),cpl.disposition_date DESC) status_rank,
  RANK() OVER(PARTITION BY cpl.case_number ORDER BY cpl.mio_term_state_rank,cpl.disposition_date DESC, cpl.id DESC) latest_dispo_rank
FROM(
   SELECT 
        cp.id,
        e.first_name AS first_name,
        e.last_name AS last_name,
        e.ldap_id AS ldap_id,
        cp.case_number AS case_number,
        cp.task_status AS task_status,
        cp.denial_reason AS denial_reason,
        cp.transferred_to AS transferred_to,
        cp.location AS location,
        cp.why AS why,
        cp.additional_case_outcomes AS additional_case_outcomes,
        cp.number_approved AS number_approved,
        cp.vcl_doc_type_requested AS vcl_doc_type_requested,
        cp.vcl_due AS vcl_due,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.bucket_date) AS disposition_date,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.updated) AS updated,
        CASE WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
               OR UPPER(task_status) = 'VCL SENT' THEN 'Waiting for Verification Documents'                                       
             WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, EMERGENCY SERVICES'
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'  
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, SVES'
               OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 'Initial Review Complete'                
             WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','APPROVED','DENIED','SENT TO LDSS','RESEARCH COMPLETED NO ACTION TAKEN','REASSIGNED IN CONNECTION POINT')               
               OR UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) = 'RE REGISTRATION NEEDED'
               OR UPPER(task_status) = 'OTHER TRANSFER'
               OR UPPER(task_status) = 'PENDING' AND (why IS NULL OR why IN('QUESTION','SUP REVIEW')) THEN 'Waiting Initial Review'                                       
             WHEN UPPER(task_status) IN('ABD APPROVED','EX PARTE') THEN 'Approved'
             WHEN UPPER(task_status) IN('CANCELLED COVERAGE','PENDING CLOSURE') THEN 'Denied'
           ELSE 'Waiting Initial Review' END mio_current_state,
         CASE WHEN case_type = 'R' THEN
            CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 'Transferred to LDSS' 
                 WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 'Approved'
                 WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 'Denied'                                          
                 WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
                   OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 'Complete - Needs Research'
                 WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                   OR UPPER(task_status) = 'VCL SENT' THEN 'Waiting for Verification Documents'  
             ELSE 'Waiting Initial Review' END 
          ELSE
            CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 'Transferred to LDSS' 
                 WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 'Approved'
                 WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 'Denied'                                          
                 WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
                   OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, EMERGENCY SERVICES'
                   OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'  
                   OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, SVES'
                   OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 'Complete - Needs Research'
                 WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                   OR UPPER(task_status) = 'VCL SENT' THEN 'Waiting for Verification Documents'  
             ELSE 'Waiting Initial Review' END 
          END mio_term_state,
        CASE WHEN case_type = 'R' THEN
          CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 1 
               WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 1
               WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 1
               WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')               
                 OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 2
               WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                 OR UPPER(task_status) = 'VCL SENT' THEN 3 
           ELSE 4 END 
        ELSE
          CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 1 
               WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 1
               WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 1
               WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
                 OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, EMERGENCY SERVICES'
                 OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'  
                 OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, SVES'
                 OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 2
               WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                 OR UPPER(task_status) = 'VCL SENT' THEN 3 
           ELSE 4 END       
        END mio_term_state_rank,
         case_put_on_hold,
         case_type
    FROM coverva_mio.case_pool cp
      LEFT JOIN coverva_mio.employees e ON e.id = cp.assigned_to 
    WHERE bucket_date IS NOT NULL
    AND NOT EXISTS(SELECT 1 FROM coverva_mio.case_pool_log cpl WHERE cp.case_number = cpl.case_number)
  UNION ALL
    SELECT  cp.id,
        e.first_name AS first_name,
        e.last_name AS last_name,
        e.ldap_id AS ldap_id,
        cp.case_number AS case_number,
        cp.task_status AS task_status,
        cp.denial_reason AS denial_reason,
        cp.transferred_to AS transferred_to,
        cp.location AS location,
        cp.why AS why,
        cp.additional_case_outcomes AS additional_case_outcomes,
        cp.number_approved AS number_approved,
        cp.vcl_doc_type_requested AS vcl_doc_type_requested,
        cp.vcl_due AS vcl_due,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.bucket_date) AS disposition_date,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.updated) AS updated,
        CASE WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
               OR UPPER(task_status) = 'VCL SENT' THEN 'Waiting for Verification Documents'                                       
             WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, EMERGENCY SERVICES'
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'  
               OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, SVES'
               OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 'Initial Review Complete'                
             WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','APPROVED','DENIED','SENT TO LDSS','RESEARCH COMPLETED NO ACTION TAKEN','REASSIGNED IN CONNECTION POINT')               
               OR UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) = 'RE REGISTRATION NEEDED'
               OR UPPER(task_status) = 'OTHER TRANSFER'
               OR UPPER(task_status) = 'PENDING' AND (why IS NULL OR why IN('QUESTION','SUP REVIEW')) THEN 'Waiting Initial Review'                                       
             WHEN UPPER(task_status) IN('ABD APPROVED','EX PARTE') THEN 'Approved'
             WHEN UPPER(task_status) IN('CANCELLED COVERAGE','PENDING CLOSURE') THEN 'Denied'
           ELSE 'Waiting Initial Review' END mio_current_state,
          CASE WHEN case_type = 'R' THEN
            CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 'Transferred to LDSS' 
                 WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 'Approved'
                 WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 'Denied'                                          
                 WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
                   OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 'Complete - Needs Research'
                 WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                   OR UPPER(task_status) = 'VCL SENT' THEN 'Waiting for Verification Documents'  
             ELSE 'Waiting Initial Review' END 
          ELSE
            CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 'Transferred to LDSS' 
                 WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 'Approved'
                 WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 'Denied'                                          
                 WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
                   OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, EMERGENCY SERVICES'
                   OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'  
                   OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, SVES'
                   OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 'Complete - Needs Research'
                 WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                   OR UPPER(task_status) = 'VCL SENT' THEN 'Waiting for Verification Documents'  
             ELSE 'Waiting Initial Review' END 
          END mio_term_state,
        CASE WHEN case_type = 'R' THEN
          CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 1 
               WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 1
               WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 1
               WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')               
                 OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 2
               WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                 OR UPPER(task_status) = 'VCL SENT' THEN 3 
           ELSE 4 END 
        ELSE
          CASE WHEN UPPER(task_status) IN('TRANSFERRED TO LDSS','SENT TO LDSS') THEN 1 
               WHEN UPPER(task_status) IN('APPROVED','ABD APPROVED','EX PARTE') THEN 1
               WHEN UPPER(task_status) IN('DENIED','CANCELLED COVERAGE','PENDING CLOSURE') THEN 1
               WHEN UPPER(task_status) IN('CHANGES COMPLETED','COMPLETE NO ACTION NEEDED')
                 OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, EMERGENCY SERVICES'
                 OR CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%HELP%'  
                 OR CONCAT(UPPER(task_status),', ',UPPER(why)) = 'PENDING, SVES'
                 OR (UPPER(task_status) = 'OTHER' AND UPPER(additional_case_outcomes) IN('ECPR TOOL NEEDED','SAVE REQUEST SENT','DMAS ACTION NEEDED')) THEN 2
               WHEN CONCAT(UPPER(task_status),', ',UPPER(why)) LIKE 'PENDING%VCL%' 
                 OR UPPER(task_status) = 'VCL SENT' THEN 3 
           ELSE 4 END       
        END mio_term_state_rank,
         case_put_on_hold,
         case_type
    FROM (SELECT *
          FROM(SELECT cp.*, RANK() OVER (PARTITION BY cp.case_number,cp.bucket_date ORDER BY id DESC) rnk
               FROM coverva_mio.case_pool_log cp
               WHERE action NOT IN('Insert','Delete'))
          WHERE rnk = 1 ) cp    
      LEFT JOIN coverva_mio.employees e ON e.id = cp.assigned_to 
    WHERE bucket_date IS NOT NULL
    ) cpl;