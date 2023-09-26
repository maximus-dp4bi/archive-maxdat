update d_task_types
set operations_group = 'DOH'
where task_name in('SHOP Desk Review','Hearing Set - Disposition Review Needed');

update BPM_D_OPS_GROUP_TASK
set ops_group = 'DOH'
where task_type in ('SHOP Desk Review','Hearing Set - Disposition Review Needed');

update d_task_types
set operations_group = 'Research'
where task_name in('Large Font Notice Request','Data Entry Research Task');

update BPM_D_OPS_GROUP_TASK
set ops_group = 'Research'
where task_type in ('Large Font Notice Request','NYHBE Verification Doc Research Task');

commit;