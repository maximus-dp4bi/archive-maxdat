insert into BPM_D_OPS_GROUP_TASK  values ('Research','Data Entry Research-Account Correction'); 

update d_task_types
   set operations_group = 'Research'
where task_type_id = 2013050;

update corp_etl_manage_work
set task_type = 'Data Entry Research-Account Correction'
where task_id = '6641023';

update d_mw_current
set "Current Task Type" = 'Data Entry Research-Account Correction'
where "Task ID" = '6641023';

commit;