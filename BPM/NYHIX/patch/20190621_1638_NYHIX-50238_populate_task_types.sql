Alter session set current_schema=MAXDAT;

delete from D_TASK_TYPES where task_type_id=2019011;

insert into D_TASK_TYPES
values (2019011,'Application Assessment', 'Application Assessment', 'Research',null,null,null,null,null);




commit;
