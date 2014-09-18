update BPM_D_OPS_GROUP_TASK 
set OPS_GROUP = 'Call Center'
where 
  OPS_GROUP = 'DOH Research Staff' 
  and TASK_TYPE = 'Refer to State-Research';

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility C','Awaiting Written Withdrawal');

commit;