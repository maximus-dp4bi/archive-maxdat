-- TNERPS-4183 update 6 task_types
 
UPDATE d_task_types
SET operations_group = 'Mail Room'
     ,sla_days = 3
     ,sla_days_type = 'B'
     ,sla_target_days =2
     ,sla_jeopardy_days = 2
WHERE TASK_NAME = 'MAM Review Task';   


UPDATE d_task_types
SET operations_group = 'Mail Room'
     ,sla_days = 3
     ,sla_days_type = 'B'
     ,sla_target_days =2
     ,sla_jeopardy_days = 2
WHERE TASK_NAME = 'MAM Linking Task';


UPDATE d_task_types
SET operations_group = 'Research'
     ,sla_days = 3
     ,sla_days_type = 'B'
     ,sla_target_days =2
     ,sla_jeopardy_days = 2
WHERE TASK_NAME = 'Reactivation Status Review';

UPDATE d_task_types
SET operations_group = 'Data Entry Unit'
     ,sla_days = 5
     ,sla_days_type = 'B'
     ,sla_target_days =4
     ,sla_jeopardy_days =4
WHERE TASK_NAME = 'CK Data Evaluation';

 
UPDATE d_task_types
SET operations_group = 'State Eligibility'
     ,sla_days = 3
     ,sla_days_type = 'B'
     ,sla_target_days =2
     ,sla_jeopardy_days = 2
WHERE TASK_NAME = 'DOD';   


UPDATE d_task_types
SET operations_group = 'Data Entry Unit'
     ,sla_days = 3
     ,sla_days_type = 'B'
     ,sla_target_days =2
     ,sla_jeopardy_days = 2
WHERE TASK_NAME = 'MI Data Evaluation';


COMMIT;
 