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

/* Generate subpartition SQL
select 'subpartition sp' || BSL_ID || ' values less than (' || to_number(BSL_ID + 1) || ') ,'
from BPM_SOURCE_LKUP 
order by BSL_ID asc;
*/
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
   NEW_DATA xmltype not null,
   CEJS_JOB_ID number)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (EVENT_DATE) interval (numtodsinterval(1,'DAY'))
subpartition by range (BSL_ID)
subpartition template (
  subpartition sp1 values less than (2),
  subpartition sp12 values less than (13),
  subpartition sp16 values less than (17),
  subpartition sp18 values less than (19),
  subpartition sp21 values less than (22),
  subpartition sp22 values less than (23),
  subpartition sp23 values less than (24),
  subpartition sp24 values less than (25),
  subpartition sp30 values less than (31),
  subpartition sp2001 values less than (2002) ,
  subpartition spmax values less than (maxvalue) )
(partition PT_BUEQ_INIT values less than (to_date('2015-01-01','YYYY-MM-DD')))
tablespace &tablespace_name
storage(initial 65536 next 1048576 minextents 1 maxextents 2147483645)
parallel 4;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_PK primary key (BUEQ_ID) using index tablespace &tablespace_name;

create index BUEQ_IX1 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,EVENT_DATE) online tablespace &tablespace_name parallel compute statistics;
create index BUEQ_IX2 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,PROCESS_BUEQ_ID) online tablespace &tablespace_name parallel compute statistics;
create index BUEQ_IX3 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,IDENTIFIER) online tablespace &tablespace_name parallel compute statistics;
create index BUEQ_IX4 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,WROTE_BPM_SEMANTIC_DATE) online tablespace &tablespace_name parallel compute statistics;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BSL_ID_FK foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BIL_ID_FK foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);

grant select on BPM_UPDATE_EVENT_QUEUE to &role_name;

-- For MicroStrategy MASH reporting.
create or replace view D_BPM_UPDATE_EVENT_QUEUE_SV as 
select *
from BPM_UPDATE_EVENT_QUEUE
with read only;

grant select on D_BPM_UPDATE_EVENT_QUEUE_SV to &role_name;


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
   NEW_DATA xmltype not null,
   CEJS_JOB_ID number)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (BSL_ID)
interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
tablespace &tablespace_name parallel;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace &tablespace_name;

grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to &role_name;
