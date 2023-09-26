UPDATE corp_etl_mw_v2
SET cancel_reason = 'Task was Terminated'
   ,cancel_work_date = TO_DATE('11/27/2018 17:00:21','mm/dd/yyyy hh24:mi:ss')
   ,cancel_method = 'Normal'
   ,complete_date = null
   ,status_date = TO_DATE('11/27/2018 17:00:21','mm/dd/yyyy hh24:mi:ss')
   ,stage_done_date = sysdate
   ,task_status = 'TERMINATED'
WHERE task_id IN (17837690, 18240847);   

COMMIT;