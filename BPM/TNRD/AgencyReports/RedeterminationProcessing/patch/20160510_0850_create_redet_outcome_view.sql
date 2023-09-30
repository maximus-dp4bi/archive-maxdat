CREATE OR REPLACE VIEW D_REDETERMINATION_OUTCOME_SV
AS
SELECT h.application_id
      ,ai.app_individual_id
      ,s.report_label application_status
      ,CASE WHEN h.status_cd = 'TIMEOUT' THEN 'Termed for No Response' ELSE COALESCE(e.report_label,ee.report_label) END final_outcome
      ,COALESCE(o.update_ts,h.status_date) outcome_date
      ,CASE WHEN e.value NOT IN('APP_LINK_MMIS','APP_APPR_MMIS') OR h.status_cd = 'TIMEOUT' or ee.value in('REJECTED','STATE REJECTED') THEN 'Non-Approval Outcomes'
            WHEN e.value = 'APP_APPR_MMIS' OR ee.value IN('APPROVED', 'STATE APPROVED') THEN 'Approvals Outcomes'
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
                   AND ae.value NOT IN('APP_REJ_MMIS','APP_APR_MMIS')) e
   ON h.application_id = e.application_id                   
WHERE h.app_form_cd = 'RENEWAL' 
AND h.status_cd IN('COMPLETED','DISREGARDED','TIMEOUT');

GRANT SELECT ON D_REDETERMINATION_OUTCOME_SV to MAXDAT_READ_ONLY;