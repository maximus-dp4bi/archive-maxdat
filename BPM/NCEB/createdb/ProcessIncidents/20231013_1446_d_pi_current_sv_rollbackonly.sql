DROP VIEW MAXDAT_SUPPORT.D_PI_CURRENT_SV;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."D_PI_CURRENT_SV" ("PI_BI_ID", "INCIDENT_TRACKING_NUMBER", "RECEIPT_DATE", "CREATE_DATE", "CREATED_BY_GROUP", "ORIGIN_ID", "CHANNEL", "AGE_IN_BUSINESS_DAYS", "AGE_IN_CALENDAR_DAYS", "PROCESS_CLIENT_NOTIFICATION_ID", "CUR_INSTANCE_STATUS", "CANCEL_DATE", "INCIDENT_TYPE", "DPIIA_ID", "CUR_INCIDENT_ABOUT", "DPIIR_ID", "CUR_INCIDENT_REASON", "ABOUT_PROVIDER_ID", "ABOUT_PLAN_CODE", "CUR_INCIDENT_STATUS", "CUR_INCIDENT_STATUS_DATE", "STATUS_AGE_IN_BUSINESS_DAYS", "STATUS_AGE_IN_CALENDAR_DAYS", "CUR_JEOPARDY_STATUS", "JEOPARDY_STATUS_DATE", "COMPLETE_DATE", "REPORTED_BY", "REPORTER_RELATIONSHIP", "CASE_ID", "REPORTER_FIRST_NAME", "REPORTER_LAST_NAME", "REPORTER_FULL_NAME", "REPORTER_PHONE", "CUR_ENROLLMENT_STATUS", "PRIORITY", "PROGRAM", "SUB_PROGRAM", "CUR_LAST_UPDATE_DATE", "CUR_LAST_UPDATE_BY_NAME", "PLAN_ID", "PROVIDER_ID", "ACTION_TYPE", "RESOLUTION_TYPE", "NOTIFY_CLIENT_FLAG", "PROCESS_CLNT_NOTIFY_START_DT", "PROCESS_CLNT_NOTIFY_END_DT", "PROCESS_CLNT_NOTIFY_FLAG", "ESCALATE_INCIDENT_FLAG", "ESCALATE_TO_STATE_DT", "CUR_TASK_ID", "STATE_RECEIVED_APPEAL_DATE", "HEARING_DATE", "SELECTION_ID", "TIMELINESS_STATUS", "EB_FOLLOWUP_NEEDED_FLAG", "OTHER_PARTY_NAME", "RESEARCH_INCIDENT_ST_DT", "RESEARCH_INCIDENT_END_DT", "PROCESS_INCIDENT_ST_DT", "PROCESS_INCIDENT_END_DT", "PROCESS_INCIDENT_FLAG", "RETURN_INCIDENT_FLAG", "COMPLETE_INCIDENT_ST_DT", "COMPLETE_INCIDENT_END_DT", "COMPLETE_INCIDENT_FLAG", "RETURN_TO_MMS_DT", "CREATED_BY_NAME", "GENERIC_FIELD_1", "GENERIC_FIELD_2", "GENERIC_FIELD_3", "GENERIC_FIELD_4", "GENERIC_FIELD_5", "ENROLLEE_RIN", "RESEARCH_INCIDENT_FLAG", "CANCEL_BY", "CANCEL_REASON", "CANCEL_METHOD", "COUNTY_CODE", "COUNTY_NAME", "ACTION_COMMENTS", "INCIDENT_DESCRIPTION", "RESOLUTION_DESCRIPTION", "CLIENT_ID", "CREATED_BY_ID", "CREATED_BY_EMPID", "RECIPIENT_NAME", "RECIPIENT_ADDRESS", "RECIPIENT_PHONE",
"PROVIDER_NPI","PROVIDER_NAME","PROVIDER_ADDRESS_1","PROVIDER_ADDRESS_2","PROVIDER_ADDRESS_CITY","PROVIDER_ADDRESS_STATE","PROVIDER_ADDRESS_ZIP","PROVIDER_ADDRESS_COUNTY","PROVIDER_PHONE") AS 
SELECT i.incident_header_id PI_BI_ID ,
    i.tracking_number INCIDENT_TRACKING_NUMBER ,
    i.received_ts RECEIPT_DATE ,
    i.create_ts CREATE_DATE ,
    g.group_name CREATED_BY_GROUP ,
    i.origin_id ,
    o.report_label CHANNEL ,
    (CASE WHEN i.create_ts IS NOT NULL
      AND ( CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN i.status_ts ELSE sysdate END) IS NOT NULL THEN
        (SELECT
          CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
        FROM MAXDAT_SUPPORT.D_DATES
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN i.CREATE_TS AND (
          CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN i.status_ts ELSE sysdate END)
        )
      ELSE 0 END ) AGE_IN_BUSINESS_DAYS ,
    TRUNC(CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED')
      THEN i.status_ts
      ELSE sysdate
    END) - TRUNC(i.create_ts) AGE_IN_CALENDAR_DAYS ,
    0 PROCESS_CLIENT_NOTIFICATION_ID ,
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 'Complete' ELSE 'Active'  END CUR_INSTANCE_STATUS ,
    NULL CANCEL_DATE ,
    t.report_label INCIDENT_TYPE ,
    apt.value AS DPIIA_ID,
    apt.report_label CUR_INCIDENT_ABOUT ,
    aps.value AS DPIIR_ID,
    aps.report_label CUR_INCIDENT_REASON ,
    n.provider_id_ext ABOUT_PROVIDER_ID ,
    COALESCE(pl.plan_code, '0') ABOUT_PLAN_CODE ,
    s.report_label CUR_INCIDENT_STATUS ,
    i.status_ts CUR_INCIDENT_STATUS_DATE ,
    (
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 0
        ELSE (CASE WHEN i.create_ts IS NOT NULL AND i.status_ts IS NOT NULL
          THEN
            (SELECT
              CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
            FROM MAXDAT_SUPPORT.D_DATES
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN i.CREATE_TS AND i.status_ts )
          ELSE 0
        END )  END) STATUS_AGE_IN_BUSINESS_DAYS ,
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 0 ELSE TRUNC(sysdate) - TRUNC(i.status_ts) END STATUS_AGE_IN_CALENDAR_DAYS ,
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 'NA' ELSE
        CASE WHEN TRUNC(sysdate) - TRUNC(i.create_ts) >= 20 THEN 'Y' ELSE 'N' END  END CUR_JEOPARDY_STATUS ,
    sysdate JEOPARDY_STATUS_DATE ,
    CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN i.status_ts  ELSE NULL END COMPLETE_DATE ,
    r.report_label REPORTED_BY ,
    rr.report_label REPORTER_RELATIONSHIP ,
    COALESCE(i.case_id, 0) CASE_ID ,
    i.reporter_first_name,
    i.reporter_last_name,
    CASE WHEN LENGTH(reporter_last_name) > 1  THEN i.reporter_first_name||' '||i.reporter_last_name  ELSE NULL END AS reporter_full_name,
    CASE WHEN i.reporter_phone IS NOT NULL THEN '('||SUBSTR( i.reporter_phone,1,3)||')'||SUBSTR( i.reporter_phone,4,3)||'-'|| SUBSTR( i.reporter_phone,7) END reporter_phone,
    NULL CUR_ENROLLMENT_STATUS ,
    p.report_label PRIORITY ,
    'MEDICAID' PROGRAM ,
    COALESCE(i.GENERIC_FIELD1, '0') AS SUB_PROGRAM ,
    i.update_ts CUR_LAST_UPDATE_DATE ,
    COALESCE(us.last_name||','||us.first_name||' '||us.middle_name, i.updated_by) CUR_LAST_UPDATE_BY_NAME,
    slct.plan_id PLAN_ID ,
    slct.provider_id_ext PROVIDER_ID ,
    rl.report_label ACTION_TYPE ,
    rt.report_label RESOLUTION_TYPE ,
    'N' NOTIFY_CLIENT_FLAG ,
    NULL PROCESS_CLNT_NOTIFY_START_DT ,
    NULL PROCESS_CLNT_NOTIFY_END_DT ,
    NULL PROCESS_CLNT_NOTIFY_FLAG ,
    NULL ESCALATE_INCIDENT_FLAG ,
    NULL ESCALATE_TO_STATE_DT ,
    si.step_instance_id CUR_TASK_ID ,
    NULL STATE_RECEIVED_APPEAL_DATE ,
    NULL HEARING_DATE ,
    slct.selection_segment_id SELECTION_ID ,
    CASE
      WHEN i.status_cd IN('STATE_COMPLETED')
      THEN
        CASE
          WHEN TRUNC(i.status_ts) - TRUNC(i.create_ts) <= 30
          THEN 'Processed Timely'
          ELSE 'Processed Untimely'
        END
      WHEN i.status_cd NOT IN( 'CLOSED','STATE_COMPLETED')
      THEN 'Not Processed'
      ELSE NULL
    END TIMELINESS_STATUS ,
    (
    CASE
      WHEN (i.eb_follow_up_needed_ind IS NULL
      OR i.eb_follow_up_needed_ind=0 )
      THEN 'N'
      WHEN i.eb_follow_up_needed_ind=1
      THEN 'Y'
      ELSE NULL
    END) EB_FOLLOWUP_NEEDED_FLAG ,
    opt.report_label OTHER_PARTY_NAME ,
    NULL RESEARCH_INCIDENT_ST_DT ,
    NULL RESEARCH_INCIDENT_END_DT ,
    NULL PROCESS_INCIDENT_ST_DT ,
    NULL PROCESS_INCIDENT_END_DT ,
    NULL PROCESS_INCIDENT_FLAG ,
    NULL RETURN_INCIDENT_FLAG ,
    NULL COMPLETE_INCIDENT_ST_DT ,
    NULL COMPLETE_INCIDENT_END_DT ,
    NULL COMPLETE_INCIDENT_FLAG ,
    NULL RETURN_TO_MMS_DT ,
    (
    CASE
      WHEN i.responsible_staff_id IS NOT NULL
      THEN COALESCE( rs.last_name||','||rs.first_name||' '||rs.middle_name, TO_CHAR(i.responsible_staff_id))
      WHEN i.responsible_staff_id IS NULL
      THEN COALESCE(cs.last_name||','||cs.first_name||' '||cs.middle_name, i.created_by) ELSE NULL END) CREATED_BY_NAME ,
    i.generic_field1 GENERIC_FIELD_1 ,
    i.generic_field2 GENERIC_FIELD_2 ,
    i.generic_field3 GENERIC_FIELD_3 ,
    i.generic_field4 GENERIC_FIELD_4 ,
    i.generic_field5 GENERIC_FIELD_5 ,
    CASE WHEN i.client_id IS NULL THEN ccs.clnt_cin ELSE c.clnt_cin END ENROLLEE_RIN ,
    'N' RESEARCH_INCIDENT_FLAG ,
    NULL CANCEL_BY ,
    NULL CANCEL_REASON ,
    NULL CANCEL_METHOD ,
    a.addr_ctlk_id AS COUNTY_CODE ,
    b.description AS COUNTY_NAME ,
    REPLACE(REPLACE(substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,1),1,2000)||substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,2001),1,2000), '<action>', CHR(13)||CHR(10)), '</action>', '') ACTION_COMMENTS ,
    substrb(dbms_lob.substr(i.description,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.description,2000, 2001),1,2000) INCIDENT_DESCRIPTION ,
    CASE WHEN i.status_cd IN( 'CLOSED','STATE_COMPLETED') THEN substrb(dbms_lob.substr(i.resolution,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.resolution,2000, 2001),1,2000) ELSE NULL END RESOLUTION_DESCRIPTION ,
    i.client_id CLIENT_ID,
    COALESCE(TO_CHAR(i.responsible_staff_id),i.created_by) created_by_id,
    COALESCE(TO_CHAR(rs.ext_staff_number),cs.ext_staff_number) created_by_empid,
    CASE WHEN i.client_id IS NULL THEN ccs.clnt_fname||CASE WHEN ccs.clnt_mi IS NULL THEN ' ' ELSE ' '||ccs.clnt_mi||' ' END||ccs.clnt_lname
      ELSE c.clnt_fname||CASE WHEN c.clnt_mi IS NULL THEN ' ' ELSE ' '||c.clnt_mi||' ' END||c.clnt_lname END recipient_name,
    a.addr_street_1||' '||a.addr_street_2||' '||a.addr_city||' '||a.addr_state_cd||' '||a.addr_zip recipient_address,
    CASE WHEN p.phon_phone_number IS NOT NULL THEN '('||p.phon_area_code||')'||SUBSTR(p.phon_phone_number,1,3)||'-'||SUBSTR(p.phon_phone_number,4,4) ELSE NULL END recipient_phone,
    npr.npi_id_ext provider_npi,
    n.first_name||CASE WHEN n.first_name IS NULL THEN NULL ELSE ' ' END||n.last_name provider_name,
    n.office_addr_1 provider_address_1,
    n.office_addr_2 provider_address_2,
    n.office_city provider_address_city,
    n.office_state provider_address_state,
    n.office_zip provider_address_zip,
    n.office_county provider_address_county,
    n.office_phone provider_phone
  FROM eb.incident_header i
  LEFT JOIN eb.address a                       ON (a.addr_case_id = i.case_id AND UPPER(a.addr_type_cd) = 'RS' AND a.addr_end_date IS NULL AND a.clnt_client_id IS NULL)
  LEFT JOIN eb.phone_number p                  ON (p.phon_case_id = i.case_id AND UPPER(p.phon_type_cd) = 'HM' AND p.phon_end_date IS NULL AND p.clnt_client_id IS NULL)
  LEFT JOIN eb.ENUM_COUNTY b                   ON (a.addr_ctlk_id = b.VALUE)
  LEFT JOIN eb.client c                        ON (c.clnt_client_id = i.client_id)
  LEFT JOIN eb.cases cs                        ON (i.case_id = cs.case_id)
  LEFT JOIN eb.client ccs                      ON (cs.clnt_client_id = ccs.clnt_client_id) --get the client info from case if incident client id is null
  LEFT JOIN eb.enum_action_taken rl            ON (rl.value=i.action_taken_cd)
  LEFT JOIN eb.enum_incident_header_type t     ON (t.value=i.incident_header_type_cd)
  JOIN (SELECT * FROM eb.enum_affected_party_subtype
        WHERE effective_end_date IS NULL) aps ON (aps.value=i.affected_party_subtype_cd AND aps.scope = t.scope)
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL) apt    ON (apt.value=i.affected_party_type_cd AND apt.scope = t.scope)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=i.status_cd)  
  LEFT JOIN eb.enum_incident_origin o          ON (o.value=i.origin_cd)
  LEFT JOIN eb.enum_other_party_type opt       ON (opt.value=i.other_party_type_cd)
  LEFT JOIN eb.enum_priority p                 ON (p.value=i.priority_cd)
  LEFT JOIN eb.enum_relationship rr            ON (rr.value=i.reporter_relationship)
  LEFT JOIN eb.enum_reporter_type r            ON (r.value=i.reporter_type_cd)
  LEFT JOIN eb.enum_resolution_type rt         ON (rt.value=i.resolution_type_cd)
  LEFT JOIN eb.groups g                        ON (g.group_id=i.responsible_staff_group_id)
  LEFT JOIN eb.network n                       ON (n.network_id_ext=i.network_id_ext)
  LEFT JOIN eb.provider npr                    ON (n.provider_id = npr.provider_id)
  LEFT JOIN eb.plans pl                        ON (pl.plan_id_ext = i.plan_id_ext AND rownum=1)
  LEFT JOIN eb.staff rs                        ON (rs.staff_id = i.responsible_staff_id)
  LEFT JOIN eb.staff cs                        ON (TO_CHAR(cs.staff_id) = (i.created_by))
  LEFT JOIN eb.staff us                        ON (TO_CHAR(us.staff_id) = (i.updated_by))
  LEFT JOIN
    (SELECT si.ref_id, MAX(step_instance_id) step_instance_id FROM eb.step_instance si
    JOIN eb.step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
    WHERE si.ref_type='incident_header'
    AND si.completed_ts IS NULL
    GROUP BY si.ref_id
    ) si ON (si.ref_id=i.incident_header_id) 
   LEFT JOIN (SELECT *
              FROM (SELECT slct.selection_segment_id, slct.plan_id, pl.plan_name, slct.client_id,slct.provider_id_ext,cc.cscl_case_id case_id
                           ,ROW_NUMBER() OVER(PARTITION BY cc.cscl_case_id ORDER BY selection_segment_id) rn
                    FROM eb.selection_segment slct                      
                      JOIN eb.case_client cc ON slct.client_id = cc.cscl_clnt_client_id   
                      LEFT JOIN eb.plans pl ON pl.plan_id = slct.plan_id
                      LEFT JOIN eb.contract con ON con.PLAN_ID = slct.plan_id              
                    WHERE 1=1
                    AND cc.cscl_status_End_date IS NULL 
                    AND con.end_date IS NULL
                    AND slct.start_nd < slct.end_nd
                    AND slct.program_type_cd = 'MEDICAID'
                    AND slct.plan_type_cd = 'MEDICAL'
                    AND slct.status_cd = 'OPEN')
                WHERE rn = 1) slct ON slct.case_id = cs.case_id               
  WHERE 1=1
  --AND i.incident_header_type_cd = 'COMPLAINT'
    AND (i.received_ts >= ADD_MONTHS(TRUNC(SYSDATE), -13)) 
       OR i.status_cd not IN('CLOSED','STATE_COMPLETED' )
 UNION ALL
SELECT NULL	PI_BI_ID	,
NULL	INCIDENT_TRACKING_NUMBER	,
NULL	RECEIPT_DATE	,
dd.d_date	CREATE_DATE	,
NULL	CREATED_BY_GROUP	,
NULL	ORIGIN_ID	,
NULL	CHANNEL	,
NULL	AGE_IN_BUSINESS_DAYS	,
NULL	AGE_IN_CALENDAR_DAYS	,
NULL	PROCESS_CLIENT_NOTIFICATION_ID	,
'Active'	CUR_INSTANCE_STATUS	,
NULL	CANCEL_DATE	,
apt.INCIDENT_TYPE	,
apt.DPIIA_ID,
apt.CUR_INCIDENT_ABOUT ,
apt.DPIIR_ID,
apt.CUR_INCIDENT_REASON ,
NULL	ABOUT_PROVIDER_ID	,
NULL	ABOUT_PLAN_CODE	,
NULL	CUR_INCIDENT_STATUS	,
NULL	CUR_INCIDENT_STATUS_DATE	,
NULL	STATUS_AGE_IN_BUSINESS_DAYS	,
NULL	STATUS_AGE_IN_CALENDAR_DAYS	,
NULL	CUR_JEOPARDY_STATUS	,
NULL	JEOPARDY_STATUS_DATE	,
NULL	COMPLETE_DATE	,
NULL	REPORTED_BY	,
NULL	REPORTER_RELATIONSHIP	,
NULL	CASE_ID	,
NULL	REPORTER_FIRST_NAME	,
NULL	REPORTER_LAST_NAME	,
NULL	REPORTER_FULL_NAME	,
NULL	REPORTER_PHONE	,
NULL	CUR_ENROLLMENT_STATUS	,
NULL	PRIORITY	,
NULL	PROGRAM	,
NULL	SUB_PROGRAM	,
NULL	CUR_LAST_UPDATE_DATE	,
NULL	CUR_LAST_UPDATE_BY_NAME	,
NULL	PLAN_ID	,
NULL	PROVIDER_ID	,
NULL	ACTION_TYPE	,
NULL	RESOLUTION_TYPE	,
NULL	NOTIFY_CLIENT_FLAG	,
NULL	PROCESS_CLNT_NOTIFY_START_DT	,
NULL	PROCESS_CLNT_NOTIFY_END_DT	,
NULL	PROCESS_CLNT_NOTIFY_FLAG	,
NULL	ESCALATE_INCIDENT_FLAG	,
NULL	ESCALATE_TO_STATE_DT	,
NULL	CUR_TASK_ID	,
NULL	STATE_RECEIVED_APPEAL_DATE	,
NULL	HEARING_DATE	,
NULL	SELECTION_ID	,
NULL	TIMELINESS_STATUS	,
NULL	EB_FOLLOWUP_NEEDED_FLAG	,
NULL	OTHER_PARTY_NAME	,
NULL	RESEARCH_INCIDENT_ST_DT	,
NULL	RESEARCH_INCIDENT_END_DT	,
NULL	PROCESS_INCIDENT_ST_DT	,
NULL	PROCESS_INCIDENT_END_DT	,
NULL	PROCESS_INCIDENT_FLAG	,
NULL	RETURN_INCIDENT_FLAG	,
NULL	COMPLETE_INCIDENT_ST_DT	,
NULL	COMPLETE_INCIDENT_END_DT	,
NULL	COMPLETE_INCIDENT_FLAG	,
NULL	RETURN_TO_MMS_DT	,
NULL	CREATED_BY_NAME	,
NULL	GENERIC_FIELD_1	,
NULL	GENERIC_FIELD_2	,
NULL	GENERIC_FIELD_3	,
NULL	GENERIC_FIELD_4	,
NULL	GENERIC_FIELD_5	,
NULL	ENROLLEE_RIN	,
NULL	RESEARCH_INCIDENT_FLAG	,
NULL	CANCEL_BY	,
NULL	CANCEL_REASON	,
NULL	CANCEL_METHOD	,
NULL	COUNTY_CODE	,
NULL	COUNTY_NAME	,
NULL	ACTION_COMMENTS	,
NULL	INCIDENT_DESCRIPTION	,
NULL	RESOLUTION_DESCRIPTION	,
NULL	CLIENT_ID	,
NULL	CREATED_BY_ID	,
NULL	CREATED_BY_EMPID	,
NULL	RECIPIENT_NAME	,
NULL	RECIPIENT_ADDRESS	,
NULL	RECIPIENT_PHONE	,
NULL	PROVIDER_NPI,
NULL	PROVIDER_NAME,
NULL	PROVIDER_ADDRESS_1,
NULL	PROVIDER_ADDRESS_2,
NULL	PROVIDER_ADDRESS_CITY,
NULL	PROVIDER_ADDRESS_STATE,
NULL	PROVIDER_ADDRESS_ZIP,
NULL	PROVIDER_ADDRESS_COUNTY,
NULL	PROVIDER_PHONE
FROM d_dates dd
  CROSS JOIN (SELECT ht.report_label incident_type, apt.value DPIIA_ID, apt.report_label CUR_INCIDENT_ABOUT, aps.value DPIIR_ID, aps.report_label CUR_INCIDENT_REASON
              FROM eb.enum_incident_header_type ht
                JOIN eb.enum_affected_party_type apt ON ht.scope = apt.scope
                JOIN  eb.enum_affected_party_subtype aps ON apt.value = aps.affected_party_type_cd AND ht.scope = aps.scope 
               WHERE apt.effective_end_date is null
               and aps.effective_end_date is null
               AND apt.scope = 'INCIDENT'
               AND aps.scope = 'INCIDENT') apt 
WHERE dd.d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13);

GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_SV TO MAXDAT_REPORTS;
commit;
