update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1,
  BATCH_SIZE = 100
where 
  BSL_ID is null
  and BDM_ID is null;

commit;
