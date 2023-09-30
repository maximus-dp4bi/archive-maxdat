--add to bpm_attribute_lkup
insert into BPM_ATTRIBUTE_LKUP(bal_id,bdl_id,name,purpose) values(178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
--add to bpm attribute
insert into BPM_ATTRIBUTE (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values(2483,178,16,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
--add to bast
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,2483,16,'CURRENT_STEP');
commit;

--add to CORP_ETL_MFB_BATCH_OLTP
alter table CORP_ETL_MFB_BATCH_OLTP add CURRENT_STEP varchar2(100) null;
comment on column CORP_ETL_MFB_BATCH_OLTP.CURRENT_STEP is 'Current Activity Step for this Instance.';

--add to CORP_ETL_MFB_BATCH_STG
alter table CORP_ETL_MFB_BATCH_STG add CURRENT_STEP varchar2(100) null;
comment on column CORP_ETL_MFB_BATCH_STG.CURRENT_STEP is 'Current Activity Step for this Instance.';

--add to CORP_ETL_MFB_BATCH_WIP
alter table CORP_ETL_MFB_BATCH_WIP add CURRENT_STEP varchar2(100) null;
comment on column CORP_ETL_MFB_BATCH_WIP.CURRENT_STEP is 'Current Activity Step for this Instance.';

--add to CORP_ETL_MFB_BATCH
alter table CORP_ETL_MFB_BATCH add CURRENT_STEP varchar2(100) null;
comment on column CORP_ETL_MFB_BATCH.CURRENT_STEP is 'Current Activity Step for this Instance.';

alter table d_mfb_current add CURRENT_STEP varchar2(100) null;

create or replace public synonym D_MFB_CURRENT for D_MFB_CURRENT;
grant select on D_MFB_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_MFB_CURRENT_SV as
select * from D_MFB_CURRENT
with read only;

create or replace public synonym D_MFB_CURRENT_SV for D_MFB_CURRENT_SV;
grant select on D_MFB_CURRENT_SV to MAXDAT_READ_ONLY;