alter session set current_schema = MAXDAT;
----  NYHIX-44239
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('748608-9/27/2018-8:44:25 AM-146953');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('748608-9/27/2018-8:44:25 AM-146953');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('748608-9/27/2018-8:44:25 AM-146953');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('748608-9/27/2018-8:44:25 AM-146953');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('748608-9/27/2018-8:44:25 AM-146953');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('748608-9/27/2018-8:44:25 AM-146953');