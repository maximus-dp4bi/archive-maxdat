CREATE OR REPLACE VIEW D_REDETERMINATION_OUTCOME_SV
AS
SELECT h.application_id
      ,ai.app_individual_id
      ,s.report_label application_status
     ,CASE WHEN h.status_cd = 'TIMEOUT' THEN 'Termed for No Response' 
            WHEN h.status_cd IN('COMPLETED','INPROCESS') THEN ee.report_label
            WHEN h.status_cd = 'DISREGARDED' AND e.report_label IS NULL AND ee.report_label IS NOT NULL THEN null            
            WHEN h.status_cd = 'DISREGARDED' AND e.report_label IS NOT NULL THEN e.report_label
        --ELSE COALESCE(ee.report_label,e.report_label) END 
  --      ELSE CASE WHEN o.create_ts IS NOT NULL THEN
   --         CASE WHEN o.create_ts > COALESCE(e.create_ts,TO_DATE('01/01/1900','mm/dd/yyyy')) THEN ee.report_label ELSE  e.report_label END 
           ELSE COALESCE(e.report_label,ee.report_label) END    final_outcome
      ,COALESCE(o.update_ts,h.status_date) outcome_date      
      ,CASE WHEN (h.status_cd = 'DISREGARDED' AND e.value NOT IN('APP_LINK_MMIS','APP_APPR_MMIS')) OR h.status_cd = 'TIMEOUT' or (h.status_cd = 'COMPLETED' AND ee.value in('REJECTED','STATE REJECTED')) THEN 'Non-Approval Outcomes'
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
  LEFT OUTER JOIN (SELECT e.*, ae.value, ae.description report_label
                   FROM app_event_log_stg e
                    INNER JOIN app_event_type_lkup ae
                      ON e.app_event_cd = ae.value
                   WHERE ae.value like '%MMIS%'
                   AND ae.value NOT IN('APP_REJ_MMIS','APP_APR_MMIS')
                   AND e.app_event_log_id = (SELECT MAX(app_event_log_id)
                                             FROM app_event_log_stg e1
                                              INNER JOIN app_event_type_lkup ae1
                                                ON e1.app_event_cd = ae1.value
                                             WHERE e1.application_id = e.application_id
                                             --AND ae1.value = ae.value
                                             AND ae1.value like '%MMIS%'
                                             AND ae1.value NOT IN('APP_REJ_MMIS','APP_APR_MMIS')
                                             )) e
   ON h.application_id = e.application_id
WHERE 1=1
AND (h.status_cd IN('COMPLETED','DISREGARDED','TIMEOUT')  
  OR (h.status_cd = 'INPROCESS' AND o.elig_outcome_cd = 'PENDING'));

GRANT SELECT ON D_REDETERMINATION_OUTCOME_SV to MAXDAT_READ_ONLY;