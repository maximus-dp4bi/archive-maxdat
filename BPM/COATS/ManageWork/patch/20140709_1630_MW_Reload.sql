create table step_instance_Stg_bkup070914 as select * from step_instance_Stg;

delete from step_instance_Stg where step_instance_history_id < 8129530; 

commit;

delete from step_instance_stg where create_ts < '01-MAY-2014';

commit;

Update step_instance_stg set mw_processed = 'N' where mw_processed = 'Y'; 

commit;

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


