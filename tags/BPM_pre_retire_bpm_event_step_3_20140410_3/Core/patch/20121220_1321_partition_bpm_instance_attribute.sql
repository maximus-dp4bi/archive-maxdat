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
from BPM_INSTANCE_ATTRIBUTE;

commit;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
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
alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK foreign key (BA_ID) references BPM_ATTRIBUTE (BA_ID);
create index BPM_INSTANCE_ATTRIBUTE_IX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID, BA_ID, END_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
create index BPM_INSTANCE_ATTRIBUTE_IX2 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) tablespace MAXDAT_INDX  parallel compute statistics;
create unique index BPM_INSTANCE_ATTRIBUTE_UNK1	ON BPM_INSTANCE_ATTRIBUTE (BI_ID, BA_ID, START_DATE, END_DATE, BUE_ID) tablespace MAXDAT_INDX  parallel compute statistics;

