update BPM_UPDATE_EVENT_QUEUE 
set PROCESS_BUEQ_ID = null
where 
  BUEQ_ID = 48633173
  and BSL_ID = 1
  and IDENTIFIER = '6948617'
  and PROCESS_BUEQ_ID is not null;
  
commit;