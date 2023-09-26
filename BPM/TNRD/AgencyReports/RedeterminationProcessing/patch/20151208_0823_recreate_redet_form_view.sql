CREATE OR REPLACE VIEW D_REDETERMINATION_FORM_SV
AS
SELECT application_id
       ,receipt_date
       ,application_status
       ,application_type
       ,member_id
       ,coverage_end_date
       ,days_lapsed
       ,sla_category
       ,sla_agreement_days
       ,processed_date       
       ,COALESCE(TRUNC(processed_date),TRUNC(sysdate)) - TRUNC(receipt_date) age_in_calendar_days
       ,CASE WHEN processed_date IS NULL THEN 'Not Processed'
            WHEN TRUNC(processed_date) - TRUNC(receipt_date) <= sla_agreement_days THEN 'Timely'
         ELSE 'Untimely' END timeliness_status         
       ,eligibility_outcome
FROM (         
SELECT ah.application_id
       --,ah.receipt_date
       ,(SELECT MIN(ds.received_date) FROM document_set_stg ds INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
          INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id WHERE doc_type_cd = 'APPLICATION' AND link_type_cd = 'APPLICATION'
          AND link_ref_id = ah.application_id) receipt_date
       ,ast.report_label application_status
       ,apt.report_label application_type
       ,ai.client_cin member_id      
       ,renewal_due_date coverage_end_date       
       ,TRUNC(receipt_date) - TRUNC(renewal_due_date) days_lapsed
       ,'Redetermination Processing' sla_category
       ,(SELECT TO_NUMBER(value) FROM corp_etl_control WHERE name = 'REDET_PROCESSING_SLA_DAYS') sla_agreement_days
       ,CASE WHEN status_cd IN('COMPLETED','DISREGARDED','TIMEOUT') THEN status_date 
             ELSE (SELECT MAX(letter_mailed_date) FROM letters_stg lr                    
                     INNER JOIN app_case_link_stg acl ON lr.letter_case_id = acl.case_id
                     WHERE acl.application_id = ah.application_id
                     AND (lr.letter_type_cd LIKE 'TN406%' OR lr.letter_type_cd = 'TN412') )                    
          END  processed_date 
          ,(SELECT report_label FROM elig_outcome_lkup eeo WHERE eeo.value = aeo.elig_outcome_cd) eligibility_outcome
FROM  app_header_stg ah
  INNER JOIN app_individual_stg ai
    ON ah.application_id = ai.application_id
  LEFT OUTER JOIN app_elig_outcome_stg aeo
    ON ai.app_individual_id = aeo.app_individual_id    
    AND ai.application_id = aeo.application_id
  INNER JOIN app_status_lkup ast
    ON ah.status_cd = ast.value
  INNER JOIN app_type_lkup apt
    ON ah.app_form_cd = apt.value
WHERE ah.app_form_cd = 'RENEWAL'
);

GRANT SELECT ON D_REDETERMINATION_FORM_SV to MAXDAT_READ_ONLY;