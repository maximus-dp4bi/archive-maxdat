update BPM_UPDATE_EVENT_QUEUE
set 
  PROCESS_BUEQ_ID = null
where 
    BSL_ID = 11
and IDENTIFIER = 31456;
commit;