alter table D_SCI_CURRENT parallel;

create index FSCIBD_IXL2 on F_SCI_BY_DATE (SCI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL3 on F_SCI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
