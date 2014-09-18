create index FONLBD_IXL3 on F_ONL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX compute statistics;
