CREATE OR REPLACE VIEW D_PI_COMPLAINT_CALL_SV
AS 
SELECT distinct --cs.case_cin,
    i.reporter_first_name
    ,i.reporter_last_name
    ,CASE WHEN LENGTH(reporter_last_name) > 1
          THEN i.reporter_first_name||' '||i.reporter_last_name 
          ELSE NULL
          END AS reporter_full_name
    ,CASE WHEN i.reporter_phone IS NOT NULL THEN
      '('||SUBSTR( i.reporter_phone,1,3)||')'||SUBSTR( i.reporter_phone,4,3)||'-'||
     SUBSTR( i.reporter_phone,7) END reporter_phone
    ,COALESCE(crl.client_id,i.client_id) client_id
    ,i.case_id
    ,st.report_label AS subprogram
    ,i.incident_header_id pi_bi_id
    ,cr.call_record_id contact_record_id
    ,i.origin_cd
FROM incident_header i
  INNER JOIN event e  ON (i.incident_header_id = e.ref_id AND e.ref_type = 'INCIDENT' AND e.event_type_cd = 'COMPLAINT_INITIATED')  
  LEFT JOIN call_record cr ON e.call_record_id = cr.call_record_id 
  LEFT JOIN enum_subprogram_type st ON (cr.call_record_field1 = st.value)  
  LEFT JOIN call_record_link crl ON (cr.call_record_id = crl.call_record_id)    
--  LEFT JOIN eb.cases cs ON (i.case_id = cs.case_id)  
WHERE i.incident_header_type_cd = 'COMPLAINT'
order by i.incident_header_id;

GRANT SELECT ON MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV TO MAXDAT_REPORTS ;