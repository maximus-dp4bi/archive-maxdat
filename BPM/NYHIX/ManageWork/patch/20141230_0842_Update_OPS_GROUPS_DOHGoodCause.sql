update d_task_types
   set operations_group = 'DOH'
where task_type_id = 20137013;

insert into BPM_D_OPS_GROUP_TASK  values ('DOH','DOH Good Cause Review'); 

commit;