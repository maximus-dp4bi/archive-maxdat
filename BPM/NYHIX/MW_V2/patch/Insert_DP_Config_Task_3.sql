alter session set current_schema = MAXDAT;
update MAXDAT.D_TASK_TYPES set operations_group = 'Call Center' where TASK_TYPE_ID  = 20211001 ;
commit;