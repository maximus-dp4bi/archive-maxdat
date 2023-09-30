--add to CORP_ETL_MFB_BATCH_EVENTS_WIP
alter table CORP_ETL_MFB_BATCH_EVENTS_WIP add ERROR_TEXT varchar2(255) null;
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.ERROR_TEXT is 'StatsBatchModule Error Information';

commit;
