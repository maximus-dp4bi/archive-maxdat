SELECT (SELECT report_label FROM enum_affected_party_type eap WHERE eap.value = i.affected_party_type_cd) incident_about
       ,(SELECT report_label FROM enum_affected_party_subtype eas WHERE eas.value = i.affected_party_subtype_cd) incident_reason
       ,i.incident_header_id
       ,i.status_ts
       ,i.create_ts
       ,i.created_by
       ,i.update_ts
       ,i.updated_by
       ,be.report_label outreach_method
       ,e.event_id
       ,e.create_ts event_create_ts
FROM eb.incident_header i
  INNER JOIN eb.event e
    ON e.ref_type = 'OUTREACH'
    AND e.ref_id = i.incident_header_id  
  INNER JOIN eb.enum_biz_event_type be
    ON be.value = e.event_type_cd
WHERE incident_header_type_cd = 'OUTREACH REQUEST'
AND i.create_ts >= add_months(trunc(sysdate,'mm'),-2)
-- need to find out what events to capture for WV
AND event_type_cd IN('OUTBOUND_DIALER') 
--remove this later, just using this to limit the population
AND affected_party_subtype_cd in('AA_NEWBORN')  