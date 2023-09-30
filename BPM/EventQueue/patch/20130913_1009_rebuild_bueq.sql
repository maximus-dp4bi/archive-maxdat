-- Remove from queue archive.  Also remove any event, for all processes, over 7 days old.

-- OK if this drop table fails because table does not exist.
--drop table BUEQ_TEMP;

create table BUEQ_TEMP
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

insert into BUEQ_TEMP
select 
   BUEQ_ID,
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
   NEW_DATA
from BPM_UPDATE_EVENT_QUEUE;

commit;

drop table BPM_UPDATE_EVENT_QUEUE;
alter table BUEQ_TEMP rename to BPM_UPDATE_EVENT_QUEUE; 

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

create index BUEQ_IX1 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,EVENT_DATE) tablespace MAXDAT_INDX parallel compute statistics;

create index BUEQ_LX1 on BPM_UPDATE_EVENT_QUEUE (EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX2 on BPM_UPDATE_EVENT_QUEUE (PROCESS_BUEQ_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX4 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX5 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX6 on BPM_UPDATE_EVENT_QUEUE (BUE_ID) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BSL_ID_FK foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BIL_ID_FK foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

create or replace public synonym BPM_UPDATE_EVENT_QUEUE for BPM_UPDATE_EVENT_QUEUE;
grant select on  BPM_UPDATE_EVENT_QUEUE to MAXDAT_READ_ONLY;


-- For MicroStrategy MASH reporting.
create or replace view D_BPM_UPDATE_EVENT_QUEUE_SV as 
select 
  BUEQ_ID,
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
  NEW_DATA 
from BPM_UPDATE_EVENT_QUEUE
with read only;

create or replace public synonym BPM_UPDATE_EVENT_QUEUE for BPM_UPDATE_EVENT_QUEUE;
grant select on  BPM_UPDATE_EVENT_QUEUE to MAXDAT_READ_ONLY;
