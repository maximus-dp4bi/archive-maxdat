update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID = 4
  and PROCESS_BUEQ_ID is not null;
  
commit;