CREATE OR REPLACE VIEW D_PI_COMPLAINT_CALL_SV
AS 
SELECT case_cin    
    ,COALESCE(cs.case_head_fname, i.reporter_first_name) case_head_fname
    ,COALESCE(cs.case_head_lname, i.reporter_last_name) case_head_lname
    ,COALESCE(cs.case_head_fname||
     CASE
      WHEN SUBSTR(cs.case_head_mi,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(cs.case_head_mi,1,1)||' '
    END ||cs.case_head_lname, i.reporter_first_name||' '||i.reporter_last_name) case_head_full_name
    ,CASE WHEN COALESCE(cr.caller_phone,i.reporter_phone) IS NOT NULL THEN
      '('||SUBSTR( COALESCE(cr.caller_phone,i.reporter_phone),1,3)||')'||SUBSTR( COALESCE(cr.caller_phone,i.reporter_phone),4,3)||'-'||
      SUBSTR( COALESCE(cr.caller_phone,i.reporter_phone),7) END case_phone_number
    ,crl.client_id
    ,crl.case_id
    ,st.report_label AS subprogram
    ,i.incident_header_id pi_bi_id
    ,cr.call_record_id contact_record_id
FROM call_record cr
  INNER JOIN event e ON (e.call_record_id = cr.call_record_id AND e.ref_type = 'INCIDENT' AND e.event_type_cd = 'COMPLAINT_INITIATED')
  INNER JOIN incident_header i ON (e.ref_id = i.incident_header_id)
  LEFT JOIN enum_subprogram_type st ON (cr.call_record_field1 = st.value)  
  LEFT JOIN call_record_link crl ON (cr.call_record_id = crl.call_record_id)    
  LEFT JOIN ats.cases cs ON (crl.case_id = cs.case_id)
WHERE i.incident_header_type_cd = 'COMPLAINT'
;

GRANT SELECT ON MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV TO MAXDAT_REPORTS ;