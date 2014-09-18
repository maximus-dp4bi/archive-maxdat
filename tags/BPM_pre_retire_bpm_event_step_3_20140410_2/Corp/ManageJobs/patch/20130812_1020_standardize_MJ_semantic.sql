alter table D_MJ_CURRENT rename constraint DIMJCUR_PK to DMJCUR_PK;

alter table D_MJ_LAST_UPDATE_BY noparallel;

-- OK if these 3 drops fail.  Not an error.
drop index FMRBD_UIX1;
drop index FMRBD_UIX2;
drop index FMRBD_UIX3;

create unique index FMJBD_UIX1 on F_MJ_BY_DATE (MJ_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMJBD_UIX2 on F_MJ_BY_DATE (MJ_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FMJBD_IX1 on F_MJ_BY_DATE (LAST_UPDATE_BY_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FMJBD_IXT1 on F_MJ_BY_DATE (BUCKET_END_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXT2 on F_MJ_BY_DATE (MJ_BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXT3 on F_MJ_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) online tablespace MAXDAT_INDX parallel compute statistics;