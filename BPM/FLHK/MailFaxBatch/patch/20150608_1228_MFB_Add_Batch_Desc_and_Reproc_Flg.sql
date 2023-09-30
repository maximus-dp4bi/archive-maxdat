
--add to CORP_ETL_MFB_SB_OLTP
alter table CORP_ETL_MFB_SB_OLTP add BATCHDESCRIPTION varchar2(80) null;
comment on column CORP_ETL_MFB_SB_OLTP.BATCHDESCRIPTION is 'Batch Description, may contain a batch_name if reprocessed';

--add to CORP_ETL_MFB_BATCH_OLTP
alter table CORP_ETL_MFB_BATCH_OLTP add BATCH_DESCRIPTION varchar2(80) null;
alter table CORP_ETL_MFB_BATCH_OLTP add REPROCESSED_FLAG varchar2(1) default 'N';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_DESCRIPTION is 'Batch Description, may contain a batch_name if reprocessed';
comment on column CORP_ETL_MFB_BATCH_OLTP.REPROCESSED_FLAG is 'Reprocessed Flag identifies records that were not previously successfully processed';

--add to CORP_ETL_MFB_BATCH_STG
alter table CORP_ETL_MFB_BATCH_STG add BATCH_DESCRIPTION varchar2(80) null;
alter table CORP_ETL_MFB_BATCH_STG add REPROCESSED_FLAG varchar2(1) default 'N';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_DESCRIPTION is 'Batch Description, may contain a batch_name if reprocessed';
comment on column CORP_ETL_MFB_BATCH_STG.REPROCESSED_FLAG is 'Reprocessed Flag identifies records that were not previously successfully processed';
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_REPROS_FLG check (REPROCESSED_FLAG in('Y','N'));

--add to CORP_ETL_MFB_BATCH_WIP
alter table CORP_ETL_MFB_BATCH_WIP add BATCH_DESCRIPTION varchar2(80) null;
alter table CORP_ETL_MFB_BATCH_WIP add REPROCESSED_FLAG varchar2(1) default 'N';
alter table CORP_ETL_MFB_BATCH_WIP add CEJS_JOB_ID number null;
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_DESCRIPTION is 'Batch Description, may contain a batch_name if reprocessed';
comment on column CORP_ETL_MFB_BATCH_WIP.REPROCESSED_FLAG is 'Reprocessed Flag identifies records that were not previously successfully processed';
comment on column CORP_ETL_MFB_BATCH_WIP.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';

--add to CORP_ETL_MFB_BATCH
alter table CORP_ETL_MFB_BATCH add BATCH_DESCRIPTION varchar2(80) null;
alter table CORP_ETL_MFB_BATCH add REPROCESSED_FLAG varchar2(1) default 'N';
alter table CORP_ETL_MFB_BATCH add CEJS_JOB_ID number null;
comment on column CORP_ETL_MFB_BATCH.BATCH_DESCRIPTION is 'Batch Description, may contain a batch_name if reprocessed';
comment on column CORP_ETL_MFB_BATCH.REPROCESSED_FLAG is 'Reprocessed Flag identifies records that were not previously successfully processed';
comment on column CORP_ETL_MFB_BATCH.CEJS_JOB_ID is 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_REPROS_FLG check (REPROCESSED_FLAG in('Y','N'));

--add to d_mfb_current
alter table d_mfb_current add BATCH_DESCRIPTION varchar2(80) null;
alter table d_mfb_current add REPROCESSED_FLAG varchar2(1) default 'N';

--update d_mfb_current_sv
create or replace view D_MFB_CURRENT_SV as
select * from D_MFB_CURRENT
with read only;
