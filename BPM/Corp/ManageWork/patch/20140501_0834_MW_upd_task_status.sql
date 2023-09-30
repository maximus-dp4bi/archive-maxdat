-- NYEC-6318 (Corp) need to discontinue use of STATUS_ORDER. Update in-process tasks' MW_PROCESSED for ETL re-processing.
-- Must set all MW_PROCESSED=Y 

DECLARE
  v_min_task_id corp_etl_manage_work.task_id%TYPE;
begin
  -- Min date on PROD is 5/2. Use Apr to ensure all is fetched.
  SELECT MIN(step_instance_id) INTO v_min_task_id
    FROM step_instance_stg
   WHERE hist_create_ts > '1-apr-2014';
  
  UPDATE step_instance_stg SET mw_processed = 'Y'
   WHERE mw_processed = 'N'
     AND step_instance_id >= v_min_task_id;

end;
/
--update staging table
DECLARE  
CURSOR stage_cur IS
SELECT s.step_instance_id, step_instance_history_id, hist_status, hist_create_ts, stage_create_ts
  FROM step_instance_stg s, corp_etl_manage_work m
      , (SELECT step_instance_id, MAX(hist_create_ts) max_hist_status_date
           FROM step_instance_stg
         GROUP BY step_instance_id) lst
 WHERE s.step_instance_id = task_id
   AND task_status != hist_status
   AND cancel_work_flag = 'N'
   AND stage_done_date IS NULL
   AND task_status != 'COMPLETED'
   AND s.step_instance_id = lst.step_instance_id
   AND s.hist_create_ts = max_hist_status_date
   AND NOT EXISTS
       (SELECT 1 FROM d_mw_current c
         WHERE "Task ID" = task_id
           AND "Current Task Status" = 'COMPLETED');
   
   TYPE t_stage_tab IS TABLE OF stage_cur%ROWTYPE INDEX BY PLS_INTEGER;
    stage_tab t_stage_tab;
    v_bulk_limit NUMBER := 500;
   
BEGIN  
   OPEN stage_cur;
   LOOP
     FETCH stage_cur BULK COLLECT INTO stage_tab LIMIT v_bulk_limit;
     EXIT WHEN stage_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..stage_tab.COUNT
         UPDATE step_instance_stg
         SET mw_processed = 'N'
         WHERE step_instance_history_id = stage_tab(indx).step_instance_history_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE stage_cur;
END;
/

