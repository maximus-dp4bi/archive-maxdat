update BPM_D_OPS_GROUP_TASK 
set TASK_TYPE = 'Enrollment Correction Task for EE'
where
  OPS_GROUP = 'Research'
  and TASK_TYPE = 'Enrollment Correction Task for EEU';
  
update BPM_D_OPS_GROUP_TASK 
set TASK_TYPE = 'SSA Portal Complaint Task'
where
  OPS_GROUP = 'Data Entry Unit'
  and TASK_TYPE = 'SSA Portal Complaint Tasks';
  
update BPM_D_OPS_GROUP_TASK 
set TASK_TYPE = 'General Correspondence Letter Data Entry Task'
where
  OPS_GROUP = 'Data Entry Unit'
  and TASK_TYPE = 'General Correspondence Letter Data Entry';
  
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Data Entry Unit','General Correspondence Data Entry Task');
  
commit;

