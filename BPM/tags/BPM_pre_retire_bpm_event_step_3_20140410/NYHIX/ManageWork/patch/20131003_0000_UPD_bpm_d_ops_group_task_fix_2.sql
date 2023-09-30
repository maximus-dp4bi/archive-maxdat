delete from BPM_D_OPS_GROUP_TASK
where TASK_TYPE in ('NYHBE Complaints');
--
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Call Center','NYHBE Complaints');
--
commit;
