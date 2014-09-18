delete from BPM_D_OPS_GROUP_TASK
where TASK_TYPE in ('Document Problem Resolution','Complaints Follow Up','Supervisor Complaints VHT','Supervisor Referral Task');
--
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility A','Document Problem Resolution');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Call Center','Complaints Follow Up');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Call Center','Supervisor Complaints VHT');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Call Center','Supervisor Referral Task');
--
commit;
