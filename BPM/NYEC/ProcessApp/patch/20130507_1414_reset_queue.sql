update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BUEQ_ID in (17067193,17075558)
  and BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;