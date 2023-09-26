update d_task_types
set operations_group = 'Research'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 3
    ,sla_jeopardy_days = 2
where task_name = 'Multiple Applying Members';

commit;