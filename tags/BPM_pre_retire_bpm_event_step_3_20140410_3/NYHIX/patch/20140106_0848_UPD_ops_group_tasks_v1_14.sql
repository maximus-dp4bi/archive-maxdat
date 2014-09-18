--select * from BPM_D_OPS_GROUP_TASK
--where task_type in ('Manual Task - General','DPR - Doc/Form Type Mismatch Task ','CSC Payload Review')

delete from BPM_D_OPS_GROUP_TASK
where task_type ='DPR - Doc/Form Type Mismatch Task ';

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility A','DPR - Doc/Form Type Mismatch Task ');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Exception','Manual Task - General');

commit;
