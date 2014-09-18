truncate table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

delete 
from BPM_UPDATE_EVENT_QUEUE
where 
  BSL_ID = 2
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;