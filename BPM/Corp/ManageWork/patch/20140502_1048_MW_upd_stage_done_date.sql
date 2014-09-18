-- NYEC-6318 (Corp) update Completed tasks without Stage Done Date.

--update staging table
DECLARE  
CURSOR stage_cur IS
SELECT s.step_instance_id, step_instance_history_id, hist_status, hist_create_ts, stage_create_ts
  FROM step_instance_stg s, corp_etl_manage_work m, d_mw_current c
      , (SELECT step_instance_id, MAX(hist_create_ts) max_hist_status_date
           FROM step_instance_stg
         GROUP BY step_instance_id) lst
 WHERE s.step_instance_id = task_id
   AND task_status != hist_status
   and task_status = 'COMPLETED'
   AND cancel_work_flag = 'N'
   AND stage_done_date IS NULL
   AND s.step_instance_id = lst.step_instance_id
   AND s.hist_create_ts = max_hist_status_date
   AND "Task ID" = task_id
   AND "Current Task Status" = 'COMPLETED';
   
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
         UPDATE corp_etl_manage_work
         SET stage_done_date = COALESCE(complete_date, cancel_work_date)
         WHERE task_id = stage_tab(indx).step_instance_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE stage_cur;
END;
/

