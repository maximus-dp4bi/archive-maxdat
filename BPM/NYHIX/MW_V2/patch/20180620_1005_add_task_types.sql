
SET DEFINE OFF;

update maxdat.D_TASK_TYPES set OPERATIONS_GROUP ='Account Review'
where task_type_id in (20180001, 20180002);

update maxdat.D_TASK_TYPES set OPERATIONS_GROUP ='DOH'
where task_type_id in (20180003, 20180004);

commit;