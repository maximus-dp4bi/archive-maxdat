insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE
where 
  BSL_ID = 1
  and EVENT_DATE < to_date('2013-01-23 07:04','YYYY-MM-DD HH24:MI')
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
    
delete 
from BPM_UPDATE_EVENT_QUEUE
where
  BSL_ID = 1
  and EVENT_DATE < to_date('2013-01-23 07:04','YYYY-MM-DD HH24:MI')
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;


insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE
where 
  BUEQ_ID = 21379613
  and BSL_ID = 5
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
    
delete 
from BPM_UPDATE_EVENT_QUEUE
where
  BUEQ_ID = 21379613
  and BSL_ID = 5
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;
