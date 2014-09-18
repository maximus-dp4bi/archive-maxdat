update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  QUEUE_DATE < sysdate - (30/1440)
  and PROCESS_BUEQ_ID is not null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is null;
  
commit;
