alter session set current_schema = MAXDAT;

BEGIN

FOR x IN(
  SELECT COMPLETED_TS , STEP_INSTANCE_ID,task_id ,complete_date
  FROM MAXDAT.corp_etl_mw_v2 A, maxdat.STEP_INSTANCE_STG b 
  WHERE a.task_id=b.STEP_INSTANCE_ID
  and a.TASK_STATUS='COMPLETED'
  and b.STATUS='COMPLETED'
  and A.complete_date is null
  AND B.COMPLETED_TS IS NOT NULL) LOOP
    UPDATE corp_etl_mw_v2
    SET complete_date = x.completed_ts
    WHERE task_id = x.task_id;
END LOOP;
END;
/

COMMIT;