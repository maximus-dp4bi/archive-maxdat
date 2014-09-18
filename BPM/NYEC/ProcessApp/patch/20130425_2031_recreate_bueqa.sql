drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

create table BPM_UPDATE_EVENT_QUEUE_ARCHIVE
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

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID);
alter index BUEQA_PK rebuild tablespace MAXDAT_INDX parallel;