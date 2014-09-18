update BPM_UPDATE_EVENT_QUEUE 
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 1
  and PROCESS_BUEQ_ID in (4763403,4769445);
  
commit;