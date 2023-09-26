--add to bpm attribute lkup
insert into BPM_ATTRIBUTE_LKUP(bal_id,bdl_id,name,purpose) values(992,3,'Batch Complete Dt','The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).');
insert into BPM_ATTRIBUTE_LKUP(bal_id,bdl_id,name,purpose) values(993,2,'Current Batch Module ID','Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.');
insert into BPM_ATTRIBUTE_LKUP(bal_id,bdl_id,name,purpose) values(994,2,'QC Required Gateway Flag','QC Required Gateway Flag');


--add to bpm attribute
insert into BPM_ATTRIBUTE (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values(2477,992,16,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values(2478,993,16,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values(2479,994,16,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

--add to bast
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,2477,16,'BATCH_COMPLETE_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,2478,16,'CURRENT_BATCH_MODULE_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,2479,16,'GWF_QC_REQUIRED');
commit;


--add to CORP_ETL_MFB_BATCH_OLTP
alter table CORP_ETL_MFB_BATCH_OLTP add BATCH_COMPLETE_DT date null;
alter table CORP_ETL_MFB_BATCH_OLTP add CURRENT_BATCH_MODULE_ID varchar2(38) null;
alter table CORP_ETL_MFB_BATCH_OLTP add GWF_QC_REQUIRED varchar2(1) null;
comment on column CORP_ETL_MFB_BATCH_OLTP.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_OLTP.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';

--add to CORP_ETL_MFB_BATCH_STG
alter table CORP_ETL_MFB_BATCH_STG add BATCH_COMPLETE_DT date null;
alter table CORP_ETL_MFB_BATCH_STG add CURRENT_BATCH_MODULE_ID varchar2(38) null;
alter table CORP_ETL_MFB_BATCH_STG add GWF_QC_REQUIRED varchar2(1) null;
comment on column CORP_ETL_MFB_BATCH_STG.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_STG.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';

--add to CORP_ETL_MFB_BATCH_WIP
alter table CORP_ETL_MFB_BATCH_WIP add BATCH_COMPLETE_DT date null;
alter table CORP_ETL_MFB_BATCH_WIP add CURRENT_BATCH_MODULE_ID varchar2(38) null;
alter table CORP_ETL_MFB_BATCH_WIP add GWF_QC_REQUIRED varchar2(1) null;
comment on column CORP_ETL_MFB_BATCH_WIP.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_WIP.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';

--add to CORP_ETL_MFB_BATCH
alter table CORP_ETL_MFB_BATCH add BATCH_COMPLETE_DT date null;
alter table CORP_ETL_MFB_BATCH add CURRENT_BATCH_MODULE_ID varchar2(38) null;
alter table CORP_ETL_MFB_BATCH add GWF_QC_REQUIRED varchar2(1) null;
comment on column CORP_ETL_MFB_BATCH.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';

alter table d_mfb_current add BATCH_COMPLETE_DT date null;
alter table d_mfb_current add CURRENT_BATCH_MODULE_ID varchar2(38) null;
alter table d_mfb_current add GWF_QC_REQUIRED varchar2(1) null;


