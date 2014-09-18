-- MAXDAT-1083

drop index FMEBD_IXL1;
drop index FMEBD_IXL2;
drop index FMEBD_IXL3;
drop index FMEBD_IXL4;
create index FMEBD_IXL1 on F_ME_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL2 on F_ME_BY_DATE (ME_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL3 on F_ME_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL4 on F_ME_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FMFDOCBD_IXL1;
drop index FMFDOCBD_IXL2;
drop index FMFDOCBD_IXL3;
drop index FMFDOCBD_IXL4;
create index FMFDOCBD_IXL1 on F_MFDOC_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL2 on F_MFDOC_BY_DATE (MFDOC_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL3 on F_MFDOC_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL4 on F_MFDOC_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;
