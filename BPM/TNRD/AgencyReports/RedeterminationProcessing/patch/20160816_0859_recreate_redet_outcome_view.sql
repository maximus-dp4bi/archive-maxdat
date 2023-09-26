CREATE OR REPLACE VIEW D_REDETERMINATION_OUTCOME_SV
AS
SELECT h.application_id
      ,ai.app_individual_id
      ,s.report_label application_status
      ,CASE WHEN h.status_cd = 'TIMEOUT' THEN 'Termed for No Response' 
            WHEN h.status_cd = 'COMPLETED' THEN ee.report_label
        ELSE COALESCE(ee.report_label,e.report_label) END final_outcome
      ,COALESCE(o.update_ts,h.status_date) outcome_date
      ,CASE WHEN (h.status_cd = 'DISREGARDED' AND e.value NOT IN('APP_LINK_MMIS','APP_APPR_MMIS')) OR h.status_cd = 'TIMEOUT' or ee.value in('REJECTED','STATE REJECTED') THEN 'Non-Approval Outcomes'
            WHEN e.value = 'APP_APPR_MMIS' OR (h.status_cd = 'COMPLETED' AND ee.value IN('APPROVED', 'STATE APPROVED')) THEN 'Approvals Outcomes'
       ELSE 'Other Final Outcomes' END outcome_group
      ,orl.report_label outcome_reason
FROM app_header_stg h
  INNER JOIN app_status_lkup s
    ON h.status_cd = s.value
  INNER JOIN app_individual_stg ai
    ON h.application_id = ai.application_id
  LEFT OUTER JOIN app_elig_outcome_stg o
    ON h.application_id = o.application_id
  LEFT OUTER JOIN elig_outcome_lkup ee
    ON o.elig_outcome_cd = ee.value
  LEFT OUTER JOIN elig_outcome_reason_lkup orl
    ON o.elig_outcome_reason_cd = orl.value
  LEFT OUTER JOIN (SELECT * FROM app_event_log_stg e
                    INNER JOIN app_event_type_lkup ae
                      ON e.app_event_cd = ae.value
                   WHERE ae.value like '%MMIS%'
                   AND ae.value NOT IN('APP_REJ_MMIS','APP_APR_MMIS')
                   AND e.app_event_log_id = (SELECT MAX(app_event_log_id)
                                             FROM app_event_log_stg e1
                                              INNER JOIN app_event_type_lkup ae1
                                                ON e1.app_event_cd = ae1.value
                                             WHERE e1.application_id = e.application_id
                                             AND ae1.value = ae.value)) e
   ON h.application_id = e.application_id
WHERE 1=1
--AND h.app_form_cd = 'RENEWAL'
AND h.status_cd IN('COMPLETED','DISREGARDED','TIMEOUT');

GRANT SELECT ON D_REDETERMINATION_OUTCOME_SV to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_REDETERMINATION_FORM_SV
AS
SELECT application_id
       ,receipt_date
       ,application_status
       ,COALESCE(application_type,app_form_cd) application_type
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
        ,app_form_cd
FROM  app_header_stg ah
  INNER JOIN app_individual_stg ai
    ON ah.application_id = ai.application_id
  LEFT OUTER JOIN app_elig_outcome_stg aeo
    ON ai.app_individual_id = aeo.app_individual_id
    AND ai.application_id = aeo.application_id
  INNER JOIN app_status_lkup ast
    ON ah.status_cd = ast.value
  LEFT OUTER JOIN app_type_lkup apt
    ON ah.app_form_cd = apt.value
--WHERE ah.app_form_cd = 'RENEWAL'
);

GRANT SELECT ON D_REDETERMINATION_FORM_SV to MAXDAT_READ_ONLY;