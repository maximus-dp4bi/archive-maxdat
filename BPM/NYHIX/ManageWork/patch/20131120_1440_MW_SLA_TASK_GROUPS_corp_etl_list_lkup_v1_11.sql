delete from BPM_D_OPS_GROUP_TASK
where TASK_TYPE in ('Awaiting Documentation','DPR - Financial Management','Manual Human Task');

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility C','Awaiting Documentation');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility A','DPR - Financial Management');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Exception','Manual Human Task');

commit;