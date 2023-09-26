CREATE OR REPLACE VIEW D_PI_CURRENT_SV
AS
  SELECT i.incident_header_id PI_BI_ID ,
    i.tracking_number INCIDENT_TRACKING_NUMBER ,
    i.received_ts RECEIPT_DATE ,
    i.create_ts CREATE_DATE ,
    g.group_name CREATED_BY_GROUP ,
    i.origin_id ,
    o.report_label CHANNEL ,
    (
    CASE
      WHEN i.create_ts IS NOT NULL
      AND (
        CASE
          WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
          THEN i.status_ts
          ELSE sysdate
        END) IS NOT NULL
      THEN
        (SELECT
          CASE
            WHEN (COUNT(*)-1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM MAXDAT_SUPPORT.D_DATES
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN i.CREATE_TS AND (
          CASE
            WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
            THEN i.status_ts
            ELSE sysdate
          END)
        )
      ELSE 0
    END ) AGE_IN_BUSINESS_DAYS ,
    TRUNC(
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN i.status_ts
      ELSE sysdate
    END) - TRUNC(i.create_ts) AGE_IN_CALENDAR_DAYS ,
    0 PROCESS_CLIENT_NOTIFICATION_ID ,
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN 'Complete'
      ELSE 'Active'
    END CUR_INSTANCE_STATUS ,
    CASE
      WHEN i.status_cd IN('WITHDRAWN' )
      THEN i.status_ts
      ELSE NULL
    END CANCEL_DATE ,
    t.report_label INCIDENT_TYPE ,
    apt.report_label CUR_INCIDENT_ABOUT ,
    aps.report_label CUR_INCIDENT_REASON ,
--    n.provider_id ABOUT_PROVIDER_ID ,
    pl.plan_code ABOUT_PLAN_CODE ,
    COALESCE(pl.plan_id, 0) ABOUT_PLAN_ID ,
    s.report_label CUR_INCIDENT_STATUS ,
    i.status_ts CUR_INCIDENT_STATUS_DATE ,
    (
    CASE
      WHEN i.status_cd IN('CLOSED','WITHDRAWN' )
      THEN 0
      ELSE (
        CASE
          WHEN i.create_ts IS NOT NULL
          AND i.status_ts IS NOT NULL
          THEN
            (SELECT
              CASE
                WHEN (COUNT(*)-1) < 0
                THEN 0
                ELSE COUNT(*)-1
              END
            FROM MAXDAT_SUPPORT.D_DATES
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN i.CREATE_TS AND i.status_ts
            )
          ELSE 0
        END )
    END) STATUS_AGE_IN_BUSINESS_DAYS ,
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN 0
      ELSE TRUNC(sysdate) - TRUNC(i.status_ts)
    END STATUS_AGE_IN_CALENDAR_DAYS ,
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN 'NA'
      ELSE
        CASE
          WHEN TRUNC(sysdate) - TRUNC(i.create_ts) >= 20
          THEN 'Y'
          ELSE 'N'
        END
    END CUR_JEOPARDY_STATUS ,
    sysdate JEOPARDY_STATUS_DATE ,
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN i.status_ts
      ELSE NULL
    END COMPLETE_DATE ,
    r.report_label REPORTED_BY ,
    rr.report_label REPORTER_RELATIONSHIP ,
    i.case_id CASE_ID ,
    NULL CUR_ENROLLMENT_STATUS ,
    p.report_label PRIORITY ,
    'MEDICAID' PROGRAM ,
    NULL SUB_PROGRAM ,
    i.update_ts CUR_LAST_UPDATE_DATE ,
    COALESCE(
    (SELECT s.last_name||','||s.first_name||' '||s.middle_name
    FROM staff s
    WHERE TO_CHAR(s.staff_id)=i.updated_by
    ),i.updated_by) CUR_LAST_UPDATE_BY_NAME ,
    NULL PLAN_CODE ,
    NULL PROVIDER_ID ,
    rl.report_label ACTION_TYPE ,
    rt.report_label RESOLUTION_TYPE ,
    'N' NOTIFY_CLIENT_FLAG ,
    NULL PROCESS_CLNT_NOTIFY_START_DT ,
    NULL PROCESS_CLNT_NOTIFY_END_DT ,
    NULL PROCESS_CLNT_NOTIFY_FLAG ,
    NULL ESCALATE_INCIDENT_FLAG
    ----,(SELECT MIN(h.create_ts) FROM incident_header_stat_hist h WHERE h.incident_header_id=i.incident_header_id AND h.status_cd in ('REFERRED_TO_STATE'))
    ,
    NULL ESCALATE_TO_STATE_DT ,
    si.step_instance_id CUR_TASK_ID ,
    NULL STATE_RECEIVED_APPEAL_DATE ,
    NULL HEARING_DATE ,
    NULL SELECTION_ID ,
    CASE
      WHEN i.status_cd IN('CLOSED')
      THEN
        CASE
          WHEN TRUNC(i.status_ts) - TRUNC(i.create_ts) <= 30
          THEN 'Processed Timely'
          ELSE 'Processed Untimely'
        END
      WHEN i.status_cd <> 'CLOSED'
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
      THEN COALESCE(
        (SELECT s.last_name||','||s.first_name||' '||s.middle_name
        FROM eb.staff s
        WHERE s.staff_id=i.responsible_staff_id
        ),TO_CHAR(i.responsible_staff_id))
      WHEN i.responsible_staff_id IS NULL
      THEN COALESCE(
        (SELECT s.last_name||','||s.first_name||' '||s.middle_name
        FROM eb.staff s
        WHERE TO_CHAR(s.staff_id)=i.created_by
        ),i.created_by)
      ELSE NULL
    END) CREATED_BY_NAME ,
    i.generic_field1 GENERIC_FIELD_1 ,
    i.generic_field2 GENERIC_FIELD_2 ,
    i.generic_field3 GENERIC_FIELD_3 ,
    i.generic_field4 GENERIC_FIELD_4 ,
    i.generic_field5 GENERIC_FIELD_5 ,
    c.clnt_cin ENROLLEE_RIN ,
    i.reporter_first_name || ' ' ||i.reporter_last_name REPORTER_NAME ,
    'N' RESEARCH_INCIDENT_FLAG ,
    CASE
      WHEN i.status_cd IN('WITHDRAWN' )
      THEN COALESCE(
        (SELECT s.last_name||','||s.first_name||' '||s.middle_name
        FROM eb.staff s
        WHERE TO_CHAR(s.staff_id)=i.updated_by
        ),i.updated_by)
      ELSE NULL
    END CANCEL_BY ,
    CASE
      WHEN i.status_cd IN('WITHDRAWN' )
      THEN 'Incident Withdrawn'
      ELSE NULL
    END CANCEL_REASON ,
    CASE
      WHEN i.status_cd IN('WITHDRAWN' )
      THEN 'Normal'
      ELSE NULL
    END CANCEL_METHOD ,
    a.addr_ctlk_id AS COUNTY_CODE ,
    b.description AS COUNTY_NAME ,
    REPLACE(REPLACE(substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,1),1,2000)||substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,2001),1,2000), '<action>', CHR(13)||CHR(10)), '</action>', '') ACTION_COMMENTS ,
    substrb(dbms_lob.substr(i.description,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.description,2000, 2001),1,2000) INCIDENT_DESCRIPTION ,
    substrb(dbms_lob.substr(i.resolution,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.resolution,2000, 2001),1,2000) RESOLUTION_DESCRIPTION ,
    NVL(i.client_id, 0) AS  CLIENT_ID
  FROM eb.incident_header i
  LEFT JOIN eb.address a                       ON (a.addr_case_id = i.case_id AND UPPER(a.addr_type_cd) = 'RS' AND a.addr_end_date IS NULL)
  LEFT JOIN eb.ENUM_COUNTY b                   ON (a.addr_ctlk_id = b.VALUE)
  LEFT JOIN eb.client c                        ON (c.clnt_client_id = i.client_id)
  LEFT JOIN eb.enum_action_taken rl            ON (rl.value=i.action_taken_cd)
  LEFT JOIN eb.enum_affected_party_subtype aps ON (aps.value=i.affected_party_subtype_cd)
  LEFT JOIN eb.enum_affected_party_type apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=i.status_cd)
  LEFT JOIN eb.enum_incident_header_type t     ON (t.value=i.incident_header_type_cd)
  LEFT JOIN eb.enum_incident_origin o          ON (o.value=i.origin_cd)
  LEFT JOIN eb.enum_other_party_type opt       ON (opt.value=i.other_party_type_cd)
  LEFT JOIN eb.enum_priority p                 ON (p.value=i.priority_cd)
  LEFT JOIN eb.enum_relationship rr            ON (rr.value=i.reporter_relationship)
  LEFT JOIN eb.enum_reporter_type r            ON (r.value=i.reporter_type_cd)
  LEFT JOIN eb.enum_resolution_type rt         ON (rt.value=i.resolution_type_cd)
  LEFT JOIN eb.groups g                        ON (g.group_id=i.responsible_staff_group_id)
--  LEFT JOIN eb.network n                       ON (n.network_id_ext=i.network_id_ext)
  LEFT JOIN eb.plans pl                        ON (pl.plan_id_ext = i.plan_id_ext AND rownum=1)
  LEFT JOIN
    (SELECT si.ref_id, MAX(step_instance_id) step_instance_id FROM eb.step_instance si
    JOIN eb.step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
    WHERE si.ref_type='incident_header'
    AND si.completed_ts IS NULL
    GROUP BY si.ref_id
    ) si ON (si.ref_id=i.incident_header_id)
  WHERE i.incident_header_type_cd = 'COMPLAINT'
       and (i.received_ts >=(ADD_MONTHS(TRUNC(sysdate,'mm'),-3))
          or i.status_cd not IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN' ))
    ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_SV TO EB_MAXDAT_REPORTS ;