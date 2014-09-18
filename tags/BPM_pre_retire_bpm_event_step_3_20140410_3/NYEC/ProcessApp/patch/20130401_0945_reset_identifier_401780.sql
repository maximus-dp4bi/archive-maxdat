update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 2
  and IDENTIFIER = 401780
  and PROCESS_BUEQ_ID = 2752006
  and PROCESS_BUEQ_ID is not null;
  
commit;