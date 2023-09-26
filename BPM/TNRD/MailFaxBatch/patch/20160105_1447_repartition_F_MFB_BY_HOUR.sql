create table NEW_F_MFB_BY_HOUR 
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel
as
select
  FMFBBH_ID,
  D_DATE,
  BUCKET_START_DATE,
  BUCKET_END_DATE,
  MFB_BI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_MFB_BY_HOUR;

alter table F_MFB_BY_HOUR drop constraint FMFBBH_DMFBCUR_FK;
alter table F_MFB_BY_HOUR drop constraint FMFBBH_PK;
drop index FMFBBH_PK;
drop index FMFBBH_UIX1; 
drop index FMFBBH_UIX2; 
drop index FMFBBH_IXL1;
drop index FMFBBH_IXL2;
drop index FMFBBH_IXL3;
drop index FMFBBH_IXL4;

alter table F_MFB_BY_HOUR rename to OLD_F_MFB_BY_HOUR;
alter table NEW_F_MFB_BY_HOUR rename to F_MFB_BY_HOUR;

alter table F_MFB_BY_HOUR add constraint FMFBBH_PK primary key (FMFBBH_ID) using index tablespace MAXDAT_INDX;

alter table F_MFB_BY_HOUR add constraint FMFBBH_DMFBCUR_FK foreign key (MFB_BI_ID)references D_MFB_CURRENT (MFB_BI_ID);

create unique index FMFBBH_UIX1 on F_MFB_BY_HOUR (MFB_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMFBBH_UIX2 on F_MFB_BY_HOUR (MFB_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FMFBBH_IXL1 on F_MFB_BY_HOUR (BUCKET_END_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFBBH_IXL2 on F_MFB_BY_HOUR (MFB_BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFBBH_IXL4 on F_MFB_BY_HOUR (CREATION_COUNT) online tablespace MAXDAT_INDX parallel compute statistics;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','F_MFB_BY_HOUR',4);