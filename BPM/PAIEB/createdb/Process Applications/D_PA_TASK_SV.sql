CREATE OR REPLACE VIEW D_PA_TASK_SV
AS
 SELECT app_id
        ,MAX(current_task_id) current_task_id
        ,SUM(mi_received_task) mi_received_task
        ,MAX(de_task_id) de_task_id
FROM(        
 SELECT ref_id app_id
        ,operations_group
        ,MAX(step_instance_id) OVER (PARTITION BY ref_id) current_task_id
        --if any MI task types is in a diff operations group, then this needs to be on a separate join        
        ,CASE WHEN d.task_name = 'Verify Missing Information' THEN 1 ELSE 0 END mi_received_task
        ,CASE WHEN d.operations_group = 'Data Entry Unit' THEN step_instance_id ELSE NULL END de_task_id
  FROM step_instance i 
   INNER JOIN d_task_types d ON i.step_definition_id = d.task_type_id
  WHERE ref_type = 'APP_HEADER' 
)
GROUP BY app_id;

GRANT SELECT ON D_PA_TASK_SV TO MAXDAT_REPORTS;

                