alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE modify (IDENTIFIER varchar2(35));

insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE
where 
  BSL_ID = 2
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
    
delete 
from BPM_UPDATE_EVENT_QUEUE
where 
  BSL_ID = 2
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;

update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;

commit;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;