drop index FMJBD_IX1;
drop index FMJBD_UIX1;
drop index FMJBD_UIX2;
drop index FNMRBD_UIX3;

create index FMJBD_IX1 on F_MJ_BY_DATE (LAST_UPDATE_BY_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create unique index FMJBD_UIX1 on F_MJ_BY_DATE (MJ_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMJBD_UIX2 on F_MJ_BY_DATE (MJ_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

