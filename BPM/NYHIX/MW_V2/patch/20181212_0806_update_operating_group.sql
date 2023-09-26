
SET DEFINE OFF;


update maxdat.D_TASK_TYPES 
set operations_group = 'Research' 
where task_type_id = 20181001;
commit; 