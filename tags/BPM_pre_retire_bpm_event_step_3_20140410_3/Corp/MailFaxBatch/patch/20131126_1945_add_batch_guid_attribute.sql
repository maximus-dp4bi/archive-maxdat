insert into BPM_ATTRIBUTE_LKUP(bal_id,bdl_id,name,purpose) values(995,2,'Batch GUID','Unique indicator for the Batch in Kofax 10.');
insert into BPM_ATTRIBUTE (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values(2023,995,16,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,2023,16,'BATCH_GUID');
COMMIT;
