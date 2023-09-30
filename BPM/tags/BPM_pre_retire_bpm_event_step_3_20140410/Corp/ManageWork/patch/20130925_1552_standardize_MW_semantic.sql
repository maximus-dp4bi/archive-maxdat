alter table D_MW_ESCALATED noparallel;
alter table D_MW_FORWARDED noparallel;
alter table D_MW_LAST_UPDATE_BY_NAME noparallel;
alter table D_MW_OWNER noparallel;
alter table D_MW_TASK_STATUS noparallel;
alter table D_MW_TASK_STATUS rename constraint DMTS_PK to DMWTS_PK;
alter table D_MW_TASK_TYPE noparallel;
alter table D_MW_TASK_TYPE rename constraint DMWH_PK to DMWTT_PK;