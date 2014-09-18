alter table D_NYEC_PMI_APP_ID noparallel;
alter table D_NYEC_PMI_LETTER_STATUS noparallel;
alter table D_NYEC_PMI_INBOUND_MI_TYPE noparallel;
alter table D_NYEC_PMI_PENDING_MI_TYPE noparallel;
alter table D_NYEC_PMI_QC_TASK_ID noparallel;
alter table D_NYEC_PMI_RESEARCH_REASON noparallel;
alter table D_NYEC_PMI_RESEARCH_TASK_ID noparallel;
alter table D_NYEC_PMI_ST_REV_TASK_ID noparallel;

create index FNPMIBD_IXL3 on F_NYEC_PMI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
