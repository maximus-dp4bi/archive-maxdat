update PROCESS_BPM_QUEUE_JOB
set 
  BATCH_SIZE = 100
where 
  PBQJ_ID = 1325
  and BSL_ID = 1 
  and BDM_ID = 1;

update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1,
  BATCH_SIZE = 100
where 
  PBQJ_ID = 1446
  and BSL_ID is null
  and BDM_ID is null;

commit;
