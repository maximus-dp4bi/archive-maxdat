-- OK if this drop table fails because table does not exist.
drop table F_MJ_BY_DATE_TEMP;

create table F_MJ_BY_DATE_TEMP
  (FIMJBD_ID number not null, 
   D_DATE date not null, 
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   MJ_BI_ID number not null, 
   DIMJLUB_ID number not null, 
   LAST_UPDATE_BY_DATE date,
   CREATION_COUNT number, 
   INVENTORY_COUNT number, 
   COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

insert into F_MJ_BY_DATE_TEMP
select 
   FIMJBD_ID,
   D_DATE, 
   BUCKET_START_DATE,
   BUCKET_END_DATE,
   MJ_BI_ID, 
   DIMJLUB_ID, 
   LAST_UPDATE_BY_DATE,
   CREATION_COUNT, 
   INVENTORY_COUNT, 
   COMPLETION_COUNT
from F_MJ_BY_DATE;

commit;

alter table F_MJ_BY_DATE drop constraint FIMJBD_DIMJLUB_FK;
alter table F_MJ_BY_DATE drop constraint FIMJBD_DIMJCUR_FK;
alter table F_MJ_BY_DATE drop constraint FIMJBD_PK;

drop index FMJBD_IX1;

drop index FNMRBD_UIX1;
drop index FNMRBD_UIX2;

drop index FMJBD_IXT1;
drop index FMJBD_IXT2;
drop index FMJBD_IXT3;
drop index FMJBD_IXT4;

drop index FNMRBD_UIX1;
drop index FNMRBD_UIX2;
drop index FNMRBD_UIX3;

alter table F_MJ_BY_DATE rename to F_MJ_BY_DATE_BCK;
alter table F_MJ_BY_DATE_TEMP rename to F_MJ_BY_DATE;

alter table F_MJ_BY_DATE add constraint FMJBD_PK primary key (FIMJBD_ID) using index tablespace MAXDAT_INDX;

alter table F_MJ_BY_DATE add constraint FMJBD_DMJLUB_FK foreign key (DIMJLUB_ID) references D_MJ_LAST_UPDATE_BY(DIMJLUB_ID);
alter table F_MJ_BY_DATE add constraint FMJBD_DMJCUR_FK foreign key (MJ_BI_ID) references D_MJ_CURRENT(MJ_BI_ID);

create unique index FMJBD_UIX1 on F_MJ_BY_DATE (MJ_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMJBD_UIX2 on F_MJ_BY_DATE (MJ_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FMJBD_IX1 on F_MJ_BY_DATE (LAST_UPDATE_BY_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FMJBD_IXL1 on F_MJ_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXL2 on F_MJ_BY_DATE (MJ_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXL3 on F_MJ_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXL4 on F_MJ_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_MJ_BY_DATE for F_MJ_BY_DATE;
grant select on F_MJ_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_MJ_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FIMJBD_ID, 
  BUCKET_START_DATE D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from F_MJ_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FIMJBD_ID, 
  bdd.D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  F_MJ_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FIMJBD_ID, 
  bdd.D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from
  BPM_D_DATES bdd,
  F_MJ_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FIMJBD_ID, 
  bdd.D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from
  BPM_D_DATES bdd,
  F_MJ_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;