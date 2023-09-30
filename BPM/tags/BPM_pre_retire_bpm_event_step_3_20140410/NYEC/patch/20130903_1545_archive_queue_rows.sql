-- OK if this drop table fails because table does not exist.
drop table BUEQ_ARCHIVE_TEMP;

create table BUEQ_ARCHIVE_TEMP
  (BUEQ_ID number not null,
   BSL_ID number not null,
   BIL_ID number not null,
   IDENTIFIER varchar2(35) not null,
   EVENT_DATE date not null,
   QUEUE_DATE date not null,
   PROCESS_BUEQ_ID number,
   BUE_ID number,
   WROTE_BPM_EVENT_DATE date,
   WROTE_BPM_SEMANTIC_DATE date, 
   DATA_VERSION number not null,
   OLD_DATA xmltype,
   NEW_DATA xmltype not null)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (BSL_ID)
interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
parallel;

insert into BUEQ_ARCHIVE_TEMP
select * from BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
where EVENT_DATE >= trunc(sysdate - 7);

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE; 

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID);
alter index BUEQA_PK rebuild tablespace MAXDAT_INDX parallel;

insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
  (BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  PROCESS_BUEQ_ID,
  BUE_ID,
  WROTE_BPM_EVENT_DATE,
  WROTE_BPM_SEMANTIC_DATE,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA)
select 
  BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  null,
  BUE_ID,
  WROTE_BPM_EVENT_DATE,
  WROTE_BPM_EVENT_DATE,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
from BPM_UPDATE_EVENT_QUEUE
where 
  WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;

commit;

delete from BPM_UPDATE_EVENT_QUEUE
where 
  WROTE_BPM_EVENT_DATE is not null
  and WROTE_BPM_SEMANTIC_DATE is not null;
  
commit;