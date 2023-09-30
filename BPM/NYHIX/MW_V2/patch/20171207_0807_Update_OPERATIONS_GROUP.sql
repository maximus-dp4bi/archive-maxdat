/*
NYHIX-36660
*/

update maxdat.D_TASK_TYPES 
set operations_group = 'DOH' 
where task_type_id = 2015026;
commit;