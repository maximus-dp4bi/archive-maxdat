--- TNERPS-4336 version 4


update d_task_types
set operations_group = 'Data Entry Unit'
    ,sla_days = 10
    ,sla_days_type = 'B'
    ,sla_target_days = 10
    ,sla_jeopardy_days = 8
where task_name = 'MI Review';
commit;

update d_task_types
set operations_group = 'Mail Room'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 3
    ,sla_jeopardy_days = 2
where task_name = 'Link Document Set';
commit;


update d_task_types
set operations_group = 'Research'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 3
    ,sla_jeopardy_days = 2
where task_name ='Reactivation Status Review';
commit;

