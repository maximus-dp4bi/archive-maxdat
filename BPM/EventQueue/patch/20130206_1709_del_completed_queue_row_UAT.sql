delete 
from BPM_UPDATE_EVENT_QUEUE
where
  BUEQ_ID = 13108609
  and BSL_ID = 7
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;