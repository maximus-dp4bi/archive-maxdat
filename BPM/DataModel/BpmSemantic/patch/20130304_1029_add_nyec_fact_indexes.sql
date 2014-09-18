create index FNIRBD_IXL2 on F_NYEC_IR_BY_DATE (NYEC_IR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL2 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL2 on F_NYEC_PAMI_BY_DATE (NYEC_PAMI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL2 on F_NYEC_PMI_BY_DATE (NYEC_PMI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FNSRBD_UIX3;
create index FNSRBD_IXL1 on F_NYEC_SR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL2 on F_NYEC_SR_BY_DATE (NYEC_SR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;