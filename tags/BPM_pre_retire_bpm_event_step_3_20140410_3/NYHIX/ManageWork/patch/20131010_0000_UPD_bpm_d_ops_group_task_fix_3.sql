--select * from BPM_D_OPS_GROUP_TASK
--where task_type = 'Supervisor Complaint Task';
--OPS_GROUP	Eligibility C
--TASK_TYPE	Supervisor Complaint Task

UPDATE  BPM_D_OPS_GROUP_TASK
set OPS_GROUP =  'Call Center'
where task_type = 'Supervisor Complaint Task';

commit;




