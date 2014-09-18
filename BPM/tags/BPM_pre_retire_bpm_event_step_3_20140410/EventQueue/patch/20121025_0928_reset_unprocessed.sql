update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  PROCESS_BUEQ_ID is not null
  and WROTE_BPM_SEMANTIC_DATE is null;

commit;