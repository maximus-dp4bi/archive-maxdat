/*
Created on 12/02/2016 by Raj A.
MAXDAT-4283. Change partitioning to by event day in active table to greatly reduce large empty tables and improve performance.
*/
-- NYHIX-4283 - UAT
alter session set current_schema = MAXDAT;

alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_PK;
alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BSL_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BIL_ID_FK;

drop index BUEQ_IX1;
drop index BUEQ_IX2;
drop index BUEQ_IX3;
drop index BUEQ_IX4;

drop table BPM_UPDATE_EVENT_QUEUE_BAK;
alter table BPM_UPDATE_EVENT_QUEUE rename to BPM_UPDATE_EVENT_QUEUE_BAK;

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
partition by range (QUEUE_DATE) interval (numtodsinterval(1,'DAY'))
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
tablespace MAXDAT_DATA
storage(initial 65536 next 1048576 minextents 1 maxextents 2147483645)
parallel 2;

insert into BPM_UPDATE_EVENT_QUEUE 
  (BUEQ_ID,
   BSL_ID,
   BIL_ID,
   IDENTIFIER,
   EVENT_DATE,
   QUEUE_DATE,
   PROCESS_BUEQ_ID,
   WROTE_BPM_SEMANTIC_DATE, 
   DATA_VERSION,
   OLD_DATA,
   NEW_DATA,
   CEJS_JOB_ID) 
select 
   BUEQ_ID,
   BSL_ID,
   BIL_ID,
   IDENTIFIER,
   EVENT_DATE,
   QUEUE_DATE,
   PROCESS_BUEQ_ID,
   WROTE_BPM_SEMANTIC_DATE, 
   DATA_VERSION,
   OLD_DATA,
   NEW_DATA,
   CEJS_JOB_ID
from BPM_UPDATE_EVENT_QUEUE_BAK;

commit;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;
alter index BUEQ_PK parallel 2;

create index BUEQ_IX1 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,EVENT_DATE) online tablespace MAXDAT_INDX parallel 2 compute statistics;
create index BUEQ_IX2 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,PROCESS_BUEQ_ID) online tablespace MAXDAT_INDX parallel 2 compute statistics;
create index BUEQ_IX3 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,IDENTIFIER) online tablespace MAXDAT_INDX parallel 2 compute statistics;
create index BUEQ_IX4 on BPM_UPDATE_EVENT_QUEUE (BSL_ID,WROTE_BPM_SEMANTIC_DATE) online tablespace MAXDAT_INDX parallel 2 compute statistics;

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BSL_ID_FK foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BIL_ID_FK foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);

grant select on BPM_UPDATE_EVENT_QUEUE to MAXDAT_READ_ONLY;

execute MAXDAT_ADMIN.UNLOCK_TABLE_STATS('MAXDAT','BPM_UPDATE_EVENT_QUEUE');
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','BPM_UPDATE_EVENT_QUEUE',8);
execute MAXDAT_ADMIN.LOCK_TABLE_STATS('MAXDAT','BPM_UPDATE_EVENT_QUEUE');