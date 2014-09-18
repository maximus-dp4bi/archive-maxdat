drop index FMWBD_UIX1;
drop index FMWBD_UIX2;
drop index FMWBD_UIX3;

create unique index FMWBD_UIX1 on F_MW_BY_DATE (MW_BI_ID,D_DATE) tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMWBD_UIX2 on F_MW_BY_DATE (MW_BI_ID,BUCKET_START_DATE) tablespace MAXDAT_INDX parallel compute statistics;

drop index FNPABD_UIX1;
drop index FNPABD_UIX2;
drop index FNPABD_UIX3;

create unique index FNPABD_UIX1 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID,D_DATE) tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FNPABD_UIX2 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID,BUCKET_START_DATE) tablespace MAXDAT_INDX parallel compute statistics; 
