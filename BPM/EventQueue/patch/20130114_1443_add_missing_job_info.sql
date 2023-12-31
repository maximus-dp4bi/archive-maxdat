select * from ALL_SCHEDULER_JOBS where OWNER = 'MAXDAT' and JOB_NAME = 'PROCESS_ALL_ROWS_BY_BSL_1325';
select * from ALL_SCHEDULER_JOB_LOG where OWNER = 'MAXDAT' and JOB_NAME = 'PROCESS_ALL_ROWS_BY_BSL_1325';
select * from ALL_SCHEDULER_JOB_RUN_DETAILS where OWNER = 'MAXDAT' and JOB_NAME = 'PROCESS_ALL_ROWS_BY_BSL_1325';

update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1
where 
  PBQJ_ID = 1325
  and BSL_ID is null
  and BDM_ID is null;

commit;
