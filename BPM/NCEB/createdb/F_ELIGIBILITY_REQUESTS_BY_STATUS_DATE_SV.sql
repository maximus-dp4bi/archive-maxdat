DROP VIEW F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV;

CREATE OR REPLACE VIEW F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV 
AS
SELECT request_status_code
       ,request_status_description
       ,record_date      
       ,COUNT(DISTINCT urgent_request) urgent_request_count
       ,COUNT(DISTINCT non_urgent_request) non_urgent_request_count
       ,COUNT(DISTINCT incident_header_id) request_count
       ,COUNT(DISTINCT provider_non_urgent_request) provider_non_urgent_request_count
       ,COUNT(DISTINCT client_non_urgent_request) client_non_urgent_request_count
       ,COUNT(DISTINCT unknown_non_urgent_request) unknown_non_urgent_request_count
       ,COUNT(DISTINCT provider_urgent_request) provider_urgent_request_count
FROM (
SELECT i.incident_header_id 
       ,h.status_cd request_status_code
       ,TRUNC(h.create_ts) record_date
       ,CASE WHEN i.affected_party_type_cd = 'SATPR' THEN i.incident_header_id ELSE null END urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  THEN i.incident_header_id ELSE null END non_urgent_request 
       ,apt.report_label referral_desc            
       ,s.report_label request_status_description       
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  AND dt.doc_form_type_cd = 'TP_NS_PRV' THEN i.incident_header_id ELSE null END provider_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  AND dt.doc_form_type_cd = 'TP_NS_MEM' THEN i.incident_header_id ELSE null END client_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  AND dt.doc_form_type_cd IS NULL THEN i.incident_header_id ELSE null END unknown_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'SATPR' THEN i.incident_header_id ELSE null END provider_urgent_request
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
  LEFT JOIN (SELECT ih.incident_header_id,dd.client_id,dd.doc_form_type_cd,dd.update_ts,ROW_NUMBER() OVER (PARTITION BY ih.incident_header_id,dd.client_id ORDER BY dd.doc_link_id) rnum
             FROM incident_header ih
                LEFT JOIN(SELECT dl.*,tt.value doc_form_type_cd FROM doc_link dl
                           JOIN document d ON dl.document_id = d.document_id
                           JOIN enum_document_type t1 on t1.value = d.doc_form_type
                           JOIN enum_doc_code_to_type tt ON t1.value = tt.value
                          WHERE tt.value like 'TP%') dd ON ih.client_id = dd.client_id AND TRUNC(ih.create_ts) >= TRUNC(dd.update_ts)) dt ON dt.incident_header_id = i.incident_header_id AND rnum = 1  
WHERE  i.incident_header_type_cd = 'OUTREACH REQUEST'
AND i.affected_party_type_cd IN('REFERRAL', 'SATPR')
AND i.status_cD IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING','SUBMIT_LME_MCO','SUBMIT_BEACON','APPROVED_BEACON','DENIED_BEACON','SA_WAIT_SIGN','NSA_SIGNATURE','CANCELLED')
UNION ALL
SELECT NULL incident_header_id
      ,s.value request_status_code      
      ,d_date record_date
      ,NULL urgent_request
      ,NULL non_urgent_request
      ,apt.report_label referral_desc
      ,s.report_label request_status_description      
      ,NULL provider_non_urgent_request
      ,NULL client_non_urgent_request
      ,NULL unknown_non_urgent_request   
      ,NULL provider_urgent_request
FROM d_dates
  CROSS JOIN eb.enum_affected_party_type apt        
  CROSS JOIN eb.enum_incident_header_status s 
WHERE apt.value in ('REFERRAL', 'SATPR')
AND d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13)
AND d_date <= TRUNC(sysdate)
)
GROUP BY request_status_code,request_status_description,record_date ;

GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV TO MAXDATSUPPORT_READ_ONLY;