CREATE OR REPLACE VIEW D_PA_APPEALS_SV
AS
  SELECT i.incident_header_id APL_BI_ID ,
    ai.application_id AS app_id,
    ai.app_individual_id,
    i.tracking_number INCIDENT_TRACKING_NUMBER ,
    i.received_ts RECEIPT_DATE ,
    i.create_ts CREATE_DATE ,  
    o.report_label CHANNEL ,
    (
    CASE
      WHEN i.create_ts IS NOT NULL
      AND (
        CASE
          WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
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
            WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
            THEN i.status_ts
            ELSE sysdate
          END)
        )
      ELSE 0
    END ) AGE_IN_BUSINESS_DAYS ,
    TRUNC(
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
      THEN i.status_ts
      ELSE sysdate
    END) - TRUNC(i.create_ts) AGE_IN_CALENDAR_DAYS ,    
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
      THEN 'Complete'
      ELSE 'Active'
    END CUR_INSTANCE_STATUS ,
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN' )
      THEN i.status_ts
      ELSE NULL
    END CANCEL_DATE ,
    t.report_label INCIDENT_TYPE ,
    apt.value AS DAPLIA_ID,
    apt.report_label CUR_INCIDENT_ABOUT ,
    aps.value AS DAPLIR_ID,
    aps.report_label CUR_INCIDENT_REASON ,
    s.report_label CUR_INCIDENT_STATUS ,
    i.status_ts CUR_INCIDENT_STATUS_DATE ,
    (
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
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
      WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
      THEN 0
      ELSE TRUNC(sysdate) - TRUNC(i.status_ts)
    END STATUS_AGE_IN_CALENDAR_DAYS ,
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
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
      WHEN i.status_cd IN('APPEAL_WITHDRAWN','APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
      THEN i.status_ts
      ELSE NULL
    END COMPLETE_DATE ,
    r.report_label REPORTED_BY ,
    rr.report_label REPORTER_RELATIONSHIP ,
    i.case_id CASE_ID ,  
    p.report_label PRIORITY ,    
    i.update_ts CUR_LAST_UPDATE_DATE ,
    COALESCE(
    (SELECT s.last_name||','||s.first_name||' '||s.middle_name
    FROM staff s
    WHERE TO_CHAR(s.staff_id)=i.updated_by
    ),i.updated_by) CUR_LAST_UPDATE_BY_NAME ,  
    rl.report_label ACTION_TYPE ,    
    si.step_instance_id CUR_TASK_ID ,    
    CASE
      WHEN i.status_cd IN('APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
      THEN
        CASE
          WHEN TRUNC(i.status_ts) - TRUNC(i.create_ts) <= 30
          THEN 'Processed Timely'
          ELSE 'Processed Untimely'
        END
      WHEN i.status_cd NOT IN('APPEAL_APPROVED','APPEAL_DISMISSED','APPEAL_SETTLED','APPEAL_CLOSED')
      THEN 'Not Processed'
      ELSE NULL
    END TIMELINESS_STATUS ,    
    (
    CASE
      WHEN i.responsible_staff_id IS NOT NULL
      THEN COALESCE( rs.last_name||','||rs.first_name||' '||rs.middle_name, TO_CHAR(i.responsible_staff_id))
      WHEN i.responsible_staff_id IS NULL
      THEN COALESCE(cs.last_name||','||cs.first_name||' '||cs.middle_name, i.created_by) ELSE NULL END) CREATED_BY_NAME ,        
    i.reporter_first_name || ' ' ||i.reporter_last_name REPORTER_NAME ,    
    CASE
      WHEN i.status_cd IN('WITHDRAWN' )
      THEN COALESCE(
        (SELECT s.last_name||','||s.first_name||' '||s.middle_name
        FROM staff s
        WHERE TO_CHAR(s.staff_id)=i.updated_by
        ),i.updated_by)
      ELSE NULL
    END CANCEL_BY ,
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN' )
      THEN 'Incident Withdrawn'
      ELSE NULL
    END CANCEL_REASON ,
    CASE
      WHEN i.status_cd IN('APPEAL_WITHDRAWN' )
      THEN 'Normal'
      ELSE NULL
    END CANCEL_METHOD ,
    i.client_id CLIENT_ID,
    i.application_id x_app_id,
    COALESCE(TO_CHAR(i.responsible_staff_id),i.created_by) created_by_id, 
    COALESCE(TO_CHAR(rs.ext_staff_number),cs.ext_staff_number) created_by_empid,
    i.hearing_date appeal_hearing_date,
    hist.hist_create_ts court_decision_date,
    hist.hist_status court_decision
  FROM incident_header i
  LEFT JOIN app_individual ai 
     JOIN app_case_link ac ON (ai.application_id = ac.application_id) 
      ON (i.client_id = ai.client_id 
          AND ac.case_id = i.case_id and i.create_ts >= ai.create_ts 
          AND i.incident_header_type_cd = 'APPEAL')
  LEFT JOIN enum_action_taken rl            ON (rl.value=i.action_taken_cd)
  LEFT JOIN enum_affected_party_subtype aps ON (aps.value=i.affected_party_subtype_cd)
  LEFT JOIN enum_affected_party_type apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN enum_incident_header_status s   ON (s.value=i.status_cd)
  LEFT JOIN enum_incident_header_type t     ON (t.value=i.incident_header_type_cd)
  LEFT JOIN enum_incident_origin o          ON (o.value=i.origin_cd)
  LEFT JOIN enum_priority p                 ON (p.value=i.priority_cd)
  LEFT JOIN enum_relationship rr            ON (rr.value=i.reporter_relationship)
  LEFT JOIN enum_reporter_type r            ON (r.value=i.reporter_type_cd)    
  LEFT JOIN staff rs                        ON (rs.staff_id = i.responsible_staff_id)
  LEFT JOIN staff cs                        ON (TO_CHAR(cs.staff_id) = i.created_by)
  LEFT JOIN
    (SELECT si.ref_id, MAX(step_instance_id) step_instance_id FROM step_instance si
    JOIN step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
    WHERE si.ref_type='incident_header'
    AND si.completed_ts IS NULL
    GROUP BY si.ref_id
    ) si ON (si.ref_id=i.incident_header_id)
  LEFT JOIN (SELECT *
             FROM(SELECT incident_header_id, report_label hist_status,hi.create_ts hist_create_ts,ROW_NUMBER() OVER (PARTITION BY incident_header_id ORDER BY hi.create_ts DESC,incident_header_stat_hist_id DESC) rn
                  FROM incident_header_stat_hist hi
                    JOIN enum_incident_header_status s ON hi.status_cd = s.value
                  WHERE hi.status_cd IN('APPEAL_APPROVED', 'APPEAL_DENIED','APPEAL_RESOLVED_PREHEARING','APPEAL_NOT_RESOLVED_PREHEARING','APPEAL_DISMISSED',
                                        'APPEAL_STIPULATED_SETTLEMENT','APPEAL_SETTLEMENT_DENIED','APPEAL_SETTLED','APPEAL_REMANDED','REMANDED_NEW_APPEAL_OPENED') )
             WHERE rn = 1) hist
    ON i.incident_header_id = hist.incident_header_id
  WHERE i.incident_header_type_cd = 'APPEAL'
    ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PA_APPEALS_SV TO MAXDAT_REPORTS;