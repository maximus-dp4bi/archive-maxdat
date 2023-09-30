
DROP VIEW F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV;

CREATE OR REPLACE VIEW F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV 
AS
WITH submitted AS (
SELECT h.incident_header_id
      ,h.create_ts submitted_date
    FROM incident_header_stat_hist h
    WHERE h.status_cd in ('OUTREACH_REQUEST_PENDING','SUBMIT_LME_MCO','SUBMIT_BEACON')
)
SELECT distinct i.incident_header_id 
       ,h.status_cd request_status_code
       ,h.create_ts record_date
       ,CASE WHEN i.incident_header_id = submitted.incident_header_id  THEN submitted.submitted_date END submitted_date
       ,CASE WHEN i.affected_party_type_cd = 'SATPR' THEN i.incident_header_id ELSE null END urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  THEN i.incident_header_id ELSE null END non_urgent_request      
       ,apt.report_label referral_desc            
       ,s.report_label request_status_description       
FROM incident_header i
  JOIN (SELECT *
        FROM(SELECT incident_header_id,status_cd,create_ts
               ,ROW_NUMBER() OVER (PARTITION BY h.incident_header_id,h.status_cd,TRUNC(h.create_ts) ORDER BY h.create_ts DESC,incident_header_stat_hist_id DESC) rrn 
             FROM incident_header_stat_hist h
             --WHERE request_status_code IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING')
         )
         WHERE rrn = 1  ) h  ON i.incident_header_id = h.incident_header_id
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL AND scope = 'OUTREACHREQUEST') apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=h.status_cd)        
  LEFT JOIN submitted ON submitted.incident_header_id = i.incident_header_id
WHERE  i.incident_header_type_cd = 'OUTREACH REQUEST'
AND i.affected_party_type_cd IN('REFERRAL', 'SATPR')
AND i.status_cd IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING','SUBMIT_LME_MCO','SUBMIT_BEACON','APPROVED_BEACON','DENIED_BEACON','SA_WAIT_SIGN','NSA_SIGNATURE','CANCELLED')
UNION ALL
SELECT NULL incident_header_id
      ,s.value request_status_code      
      ,d_date record_date
      ,NULL submitted_date
      ,NULL urgent_request
      ,NULL non_urgent_request
      ,apt.report_label referral_desc
      ,s.report_label request_status_description      
FROM d_dates
  CROSS JOIN eb.enum_affected_party_type apt        
  CROSS JOIN eb.enum_incident_header_status s 
WHERE apt.value in ('REFERRAL', 'SATPR')
AND d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13)
AND d_date <= TRUNC(sysdate)
;

GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV TO MAXDATSUPPORT_READ_ONLY;