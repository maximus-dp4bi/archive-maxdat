drop index FMJBD_UIX1;
drop index FMJBD_UIX2;

create unique index FMJBD_UIX1 on F_MJ_BY_DATE (MJ_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMJBD_UIX2 on F_MJ_BY_DATE (MJ_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

