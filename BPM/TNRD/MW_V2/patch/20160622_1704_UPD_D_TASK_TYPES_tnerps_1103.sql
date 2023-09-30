update D_TASK_TYPES set OPERATIONS_GROUP = 'Application Processing' where task_name = 'MAXIMUS-QC';
update D_TASK_TYPES set OPERATIONS_GROUP = 'Call Center' where task_name = 'Returned Mail'; 

commit;