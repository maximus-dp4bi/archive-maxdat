update BPM_UPDATE_EVENT_QUEUE
set 
  PROCESS_BUEQ_ID = null
where 
    BSL_ID = 11
and IDENTIFIER IN (31456,33806,33905,34063);
commit;