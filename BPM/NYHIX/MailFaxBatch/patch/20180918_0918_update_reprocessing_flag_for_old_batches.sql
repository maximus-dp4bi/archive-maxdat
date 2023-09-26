alter session set current_schema = MAXDAT;
----  NYHIX-43865
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name 
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('743633-9/13/2018-4:16:39 PM-142749');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('743633-9/13/2018-4:16:39 PM-142749');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('743633-9/13/2018-4:16:39 PM-142749');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('743633-9/13/2018-4:16:39 PM-142749');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('743633-9/13/2018-4:16:39 PM-142749');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('743633-9/13/2018-4:16:39 PM-142749');