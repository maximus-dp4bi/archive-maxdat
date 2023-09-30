alter table D_NYEC_SR_RFE_STATUS_FLAG noparallel;
alter table D_NYEC_SR_STATE_ACCEPT_IND noparallel;
alter table D_NYEC_SR_HEART_APP_STATUS noparallel;
alter table D_NYEC_SR_APP_STATUS_GROUP noparallel;

create index FNSRBD_IXL3 on F_NYEC_SR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;