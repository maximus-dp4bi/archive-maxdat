CREATE OR REPLACE VIEW D_MW_V2_CURRENT_SV
AS
  SELECT SI.STEP_INSTANCE_ID AS MW_BI_ID
    --D_MW_V2_CURRENT_SV
    ,
    CASE
      WHEN COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate)) IS NOT NULL
      AND TRUNC(si.create_ts) IS NOT NULL
      THEN
        (SELECT
          CASE
            WHEN (COUNT(*) -1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM maxdat_support.d_dates
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN TRUNC(si.create_ts) AND COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate))
        )
      ELSE 0
    END AGE_IN_BUSINESS_DAYS ,
    COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate)) - TRUNC(si.create_ts) age_in_calendar_days ,
    CASE
      WHEN SI.STATUS = 'TERMINATED'
      THEN siht.owner
      ELSE '0'
    END CANCELLED_BY_STAFF_ID ,
    CASE
      WHEN SI.STATUS = 'TERMINATED'
      THEN 'Normal'
      ELSE NULL
    END CANCEL_METHOD ,
    CASE
      WHEN SI.STATUS = 'TERMINATED'
      THEN 'Task was Terminated'
      ELSE NULL
    END CANCEL_REASON ,
    CASE
      WHEN SI.STATUS = 'TERMINATED'
      THEN si.completed_ts
      ELSE NULL
    END CANCEL_WORK_DATE ,
    si.case_id AS case_id ,
    COALESCE(si.client_id, 0) AS client_id ,
    CASE
      WHEN SI.STATUS = 'COMPLETED'
      THEN si.completed_ts
      ELSE NULL
    END COMPLETE_DATE ,
    SI.CREATE_TS AS CREATE_DATE ,
    COALESCE(SI.CREATED_BY, '0') AS curr_created_by_staff_id,
    CASE WHEN SI.ESCALATED_IND = 1
          THEN 'Y'
          ELSE 'N' END AS ESCALATED_FLAG ,
    COALESCE(SI.ESCALATE_TO, '0') AS curr_escalated_to_staff_id ,
    COALESCE(SI.FORWARDED_BY, '0') AS curr_forwarded_by_staff_id ,
    CASE WHEN SI.FORWARDED_IND = 1
          THEN 'Y'
          ELSE 'N' END AS FORWARDED_FLAG ,
    CASE
      WHEN SI.STATUS = 'TERMINATED'
      THEN 'Y'
      ELSE 'N'
    END AS cancel_flag,
    CASE
      WHEN SI.STATUS = 'COMPLETED'
      THEN 'Y'
      ELSE 'N'
    END AS complete_flag,
    SI.GROUP_ID AS CURR_BUSINESS_UNIT_ID ,
    SI.CREATE_TS AS INSTANCE_START_DATE ,
    SI.COMPLETED_TS instance_end_date ,
    CASE
      WHEN dt.sla_days_type IS NULL
      THEN 'N'
      WHEN dt.sla_days_type = 'B'
        --      AND DECODE(dt.sla_days_type, NULL, NULL,dt.sla_jeopardy_days) IS NOT NULL
      AND (SELECT
          CASE
            WHEN (COUNT(*) -1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM maxdat_support.d_dates
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN TRUNC(si.create_ts) AND COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate))) >= dt.sla_jeopardy_days
      THEN 'Y'
      WHEN dt.sla_days_type = 'C'
        --      AND DECODE(dt.sla_days_type, NULL, NULL,dt.sla_jeopardy_days) IS NOT NULL
      AND COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate)) - TRUNC(si.create_ts) >= dt.sla_jeopardy_days
      THEN 'Y'
      WHEN dt.sla_days_type = 'H'
      AND 24 * (COALESCE(si.completed_ts, sysdate) - si.create_ts) >= dt.sla_jeopardy_days
      THEN 'Y'
      ELSE 'N'
    END jeopardy_flag ,
    COALESCE(sih.owner,'0') AS curr_last_upd_by_staff_id ,
    COALESCE(TRUNC(sih.create_ts), to_date('01/01/1985', 'dd/mm/yyyy')) AS curr_last_update_date ,
    to_date('01/01/1985', 'dd/mm/yyyy') AS last_event_date ,
    COALESCE(SI.OWNER, '0') AS CURR_OWNER_STAFF_ID,
    NULL parent_task_id ,
    si.REF_ID,
    CASE
      WHEN upper(SI.REF_TYPE) IN ('APP_HEADER', 'APPLICATION_ID', 'MANUAL_TASK_APP_HEADER')
      THEN si.REF_ID
      ELSE NULL
    END AS SOURCE_REFERENCE_ID,
    CASE
      WHEN upper(SI.REF_TYPE) = 'DOCUMENT_SET_ID'
      THEN si.REF_ID
      ELSE NULL
    END AS DOCUMENT_SET_ID,
    DECODE(upper(SI.REF_TYPE) , 'APP_HEADER' ,'Application ID' , 'APPLICATION_ID' ,'Application ID' , 'DOCUMENT_ID' ,'Document ID' , 'DOCUMENT' ,'Document ID' , 'DOCUMENT_SET_ID' ,'Document Set ID' , 'DOCUMENT_SET' ,'Document Set ID' , 'IMAGING' ,'Image ID' , 'CASES' ,'Case ID' , 'CASE_ID' ,'Case ID' , 'CLIENT' ,'Client ID' , 'CLNT_CLIENT_ID' ,'Client ID' , 'CALL_RECORD' ,'Call ID' , 'CALL_RECORD_ID' ,'Call ID' , 'INCIDENT_HEADER' ,'Incident ID' , 'INCIDENT_HEADER_ID' ,'Incident ID' , 'APP_DOC_TRACKER_ID' ,'App Doc Tracker ID' , SI.REF_TYPE) AS SOURCE_REFERENCE_TYPE ,
    CASE
      WHEN COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate)) IS NOT NULL
      AND TRUNC(si.create_ts) IS NOT NULL
      THEN
        (SELECT
          CASE
            WHEN (COUNT(*) -1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM maxdat_support.d_dates
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN TRUNC(si.create_ts) AND COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate))
        )
      ELSE 0
    END status_age_in_bus_days ,
    ROUND(COALESCE(si.completed_ts,sysdate) - SI.CREATE_TS,0) status_age_in_cal_days ,
    to_date('01/01/1985', 'dd/mm/yyyy') AS stg_extract_date ,
    to_date('01/01/1985', 'dd/mm/yyyy') AS stg_last_update_date ,
    to_date('01/01/1985', 'dd/mm/yyyy') AS stg_done_date ,
    SI.STEP_INSTANCE_ID AS TASK_ID ,
    si.priority_cd AS task_priority ,
    SI.STATUS AS CURR_TASK_STATUS ,
    SD.STEP_DEFINITION_ID AS TASK_TYPE_ID ,
    dt.TASK_NAME ,
    dt.TASK_DESCRIPTION ,
    dt.OPERATIONS_GROUP ,
    dt.SLA_DAYS ,
    dt.SLA_DAYS_TYPE ,
    dt.SLA_TARGET_DAYS ,
    dt.SLA_JEOPARDY_DAYS ,
    SI.TEAM_ID AS curr_team_id ,
    COALESCE(g.supervisor_staff_id,0) AS TEAM_SUPERVISOR_STAFF_ID,
    CASE
      WHEN si.completed_ts IS NULL
      THEN 'Not Complete'
      WHEN COALESCE(dt.sla_days_type, TO_CHAR(dt.sla_days)) IS NULL
      THEN 'Not Required'
      WHEN dt.sla_days_type = 'B'
      AND si.completed_ts IS NOT NULL
      AND si.create_ts IS NOT NULL
      AND (SELECT
          CASE
            WHEN (COUNT(*)-1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM maxdat_support.d_dates
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN TRUNC(si.create_ts) AND TRUNC(si.completed_Ts)) > COALESCE(dt.sla_days,0)
      THEN 'Untimely'
      WHEN dt.sla_days_type = 'C'
      AND (TRUNC(si.completed_ts) - TRUNC(si.create_ts)) > COALESCE(dt.sla_days,0)
      THEN 'Untimely'
      WHEN dt.sla_days_type = 'H'
      AND 24 * (COALESCE(si.completed_ts, sysdate) - si.create_ts) > COALESCE(dt.sla_days,0)
      THEN 'Untimely'
      ELSE 'Timely'
    END timeliness_status ,
    dt.unit_of_work AS UNIT_OF_WORK,
    TRUNC(si.create_ts) AS curr_work_receipt_date ,
    si.PROCESS_ID AS SOURCE_PROCESS_ID ,
    si.PROCESS_INSTANCE_ID AS SOURCE_PROCESS_INSTANCE_ID,
    sihc.create_ts AS TASK_CLAIMED_DATE
  FROM STEP_INSTANCE SI
  JOIN step_definition sd                  ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
  LEFT JOIN MAXDAT_SUPPORT.d_task_types dt ON (dt.task_type_id = si.step_definition_id)
  LEFT JOIN GROUPS g                       ON (g.type_cd = 'TEAM' AND SI.TEAM_ID = g.group_id)
  LEFT JOIN
    (SELECT a.owner, a.step_instance_id, a.status, a.create_ts ,a.rnk FROM
      (SELECT h.owner, h.step_instance_id, h.status, h.create_ts, RANK() OVER(PARTITION BY step_instance_id ORDER BY step_instance_history_id DESC) AS rnk FROM step_instance_history h
      ) a
    ) sih ON (sih.rnk = 1 AND sih.step_instance_id = SI.STEP_INSTANCE_ID)
  LEFT JOIN
    (SELECT a.owner, a.step_instance_id, a.status, a.create_ts ,a.rnk FROM
      (SELECT h.owner, h.step_instance_id, h.status, h.create_ts, RANK() OVER(PARTITION BY step_instance_id ORDER BY create_ts) AS rnk FROM step_instance_history h WHERE h.STATUS = 'TERMINATED'
      ) a
    ) siht ON (siht.rnk = 1 AND siht.step_instance_id = SI.STEP_INSTANCE_ID AND siht.status = SI.STATUS)
  LEFT JOIN
    (SELECT a.owner, a.step_instance_id, a.status, a.create_ts ,a.rnk FROM
      (SELECT h.owner, h.step_instance_id, h.status, h.create_ts, RANK() OVER(PARTITION BY step_instance_id ORDER BY create_ts DESC) AS rnk FROM step_instance_history h WHERE h.STATUS = 'CLAIMED'
      ) a
    ) sihc ON (sihc.rnk = 1 AND sihc.step_instance_id = SI.STEP_INSTANCE_ID)
    --D_MW_V2_CURRENT_SV
  WHERE si.completed_ts >= add_months(TRUNC(sysdate,'mm'),-6)
  OR si.status NOT IN('TERMINATED','COMPLETED') ;
  