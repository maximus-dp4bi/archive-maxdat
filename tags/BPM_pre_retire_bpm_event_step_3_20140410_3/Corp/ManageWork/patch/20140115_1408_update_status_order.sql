-- NYHIX-4273 MAXDAT Step Instance Stage Order by issue
UPDATE step_instance_stg sis
   SET status_order = corp_etl_manage_work_pkg.get_task_status_order(hist_status)
 WHERE EXISTS
       (SELECT 1 FROM corp_etl_manage_work emw
         WHERE complete_date IS NULL
           AND emw.task_id = sis.step_instance_id);

COMMIT;
