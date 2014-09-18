update PROCESS_BPM_QUEUE_JOB
set
  status = 'STOPPED',
  END_DATE = sysdate,
  STATUS_DATE = sysdate
where PBQJ_ID in (7308,8043);

commit;

insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE
where 
  BUEQ_ID = 13108609
  and BSL_ID = 7
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
    
delete 
from BPM_UPDATE_EVENT_QUEUE
where
  BUEQ_ID = 13108609
  and BSL_ID = 7
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;