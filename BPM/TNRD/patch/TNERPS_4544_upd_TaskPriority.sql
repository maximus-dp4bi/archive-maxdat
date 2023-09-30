alter session set current_schema = "MAXDAT";

BEGIN
FOR x IN (
select  u.TASK_ID
    , u.task_priority CurrentTaskPrioirty
    ,n.TaskPriority NewTaskPriority
from MAXDAT.corp_etl_mw_v2 u 
 JOIN (SELECT DISTINCT step_instance_id
            --  , ah.priority AppPriority
              , si.priority TaskPriority
           --   , ah.application_id
          FROM MAXDAT.STEP_INSTANCE_STG si         
          WHERE si.ref_type = 'APP_HEADER' 
          AND EXISTS(SELECT 1 FROM app_event_log_stg ah WHERE ah.application_id = si.ref_id AND app_event_cd = 'APP_PRIORITY_UPDATED' AND created_by IN ('TNERPS4544', 'TNERPS4545','TNERPS4685') )          
          AND (si.process_id = 22 OR (si.process_id = 20 AND si.STEP_DEFINITION_ID = 3009))
          --AND si.status IN ('CLAIMED', 'UNCLAIMED') 
           AND step_instance_history_id = (SELECT MAX(step_instance_history_id)
                                           FROM step_instance_stg s1
                                           WHERE s1.step_instance_id = si.step_instance_id)   
              ) n ON u.TASK_ID = n.step_instance_id 
WHERE u.task_priority <> n.TaskPriority  
) LOOP
UPDATE MAXDAT.corp_etl_mw_v2
SET TASK_PRIORITY = x.NewTaskPriority
WHERE task_id = x.task_id;

UPDATE MAXDAT.STEP_INSTANCE_STG
SET PRIORITY = x.NewTaskPriority
WHERE step_instance_id = x.task_id;

END LOOP;
END;
/