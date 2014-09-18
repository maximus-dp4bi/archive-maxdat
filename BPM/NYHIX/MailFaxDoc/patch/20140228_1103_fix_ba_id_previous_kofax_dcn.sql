insert into bpm_attribute (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values (2609,1609,18,'BOTH',sysdate,bpm_common.get_max_date,'N');
commit;

delete from bpm_attribute_staging_table where ba_id = 2604 and bsl_id = 18;
commit;


insert into bpm_attribute_staging_table (bast_id,ba_id,bsl_id,staging_table_column) values (seq_bast_id.nextval,2609,18,'PREVIOUS_KOFAX_DCN');
commit;


alter table BPM_INSTANCE_ATTRIBUTE enable row movement;

UPDATE BPM_INSTANCE_ATTRIBUTE
set ba_id   = 2609
WHERE BA_ID = 2604;
COMMIT;

alter table bpm_instance_attribute disable row movement;

delete from bpm_attribute where ba_id = 2604 and bal_id = 1609;
commit;