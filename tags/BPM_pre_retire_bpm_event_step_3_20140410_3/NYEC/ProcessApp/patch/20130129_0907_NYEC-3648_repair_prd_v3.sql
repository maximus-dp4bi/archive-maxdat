-- Fix incorrect meta-data.
update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1,
  BATCH_SIZE = 1
where
  BSL_ID  is null
  and BDM_ID is null;
  
commit;

-- Stop job with previously incorrect meta-data.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(9801);

-- Archive unneeded stuck queue rows.
update BPM_UPDATE_EVENT_QUEUE
set 
  PROCESS_BUEQ_ID = null,
  WROTE_BPM_SEMANTIC_DATE = sysdate
where 
  BUEQ_ID in (22583345,22602216,22584421,22602480,22602578)
  and BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;
  
insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE
where 
  BUEQ_ID in (22583345,22602216,22584421,22602480,22602578)
  and BSL_ID = 2
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
    
delete 
from BPM_UPDATE_EVENT_QUEUE
where
  BUEQ_ID in (22583345,22602216,22584421,22602480,22602578)
  and BSL_ID = 2
  and PROCESS_BUEQ_ID is null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;


