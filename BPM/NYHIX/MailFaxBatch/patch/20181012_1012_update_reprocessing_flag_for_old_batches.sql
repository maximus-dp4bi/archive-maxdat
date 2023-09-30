alter session set current_schema = MAXDAT;
----  NYHIX-44551
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('752366-10/5/2018-2:45:44 PM-139890');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('752366-10/5/2018-2:45:44 PM-139890');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('752366-10/5/2018-2:45:44 PM-139890');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('752366-10/5/2018-2:45:44 PM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('752366-10/5/2018-2:45:44 PM-139890');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('752366-10/5/2018-2:45:44 PM-139890');