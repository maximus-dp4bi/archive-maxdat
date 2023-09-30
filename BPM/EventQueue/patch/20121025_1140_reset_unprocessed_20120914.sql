update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  EVENT_DATE >= to_date('2012-09-14','YYYY-MM-DD')
  and EVENT_DATE < to_date('2012-09-15','YYYY-MM-DD')
  and PROCESS_BUEQ_ID is not null
  and WROTE_BPM_SEMANTIC_DATE is null;

commit;