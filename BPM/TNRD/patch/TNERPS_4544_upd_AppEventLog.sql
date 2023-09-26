alter session set current_schema = "MAXDAT";

UPDATE MAXDAT.STEP_INSTANCE_STG
SET PRIORITY = 
(
SELECT NewTaskPriority FROM
(
SELECT DISTINCT 
    n.application_id
    , u.STEP_INSTANCE_ID
    , u.priority CurrentTaskPrioirty
    --, n.TaskPriority,
   , n.TaskPriority NewTaskPriority
FROM MAXDAT.STEP_INSTANCE_STG u INNER
    JOIN (SELECT step_instance_id
              --, ah.priority AppPriority
              , si.priority TaskPriority
              , ah.application_id
          --FROM MAXDAT.APP_HEADER_STG ah INNER
          FROM MAXDAT.APP_EVENT_LOG_STG ah INNER
              JOIN MAXDAT.STEP_INSTANCE_STG si ON (ah.application_id = si.ref_id AND si.ref_type = 'APP_HEADER')
          --WHERE ah.updated_by IN ('TNERPS4544', 'TNERPS4545','TNERPS4685')
          WHERE ah.created_by IN ('TNERPS4544', 'TNERPS4545','TNERPS4685')
              AND (si.process_id = 22 OR (si.process_id = 20 AND si.STEP_DEFINITION_ID = 3009))
              AND si.status IN ('CLAIMED', 'UNCLAIMED') AND ah.app_event_context = 'Task Priority Changed') n ON u.step_instance_id = n.step_instance_id
WHERE u.priority <> n.TaskPriority
   -- AND N.STEP_INSTANCE_ID = 7451332
) x where x.STEP_INSTANCE_ID = STEP_INSTANCE_ID 
    ) ;
    
    
COMMIT;
    
-------------------------------------------------------------------------------------------------------------------------------------------------


