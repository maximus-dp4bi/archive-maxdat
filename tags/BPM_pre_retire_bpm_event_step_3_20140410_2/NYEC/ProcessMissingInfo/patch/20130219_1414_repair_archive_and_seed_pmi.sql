-- Seed dimension model with nulls.
insert into D_NYEC_PMI_LETTER_STATUS (DNPMILS_ID,"MI Letter Status") values (SEQ_DNPMILS_ID.nextval,null);
insert into D_NYEC_PMI_INBOUND_MI_TYPE (DNPMIIMIT_ID,"Inbound MI Type") values (SEQ_DNPMIIMIT_ID.nextval,null);

commit;

-- Remove unneeded foreign keys.
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BSL_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BIL_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BUE_ID_FK;

-- Archive completed queue rows.
insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE
where 
  PROCESS_BUEQ_ID is not null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
    
delete 
from BPM_UPDATE_EVENT_QUEUE
where
  PROCESS_BUEQ_ID is not null
  and WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;

update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID is not null;

commit;
