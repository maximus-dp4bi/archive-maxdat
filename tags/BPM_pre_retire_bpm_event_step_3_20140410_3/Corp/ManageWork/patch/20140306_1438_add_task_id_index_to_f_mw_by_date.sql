create index FMWBD_IXL5 on F_MW_BY_DATE (DMWTT_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL6 on F_MW_BY_DATE (DMWTS_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
