alter table D_PL_LETTER_STATUS noparallel;
create index FPLBD_IXL2 on F_PL_BY_DATE (PL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL3 on F_PL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;