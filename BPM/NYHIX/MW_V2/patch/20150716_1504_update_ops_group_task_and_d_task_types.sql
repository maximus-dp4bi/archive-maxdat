update d_task_types
set operations_group = 'DOH'
where task_name in('Appeal Validity Check','Remand','Request to Vacate Dismissal','Decision Overturned');

update BPM_D_OPS_GROUP_TASK
set ops_group = 'DOH'
where task_type in ('Appeal Validity Check','Remand','Request to Vacate Dismissal','Decision Overturned');

