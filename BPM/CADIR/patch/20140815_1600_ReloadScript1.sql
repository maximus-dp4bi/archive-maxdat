truncate table BPM_UPDATE_EVENT_QUEUE;

truncate table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

truncate table CORP_ETL_MANAGE_WORK;

truncate table CORP_ETL_MANAGE_WORK_TMP;

truncate table PP_F_ACTUALS;

truncate table PP_D_ACTUAL_DETAILS;

truncate table F_MW_BY_DATE;

alter table F_MW_BY_DATE drop constraint FMWBD_DMWCUR_FK;

truncate table D_MW_CURRENT;

alter table F_MW_BY_DATE add constraint FMWBD_DMWCUR_FK foreign key (MW_BI_ID) references D_MW_CURRENT (MW_BI_ID);

update corp_etl_control set Value = 0 where name = 'MW_LAST_STEP_INST_HIST_ID';
update corp_etl_control set Value = 0 where name = 'MW_MAX_PROCESSED_ID';

COMMIT;

