update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID = 4
  and PROCESS_BUEQ_ID is not null;
  
commit;

update PROCESS_BPM_QUEUE_JOB_CONFIG
set ENABLED = 'Y'
where BSL_ID = 4;
  
commit;