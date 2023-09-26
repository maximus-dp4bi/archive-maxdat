SELECT 
i.incident_header_id PI_BI_ID
,i.incident_header_id INCIDENT_ID
,i.tracking_number INCIDENT_TRACKING_NUMBER
,i.received_ts RECEIPT_DATE
,i.create_ts CREATE_DATE
,(SELECT g.group_name FROM eb.groups g WHERE g.group_id=i.responsible_staff_group_id) CREATED_BY_GROUP
,i.origin_id 
,(SELECT o.report_label FROM eb.enum_incident_origin o WHERE o.value=i.origin_cd) CHANNEL
,0 AGE_IN_BUSINESS_DAYS
,trunc(CASE WHEN status_cd IN('CLOSED','WITHDRAWN','APPEAL_WITHDRAWN') THEN status_ts ELSE sysdate END) - trunc(i.create_ts) AGE_IN_CALENDAR_DAYS
,0 PROCESS_CLIENT_NOTIFICATION_ID
,CASE WHEN status_cd IN('CLOSED','WITHDRAWN','APPEAL_WITHDRAWN') THEN 'Complete' ELSE 'Active' END CUR_INSTANCE_STATUS
,CASE WHEN status_cd IN('WITHDRAWN','APPEAL_WITHDRAWN') THEN status_ts ELSE NULL END CANCEL_DATE
,(SELECT t.report_label FROM eb.enum_incident_header_type t WHERE t.value=i.incident_header_type_cd) INCIDENT_TYPE
,(SELECT pa.report_label FROM eb.enum_affected_party_type pa WHERE pa.value=i.affected_party_type_cd) CUR_INCIDENT_ABOUT
,(SELECT pa.report_label FROM eb.enum_affected_party_subtype pa WHERE pa.value=i.affected_party_subtype_cd) CUR_INCIDENT_REASON
,(SELECT n.provider_id FROM eb.network n WHERE n.network_id_ext=i.network_id_ext) ABOUT_PROVIDER_ID
,(SELECT plan_code FROM eb.plans p WHERE p.plan_id_ext = i.plan_id_ext AND rownum=1) ABOUT_PLAN_CODE
,(SELECT s.report_label FROM eb.enum_incident_header_status s WHERE s.value=i.status_cd) CUR_INCIDENT_STATUS
,i.status_ts CUR_INCIDENT_STATUS_DATE
,0 STATUS_AGE_IN_BUSINESS_DAYS
,CASE WHEN  status_cd IN('CLOSED','WITHDRAWN','APPEAL_WITHDRAWN') THEN 0 ELSE trunc(sysdate) - trunc(i.status_ts) END STATUS_AGE_IN_CALENDAR_DAYS
,CASE WHEN  status_cd IN('CLOSED','WITHDRAWN','APPEAL_WITHDRAWN') THEN 'NA' ELSE 
   CASE WHEN TRUNC(sysdate) - TRUNC(i.create_ts) >= 20 THEN 'Y' ELSE 'N' END END CUR_JEOPARDY_STATUS
,sysdate JEOPARDY_STATUS_DATE
,CASE WHEN status_cd IN('CLOSED','WITHDRAWN','APPEAL_WITHDRAWN') THEN i.status_ts ELSE NULL END COMPLETE_DATE
,(SELECT r.report_label FROM eb.enum_reporter_type r WHERE r.value=i.reporter_type_cd) REPORTED_BY
,(SELECT rr.report_label FROM eb.enum_relationship rr WHERE rr.value=i.reporter_relationship) REPORTER_RELATIONSHIP
,i.case_id CASE_ID
,NULL CUR_ENROLLMENT_STATUS
,(SELECT p.report_label FROM eb.enum_priority p WHERE p.value=i.priority_cd) PRIORITY
,'MEDICAID' PROGRAM
,NULL SUB_PROGRAM
,i.update_ts CUR_LAST_UPDATE_DATE
,COALESCE((SELECT s.last_name||','||s.first_name||' '||s.middle_name FROM staff s WHERE TO_CHAR(s.staff_id)=i.updated_by),i.updated_by) CUR_LAST_UPDATE_BY_NAME
,NULL PLAN_CODE
,NULL PROVIDER_ID
,(SELECT a.report_label FROM eb.enum_action_taken a WHERE a.value=i.action_taken_cd) ACTION_TYPE
,(SELECT r.report_label FROM eb.enum_resolution_type r WHERE r.value=i.resolution_type_cd) RESOLUTION_TYPE
,'N' NOTIFY_CLIENT_FLAG
,NULL PROCESS_CLNT_NOTIFY_START_DT
,NULL PROCESS_CLNT_NOTIFY_END_DT
,NULL PROCESS_CLNT_NOTIFY_FLAG
,NULL ESCALATE_INCIDENT_FLAG
--,(SELECT MIN(h.create_ts) FROM incident_header_stat_hist h WHERE h.incident_header_id=i.incident_header_id AND h.status_cd in ('REFERRED_TO_STATE')) 
,NULL ESCALATE_TO_STATE_DT
,(SELECT MAX(step_instance_id) FROM eb.step_instance si, eb.step_definition sd WHERE ref_type='incident_header'AND si.step_definition_id = sd.step_definition_id
   AND sd.step_type_cd in ('VIRTUAL_HUMAN_TAX','HUMAN_TASK')
   AND si.completed_ts IS NULL
   AND ref_id=i.incident_header_id) CUR_TASK_ID
,NULL STATE_RECEIVED_APPEAL_DATE
,NULL HEARING_DATE
,NULL SELECTION_ID
,CASE WHEN i.status_cd IN('CLOSED') THEN 
        CASE WHEN TRUNC(i.status_ts) - TRUNC(i.create_ts) <= 30 THEN 'Processed Timely' ELSE 'Processed Untimely' END
      WHEN i.status_cd != 'CLOSED' THEN 'Not Processed' 
      ELSE null END TIMELINESS_STATUS
,(CASE WHEN (i.eb_follow_up_needed_ind IS NULL or i.eb_follow_up_needed_ind=0 ) then 'N'
       when i.eb_follow_up_needed_ind=1 then 'Y' ELSE null END) EB_FOLLOWUP_NEEDED_FLAG
,(SELECT o.report_label FROM eb.enum_other_party_type o WHERE o.value=i.other_party_type_cd) OTHER_PARTY_NAME
,NULL RESEARCH_INCIDENT_ST_DT
,NULL RESEARCH_INCIDENT_END_DT
,NULL PROCESS_INCIDENT_ST_DT
,NULL PROCESS_INCIDENT_END_DT
,NULL PROCESS_INCIDENT_FLAG
,NULL RETURN_INCIDENT_FLAG
,NULL COMPLETE_INCIDENT_ST_DT
,NULL COMPLETE_INCIDENT_END_DT
,NULL COMPLETE_INCIDENT_FLAG
,NULL RETURN_TO_MMS_DT
,(CASE WHEN i.responsible_staff_id IS NOT NULL then COALESCE((SELECT s.last_name||','||s.first_name||' '||s.middle_name FROM eb.staff s WHERE s.staff_id=i.responsible_staff_id),TO_CHAR(i.responsible_staff_id))
       when i.responsible_staff_id IS NULL then COALESCE((SELECT s.last_name||','||s.first_name||' '||s.middle_name FROM eb.staff s WHERE TO_CHAR(s.staff_id)=i.created_by),i.created_by) 
       ELSE null END) CREATED_BY_NAME
,i.generic_field1 GENERIC_FIELD_1
,i.generic_field2 GENERIC_FIELD_2
,i.generic_field3 GENERIC_FIELD_3
,i.generic_field4 GENERIC_FIELD_4
,i.generic_field5 GENERIC_FIELD_5
,(SELECT c.clnt_cin FROM eb.client c WHERE c.clnt_client_id = i.client_id) ENROLLEE_RIN
,i.reporter_first_name || ' ' ||i.reporter_last_name REPORTER_NAME
,'N' RESEARCH_INCIDENT_FLAG
,CASE WHEN status_cd IN('WITHDRAWN','APPEAL_WITHDRAWN') THEN COALESCE((SELECT s.last_name||','||s.first_name||' '||s.middle_name FROM eb.staff s WHERE TO_CHAR(s.staff_id)=i.updated_by),i.updated_by)
  ELSE NULL END CANCEL_BY
,CASE WHEN status_cd IN('WITHDRAWN','APPEAL_WITHDRAWN') THEN 'Incident Withdrawn' ELSE NULL END CANCEL_REASON
,CASE WHEN status_cd IN('WITHDRAWN','APPEAL_WITHDRAWN') THEN 'Normal' ELSE NULL END CANCEL_METHOD
,(SELECT a.addr_ctlk_id FROM address a WHERE a.addr_case_id = i.case_id AND UPPER(A.addr_type_cd) = 'RS' AND A.addr_END_date IS NULL) 
                                  as COUNTY_CODE
,(SELECT b.description FROM eb.address a JOIN eb.ENUM_COUNTY B ON A.addr_ctlk_id = B.VALUE WHERE a.addr_case_id = i.case_id AND UPPER(A.addr_type_cd) = 'RS' AND A.addr_END_date IS NULL) 
                                  as COUNTY_NAME
,replace(replace(substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,1),1,2000)||substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,2001),1,2000), '<action>', CHR(13)||CHR(10)), '</action>', '') ACTION_COMMENTS
,substrb(dbms_lob.substr(description,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(description,2000, 2001),1,2000) INCIDENT_DESCRIPTION
,substrb(dbms_lob.substr(i.resolution,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.resolution,2000, 2001),1,2000) RESOLUTION_DESCRIPTION
,i.client_id CLIENT_ID
FROM eb.incident_header i
WHERE  i.incident_header_type_cd = 'COMPLAINT'
and i.received_ts >=(ADD_MONTHS(TRUNC(sysdate,'mm'),-2))

