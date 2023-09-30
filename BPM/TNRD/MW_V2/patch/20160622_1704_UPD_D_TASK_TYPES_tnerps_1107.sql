update d_task_types
set operations_group = 'Data Entry Unit'
where operations_group = 'Application Processing';

commit;