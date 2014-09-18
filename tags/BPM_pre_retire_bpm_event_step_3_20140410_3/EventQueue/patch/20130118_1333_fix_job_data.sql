update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 7,
  BDM_ID = 1,
  BATCH_SIZE = 100
where 
  BSL_ID is null
  and BDM_ID is null;

update PROCESS_BPM_QUEUE_JOB
set 
  STATUS = 'STOPPED',
  END_DATE = sysdate,
  STATUS_DATE = sysdate,
  STOP_REASON_ID = 203
where PBQJ_ID = 1724;

commit;
