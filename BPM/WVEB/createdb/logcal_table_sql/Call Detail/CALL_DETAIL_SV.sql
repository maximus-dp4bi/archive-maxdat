SELECT cr.call_record_id
       ,crt.report_label caller_type
       ,ct.report_label call_type
       ,e.report_label call_action
       ,cr.call_start_ts
       ,cr.call_end_ts
       ,cr.caller_phone
       ,cr.ext_telephony_ref
       ,cr.created_by
       ,cr.create_ts
       ,cr.updated_by
       ,cr.update_ts
       ,cr.note_ref_id
       ,cr.caller_first_name
       ,cr.caller_last_name
       ,cr.authorized_contact_id
       ,cr.call_record_field1
       ,cr.parent_call_record_id       
FROM eb.call_record cr
  LEFT OUTER JOIN (SELECT * FROM eb.event e
                     LEFT OUTER JOIN eb.enum_manual_call_action ca
                      ON e.context = ca.value     
                    WHERE e.event_type_cd = 'MANUAL_ACTION' and e.create_ts<=sysdate-3) e
     ON cr.call_record_id = e.call_record_id                    
  INNER JOIN eb.enum_call_type ct
     ON cr.call_type_cd = ct.value
  INNER JOIN eb.enum_caller_type crt
     ON cr.caller_type_cd = crt.value
where cr.call_start_ts>=add_months(trunc(sysdate,'mm'),-2)