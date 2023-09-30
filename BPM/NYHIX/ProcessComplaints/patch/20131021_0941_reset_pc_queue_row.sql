update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BUEQ_ID = 2601
  and BSL_ID = 22
  and IDENTIFIER = '26034952';
  
commit;