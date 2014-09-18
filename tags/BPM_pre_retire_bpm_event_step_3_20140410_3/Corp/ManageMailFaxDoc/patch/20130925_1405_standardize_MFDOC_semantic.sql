alter table D_MFDOC_INSTANCE_STATUS noparallel;
alter table D_MFDOC_DOCUMENT_STATUS noparallel;
alter table D_MFDOC_TIMELINESS_STATUS noparallel;
alter table D_MFDOC_BATCH noparallel;
alter table D_MFDOC_DOC_TYPE noparallel;
alter table D_MFDOC_DCN_JEOPARDY_STATUS noparallel;

create index FMFDOCBD_IXL2 on F_MFDOC_BY_DATE (MFDOC_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL3 on F_MFDOC_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;