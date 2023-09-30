CREATE OR REPLACE VIEW F_MW_DAILY_SUMMARY_SV
AS
  SELECT SI.STEP_INSTANCE_ID MW_BI_ID ,
    SI.STEP_DEFINITION_ID AS TASK_TYPE_ID ,
    D.D_DATE ,
    CASE WHEN SI.ESCALATED_IND = 1 
          THEN 'Y'
          ELSE 'N' END AS ESCALATED_FLAG ,
    CASE
      WHEN SI.STATUS = 'COMPLETED'
      THEN SI.COMPLETED_TS
      ELSE NULL
    END COMPLETE_DATE ,
    CASE
      WHEN SI.STATUS = 'TERMINATED'
      THEN SI.COMPLETED_TS
      ELSE NULL
    END CANCEL_WORK_DATE ,
    SI.CREATE_TS CREATE_DATE ,
    SI.CREATE_TS INSTANCE_START_DATE ,
    SI.COMPLETED_TS INSTANCE_END_DATE ,
    SI.STATUS AS CURR_TASK_STATUS ,
    COALESCE(SI.OWNER, '0') AS CURR_OWNER_STAFF_ID,
    COALESCE(g.supervisor_staff_id,0) AS TEAM_SUPERVISOR_STAFF_ID,
    CASE
      WHEN si.completed_ts IS NULL
      THEN 'Not Complete'
      WHEN COALESCE(dt.sla_days_type, to_char(dt.sla_days)) IS NULL
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
      AND 24 * (COALESCE(si.completed_ts, D.D_DATE) - si.create_ts) > COALESCE(dt.sla_days,0)
      THEN 'Untimely'
      ELSE 'Timely'
    END TIMELINESS_STATUS,
    CASE
      WHEN D.D_DATE = TRUNC(SI.CREATE_TS)
      THEN 1
      ELSE 0
    END AS CREATION_COUNT ,
    CASE
      WHEN D.D_DATE = TRUNC(SI.COMPLETED_TS)
      THEN 0
      ELSE 1
    END AS INVENTORY_COUNT ,
    CASE
      WHEN SI.STATUS IN ('TERMINATED', 'COMPLETED')
      AND D.D_DATE = TRUNC(SI.COMPLETED_TS)
      THEN 1
      ELSE 0
    END AS COMPLETION_COUNT
  FROM maxdat_SUPPORT.D_DATES D
  JOIN STEP_INSTANCE SI ON (D_DATE BETWEEN TRUNC(SI.CREATE_TS) AND COALESCE(TRUNC(SI.COMPLETED_TS),TRUNC(sysdate)))
  JOIN step_definition sd  ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
  LEFT JOIN MAXDAT_SUPPORT.d_task_types dt ON (dt.task_type_id = si.step_definition_id) 
  LEFT JOIN GROUPS g ON (g.type_cd = 'TEAM' AND SI.TEAM_ID = g.group_id) 
  WHERE (si.completed_ts>=add_months(trunc(sysdate,'mm'),-6)
   OR si.status not in('TERMINATED','COMPLETED') ); 
  
  GRANT SELECT ON MAXDAT_SUPPORT.F_MW_DAILY_SUMMARY_SV TO MAXDAT_REPORTS ;