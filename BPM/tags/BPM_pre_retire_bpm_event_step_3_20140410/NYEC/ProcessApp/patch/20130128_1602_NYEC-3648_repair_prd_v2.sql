update BPM_UPDATE_EVENT_QUEUE
set WROTE_BPM_EVENT_DATE = QUEUE_DATE
where 
  IDENTIFIER between 349874 and 349901
  and BSL_ID = 2
  and OLD_DATA is null;
  
commit;