update d_task_types
set operations_group = 'Data Entry Unit'
    ,task_name='MAXIMUS-QC With Coverage'
    ,sla_days = 5
    ,sla_days_type = 'B'
    ,sla_target_days =5
    ,sla_jeopardy_days =4
where task_name = 'CK Data Evaluation';
commit;