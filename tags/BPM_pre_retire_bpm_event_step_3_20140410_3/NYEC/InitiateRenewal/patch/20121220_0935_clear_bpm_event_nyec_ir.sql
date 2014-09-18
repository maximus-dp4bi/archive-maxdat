alter session set ddl_lock_timeout = 1200;

create table BPM_INSTANCE_ATTRIBUTE_TEMP
  (BIA_ID       number not null,
   BI_ID        number not null,
   BA_ID        number not null,
   VALUE_NUMBER number,
   VALUE_DATE   date,
   VALUE_CHAR   varchar2(4000),
   START_DATE   date not null,
   END_DATE     date,
   BUE_ID       number not null)
partition by range (BA_ID)
interval(1)
  (partition PT_BIA_BA_LT_0 values less than (0))
tablespace MAXDAT_DATA parallel;

insert into BPM_INSTANCE_ATTRIBUTE_TEMP
select *
from BPM_INSTANCE_ATTRIBUTE 
where BI_ID in
  (select BI_ID
   from BPM_INSTANCE
   where BEM_ID in (1,2,4));

commit;

--alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BI_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_PK;
drop index BPM_INSTANCE_ATTRIBUTE_IX1;
drop index BPM_INSTANCE_ATTRIBUTE_IX2;
drop index BPM_INSTANCE_ATTRIBUTE_UNK1;

drop table BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE rename to BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE_TEMP rename to BPM_INSTANCE_ATTRIBUTE;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BPM_INSTANCE_ATTRIBUTE_PK primary key (BIA_ID);
alter index BPM_INSTANCE_ATTRIBUTE_PK rebuild tablespace MAXDAT_INDX parallel;
alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);
--alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK foreign key (BA_ID) references BPM_ATTRIBUTE (BA_ID);
create index BPM_INSTANCE_ATTRIBUTE_IX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID, BA_ID, END_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
create index BPM_INSTANCE_ATTRIBUTE_IX2 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) tablespace MAXDAT_INDX  parallel compute statistics;
create unique index BPM_INSTANCE_ATTRIBUTE_UNK1	ON BPM_INSTANCE_ATTRIBUTE (BI_ID, BA_ID, START_DATE, END_DATE, BUE_ID) tablespace MAXDAT_INDX  parallel compute statistics;


alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_CONV drop constraint BUEQC_BUE_ID_FK;

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID not in (1,2,4);
commit;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE where BSL_ID not in (1,2,4);
commit;

delete from BPM_UPDATE_EVENT_QUEUE_CONV where BSL_ID not in (1,2,4);
commit;


create table BPM_UPDATE_EVENT_TEMP as
select * 
from BPM_UPDATE_EVENT 
where BI_ID in
  (select BI_ID
   from BPM_INSTANCE
   where BEM_ID in (1,2,4));

commit;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_UPDATE_EVENT drop constraint BPM_UPDATE_EVENT_PK;
drop index BPM_UPDATE_EVENT_PK;
alter table BPM_UPDATE_EVENT drop constraint BEM_BI_FK;
alter table BPM_UPDATE_EVENT drop constraint BUTL_BUE_FK;
drop index BUE_IX1;

drop table BPM_UPDATE_EVENT_BACKUP;
alter table BPM_UPDATE_EVENT rename to BPM_UPDATE_EVENT_BACKUP;
alter table BPM_UPDATE_EVENT_TEMP rename to BPM_UPDATE_EVENT;

alter table BPM_UPDATE_EVENT add constraint BPM_UPDATE_EVENT_PK primary key (BUE_ID);
alter index BPM_UPDATE_EVENT_PK rebuild tablespace MAXDAT_INDX parallel;

create index BUE_IX1 on BPM_UPDATE_EVENT (BI_ID) tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

alter table BPM_UPDATE_EVENT add constraint BEM_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

alter table BPM_UPDATE_EVENT add constraint BUTL_BUE_FK foreign key (BUTL_ID) references BPM_UPDATE_TYPE_LKUP (BUTL_ID);

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_CONV add constraint BUEQC_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

delete from BPM_INSTANCE where BEM_ID not in (1,2,4);

commit;
