 UPDATE d_task_types
 SET operations_group = 'Data Entry Unit'
     ,sla_days = 35
     ,sla_days_type = 'C'
     ,sla_target_days = 30
     ,sla_jeopardy_days = 30
WHERE task_name = 'MI Returned';     

COMMIT;
 