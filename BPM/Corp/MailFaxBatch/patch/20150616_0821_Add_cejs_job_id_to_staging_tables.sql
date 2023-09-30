--add to CORP_ETL_MFB_BATCH_STG
alter table CORP_ETL_MFB_BATCH_STG add CEJS_JOB_ID number null;
comment on column CORP_ETL_MFB_BATCH_STG.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';

--add to CORP_ETL_MFB_BATCH_OLTP
alter table CORP_ETL_MFB_BATCH_OLTP add CEJS_JOB_ID number null;
comment on column CORP_ETL_MFB_BATCH_OLTP.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';

--add to CORP_ETL_MFB_BATCH_WIP
alter table CORP_ETL_MFB_BATCH_WIP add CEJS_JOB_ID number null;
comment on column CORP_ETL_MFB_BATCH_WIP.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';

