CREATE OR REPLACE VIEW MAXDAT_SUPPORT.CALL_DETAIL_SV
AS
  SELECT cr.call_record_id ,
    e.event_id,
    crt.report_label caller_type ,
    ct.report_label call_type ,
    COALESCE(ca.value,b.value) call_action_cd ,
    COALESCE(ca.report_label,b.report_label) call_action ,
    cr.call_start_ts ,
    cr.call_end_ts ,
    cr.caller_phone ,
    cr.ext_telephony_ref ,
    cr.created_by ,
    cr.create_ts ,
    cr.updated_by ,
    cr.update_ts ,
    cr.note_ref_id ,
    cr.caller_first_name ,
    cr.caller_last_name ,
    cr.call_record_field1 ,
    cr.parent_call_record_id
  FROM eb.call_record cr
  JOIN eb.event e                               ON (cr.call_record_id = e.call_record_id)  
  JOIN eb.enum_biz_event_type b                    ON (e.event_type_cd = b.value) 
  JOIN eb.enum_call_type ct                     ON (cr.call_type_cd = ct.value)  
  LEFT OUTER JOIN eb.enum_manual_call_action ca ON (e.context = ca.value)  
  LEFT OUTER JOIN eb.enum_caller_type crt       ON (cr.caller_type_cd = crt.value)
  WHERE cr.create_ts >=add_months(TRUNC(sysdate,'mm'),-6)
  --40480
  UNION ALL
  SELECT cr.call_record_id ,
    0 AS event_id,
    crt.report_label caller_type ,
    ct.report_label call_type ,
    NULL call_action_cd ,
    NULL call_action ,
    cr.call_start_ts ,
    cr.call_end_ts ,
    cr.caller_phone ,
    cr.ext_telephony_ref ,
    cr.created_by ,
    cr.create_ts ,
    cr.updated_by ,
    cr.update_ts ,
    cr.note_ref_id ,
    cr.caller_first_name ,
    cr.caller_last_name ,
    cr.call_record_field1 ,
    cr.parent_call_record_id
  FROM eb.call_record cr
  JOIN eb.enum_call_type ct               ON cr.call_type_cd = ct.value
  LEFT OUTER JOIN eb.enum_caller_type crt ON cr.caller_type_cd = crt.value
  WHERE NOT EXISTS
    (SELECT 1 FROM eb.event e WHERE cr.call_record_id = e.call_record_id
    )
  AND cr.create_ts >=add_months(TRUNC(sysdate,'mm'),-6) ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.CALL_DETAIL_SV TO EB_MAXDAT_REPORTS;