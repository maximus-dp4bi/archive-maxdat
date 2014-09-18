create sequence SEQ_BUEQ_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create sequence SEQ_PROCESS_BUEQ_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table BPM_UPDATE_EVENT_QUEUE
  (BUEQ_ID number not null,
   BSL_ID number not null,
   BIL_ID number not null,
   IDENTIFIER varchar2(100) not null,
   EVENT_DATE date not null,
   QUEUE_DATE date not null,
   PROCESS_BUEQ_ID number,
   WROTE_BPM_SEMANTIC_DATE date, 
   DATA_VERSION number not null,
   OLD_DATA xmltype,
   NEW_DATA xmltype not null)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (BSL_ID)
interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
tablespace MAXDAT_DATA parallel;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

create index BUEQ_IX1 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,EVENT_DATE) tablespace MAXDAT_INDX parallel compute statistics;

create index BUEQ_LX1 on BPM_UPDATE_EVENT_QUEUE (EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX2 on BPM_UPDATE_EVENT_QUEUE (PROCESS_BUEQ_ID,0) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX5 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BSL_ID_FK foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BIL_ID_FK foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);

grant select on BPM_UPDATE_EVENT_QUEUE to MAXDAT_READ_ONLY;

-- For MicroStrategy MASH reporting.
create or replace view D_BPM_UPDATE_EVENT_QUEUE_SV as 
select *
from BPM_UPDATE_EVENT_QUEUE
with read only;

grant select on D_BPM_UPDATE_EVENT_QUEUE_SV to MAXDAT_READ_ONLY;


create table BPM_UPDATE_EVENT_QUEUE_ARCHIVE
  (BUEQ_ID number not null,
   BSL_ID number not null,
   BIL_ID number not null,
   IDENTIFIER varchar2(100) not null,
   EVENT_DATE date not null,
   QUEUE_DATE date not null,
   PROCESS_BUEQ_ID number,
   WROTE_BPM_SEMANTIC_DATE date, 
   DATA_VERSION number not null,
   OLD_DATA xmltype,
   NEW_DATA xmltype not null)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (BSL_ID)
interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
tablespace MAXDAT_DATA parallel;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to MAXDAT_READ_ONLY;
