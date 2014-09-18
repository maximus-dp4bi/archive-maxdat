-- NYEC-6360 (Corp) update Claimed tasks which were set Stage Done Date.

--update staging table
DECLARE  
CURSOR stage_cur IS
SELECT s.step_instance_id, step_instance_history_id, task_status, hist_status, hist_create_ts
     , stage_done_date, stage_create_ts, cancel_work_flag
     , max_stat_order
  FROM step_instance_stg s, corp_etl_manage_work m
      , (SELECT step_instance_id, MAX(status_order) max_stat_order
           FROM step_instance_stg
         GROUP BY step_instance_id) lst
 WHERE s.step_instance_id = task_id
--AND task_id IN (8911032, 2482639, 12515461, 12601859, 12514463, 12256896)
   AND cancel_work_flag = 'N'
   AND stage_done_date IS NOT NULL
   AND task_status != 'COMPLETED'
   AND s.step_instance_id = lst.step_instance_id
   AND s.status_order = max_stat_order
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
     -- Remove done date for Db procedure to pick up.
     BEGIN
       FORALL indx IN 1..stage_tab.COUNT
         UPDATE corp_etl_manage_work
         SET stage_done_date = NULL
         WHERE task_id = stage_tab(indx).step_instance_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE stage_cur;
END;
/

