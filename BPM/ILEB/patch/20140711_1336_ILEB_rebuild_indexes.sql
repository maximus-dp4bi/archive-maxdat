-- MAXDAT-1083 for ILEB UAT and prod.
/* Following table no longer used.
alter index MAXDAT.IDX_CL_ELIG_STAT_CLIENT_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CL_ELIG_STAT_CREATE_TS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CL_ELIG_STAT_UPDATE_TS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.PK_CLNT_ELIG_STAT_ID rebuild tablespace MAXDAT_INDX;
*/

alter index MAXDAT.BPM_D_DATES_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CC_S_TMP_AVY_AGENT_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CC_S_TMP_AVY_APPLICATION_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CLIENT_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CLNT_ENRL_STAT_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CREATE_TS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_ENROLL_STATUS_CD rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_UPDATE_TS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_ERROR_LOG_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_JOB_STATISTICS_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_MEA_BPM_INST_STAT rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.MANAGE_ENRL_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.MANAGE_ENRL_UNQ rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_ASED_FIRST_FOLLOWUP rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_1ST_FU_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_2ND_FU_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_3RD_FU_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_4TH_FU_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_AGE_BUS_DAYS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_AGE_CAL_DAYS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_CANCEL_DT rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_CASE_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_CEME_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_CLIENT_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_CREATE_DT rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_ENRL_PACK_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_ENRL_STAT_CD rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_ENRL_STAT_DT rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_INST_STAT rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_CEME_SLCT_METHOD rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_ENRL_PACK_REQUEST_DT rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_PLAN_TYPE rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_SEL_AUTO_PROC rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_WIP_CEME_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_WIP_UPD_FLG rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.JOBS_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.XPKCORP_ETL_MANAGE_JOBS rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_MANAGE_JOBS_OLTP_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.XPKCORP_ETL_MANAGE_JOBS_OLTP rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_MANAGE_JOBS_WIP__PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_PROCESS_ONLINE_I_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_PROC_ONLINE_OLTP_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_ETL_PROC_ONLINE_WIP_PK rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.CORP_INSTANCE_CLEANUP_IDX1 rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.XPKILEB_ETL_FILE_LKUP rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.XPKILEB_FILE_CAL_LKUP rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX1_PROVIDERNUM_PROGRAM rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.LETTER_CASE_ID_IDX rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.LETTER_REQ_ON_IDX rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.MNG_ENRL_FU_UNQ rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.MNG_ENRL_SLA_UNQ rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_SEL_CLIENT_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.PK_SELECTION_TXN_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_STEP_INST_STG_CASE_ID rebuild tablespace MAXDAT_INDX;
alter index MAXDAT.IDX_STEP_INST_STG_CLIENT_ID rebuild tablespace MAXDAT_INDX;


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

drop index FMWBD_IXL1;
drop index FMWBD_IXL2;
drop index FMWBD_IXL3;
drop index FMWBD_IXL4;
create index FMWBD_IXL1 on F_MW_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL2 on F_MW_BY_DATE (MW_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL3 on F_MW_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL4 on F_MW_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FMJBD_IXL1;
drop index FMJBD_IXL2;
drop index FMJBD_IXL3;
drop index FMJBD_IXL4;
create index FMJBD_IXL1 on F_MJ_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXL2 on F_MJ_BY_DATE (MJ_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXL3 on F_MJ_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMJBD_IXL4 on F_MJ_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FOBCBD_IXL1;
drop index FOBCBD_IXL2;
drop index FOBCBD_IXL3;
drop index FOBCBD_IXL4;
create index FOBCBD_IXL1 on F_OBC_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FOBCBD_IXL2 on F_OBC_BY_DATE (OBC_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FOBCBD_IXL3 on F_OBC_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FOBCBD_IXL4 on F_OBC_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FONLBD_IXL1;
drop index FONLBD_IXL2;
drop index FONLBD_IXL3;
drop index FONLBD_IXL4;
create index FONLBD_IXL1 on F_ONL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL2 on F_ONL_BY_DATE (ONL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL3 on F_ONL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL4 on F_ONL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FPIBD_IXL1;
drop index FPIBD_IXL2;
drop index FPIBD_IXL3;
create index FPIBD_IXL1 on F_PI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPIBD_IXL2 on F_PI_BY_DATE (PI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPIBD_IXL3 on F_PI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FPLBD_IXL1;
drop index FPLBD_IXL2;
drop index FPLBD_IXL3;
drop index FPLBD_IXL4;
create index FPLBD_IXL1 on F_PL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL2 on F_PL_BY_DATE (PL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL3 on F_PL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL4 on F_PL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index FSCIBD_IXL1;
drop index FSCIBD_IXL2;
drop index FSCIBD_IXL3;
drop index FSCIBD_IXL4;
create index FSCIBD_IXL1 on F_SCI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL2 on F_SCI_BY_DATE (SCI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL3 on F_SCI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL4 on F_SCI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

drop index PBQJB_LX1;
drop index PBQJB_LX2;
create index PBQJB_LX1 on PROCESS_BPM_QUEUE_JOB_BATCH (PBQJ_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index PBQJB_LX2 on PROCESS_BPM_QUEUE_JOB_BATCH (BATCH_START_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
