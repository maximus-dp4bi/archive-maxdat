--alter session set current_schema = MAXDAT;

create table TESTG_F_MFB_BY_HOUR 
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
from TEST_F_MFB_BY_HOUR;

alter table TESTG_F_MFB_BY_HOUR add constraint TGFMFBBH_PK primary key (FMFBBH_ID) using index tablespace MAXDAT_INDX;

alter table TESTG_F_MFB_BY_HOUR add constraint TGFMFBBH_DMFBCUR_FK foreign key (MFB_BI_ID)references D_MFB_CURRENT (MFB_BI_ID);

create unique index TGFMFBBH_UIX1 on TESTG_F_MFB_BY_HOUR (MFB_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index TGFMFBBH_UIX2 on TESTG_F_MFB_BY_HOUR (MFB_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index TGFMFBBH_IX1 on TESTG_F_MFB_BY_HOUR (BUCKET_END_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index TGFMFBBH_IX2 on TESTG_F_MFB_BY_HOUR (MFB_BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index TGFMFBBH_IX4 on TESTG_F_MFB_BY_HOUR (CREATION_COUNT) online tablespace MAXDAT_INDX parallel compute statistics;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','TESTG_F_MFB_BY_HOUR',4);