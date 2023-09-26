CREATE OR REPLACE VIEW F_MW_V2_INSTANCE_SV
AS
  SELECT SI.STEP_INSTANCE_ID MW_BI_ID ,
    SD.STEP_DEFINITION_ID AS TASK_TYPE_ID ,
    DECODE(SI.ESCALATED_IND, 1, 'Y', 'N') AS ESCALATED_FLAG ,
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
        FROM MAXDAT_SUPPORT.d_dates
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN TRUNC(si.create_ts) AND COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate))
        )
      ELSE 0
    END AGE_IN_BUSINESS_DAYS ,
    COALESCE(TRUNC(si.completed_ts),TRUNC(sysdate)) - TRUNC(si.create_ts) AGE_IN_CALENDAR_DAYS
  FROM EB.STEP_INSTANCE SI
  JOIN EB.step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
  WHERE si.completed_ts>=add_months(trunc(sysdate,'mm'),-2)
   or si.status not in('TERMINATED','COMPLETED');
   
  GRANT SELECT ON MAXDAT_SUPPORT.F_MW_V2_INSTANCE_SV TO MAXDAT_REPORTS ;