-- MAXDAT-1083 for ILEB UAT and prod.

alter index MAXDAT.SYS_C0013263 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0016893 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0050910 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0050911 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0016861 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0050858 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0050859 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0050879 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SYS_C0050880 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SIS_HIST_CREATE_BY_IDX rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SIS_HIST_CREATE_TS_IDX rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.SIS_HIST_OWNER_IDX rebuild tablespace MAXDAT_INDX;


-- Partitioned table
DROP INDEX BPM_LOGGING_LX1;
DROP INDEX BPM_LOGGING_LX2;
create index BPM_LOGGING_LX1 on BPM_LOGGING (LOG_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index BPM_LOGGING_LX2 on BPM_LOGGING (BSL_ID, LOG_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

exec DBMS_STATS.UNLOCK_TABLE_STATS('MAXDAT','BPM_UPDATE_EVENT_QUEUE');
DROP INDEX MAXDAT.BUEQ_LX1;
DROP INDEX MAXDAT.BUEQ_LX2;
DROP INDEX MAXDAT.BUEQ_LX3;
DROP INDEX MAXDAT.BUEQ_LX5;
create index MAXDAT.BUEQ_LX1 on MAXDAT.BPM_UPDATE_EVENT_QUEUE (EVENT_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index MAXDAT.BUEQ_LX2 on MAXDAT.BPM_UPDATE_EVENT_QUEUE (PROCESS_BUEQ_ID, 0) online tablespace MAXDAT_INDX parallel compute statistics;
create index MAXDAT.BUEQ_LX3 on MAXDAT.BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) online tablespace MAXDAT_INDX parallel compute statistics;
create index MAXDAT.BUEQ_LX5 on MAXDAT.BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
exec DBMS_STATS.LOCK_TABLE_STATS('MAXDAT','BPM_UPDATE_EVENT_QUEUE');

drop index FCMPLBD_IXL2;
drop index FCMPLBD_IXL3;
drop index FCMPLBD_IXL4;
create index FCMPLBD_IXL2 on F_COMPLAINT_BY_DATE (CMPL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IXL3 on F_COMPLAINT_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IXL4 on F_COMPLAINT_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FMWBD_IXL1;
drop index FMWBD_IXL2;
drop index FMWBD_IXL3;
drop index FMWBD_IXL4;
create index FMWBD_IXL1 on F_MW_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL2 on F_MW_BY_DATE (MW_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL3 on F_MW_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL4 on F_MW_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FNPAMIBD_IXL1;
drop index FNPAMIBD_IXL2;
drop index FNPAMIBD_IXL3;
drop index FNPAMIBD_IXL4;
create index FNPAMIBD_IXL1 on F_NYEC_PAMI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL2 on F_NYEC_PAMI_BY_DATE (NYEC_PAMI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL3 on F_NYEC_PAMI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL4 on F_NYEC_PAMI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FNPABD_IXL1;
drop index FNPABD_IXL2;
drop index FNPABD_IXL3;
drop index FNPABD_IXL4;
create index FNPABD_IXL1 on F_NYEC_PA_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL2 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL3 on F_NYEC_PA_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL4 on F_NYEC_PA_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FNPMIBD_IXL1;
drop index FNPMIBD_IXL2;
drop index FNPMIBD_IXL3;
drop index FNPMIBD_IXL4;
create index FNPMIBD_IXL1 on F_NYEC_PMI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL2 on F_NYEC_PMI_BY_DATE (NYEC_PMI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL3 on F_NYEC_PMI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL4 on F_NYEC_PMI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FNSRBD_IXL1;
drop index FNSRBD_IXL2;
drop index FNSRBD_IXL3;
drop index FNSRBD_IXL4;
create index FNSRBD_IXL1 on F_NYEC_SR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL2 on F_NYEC_SR_BY_DATE (NYEC_SR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL3 on F_NYEC_SR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL4 on F_NYEC_SR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index PBQJB_LX1;
drop index PBQJB_LX2;
create index PBQJB_LX1 on PROCESS_BPM_QUEUE_JOB_BATCH (PBQJ_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index PBQJB_LX2 on PROCESS_BPM_QUEUE_JOB_BATCH (BATCH_START_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
