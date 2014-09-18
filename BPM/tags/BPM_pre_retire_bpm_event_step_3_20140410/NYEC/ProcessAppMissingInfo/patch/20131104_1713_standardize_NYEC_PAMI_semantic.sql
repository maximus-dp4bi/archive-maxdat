alter table D_NYEC_PAMI_ITEM_STATUS noparallel;
alter table D_NYEC_PAMI_ITEM_STATUS_PER noparallel;
alter table D_NYEC_PAMI_RFE_STATUS noparallel;

create index FNPAMIBD_IXL3 on F_NYEC_PAMI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;