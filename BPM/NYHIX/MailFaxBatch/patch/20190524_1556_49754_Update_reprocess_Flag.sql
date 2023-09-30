alter session set current_schema = MAXDAT;


----  NYHIX-49754
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 2 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('853033-5/17/2019-2:42:48 PM-146953');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('853033-5/17/2019-2:42:48 PM-146953');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('853033-5/17/2019-2:42:48 PM-146953');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 1 records
from corp_etl_mfb_batch
where batch_name in  ('853033-5/17/2019-2:42:48 PM-146953');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('853033-5/17/2019-2:42:48 PM-146953');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('853033-5/17/2019-2:42:48 PM-146953');





