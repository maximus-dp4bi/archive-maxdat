alter session set current_schema = MAXDAT;
----  NYHIX-43577
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name 
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-9/7/2018-1:08:48 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-9/7/2018-1:08:48 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-9/7/2018-1:08:48 PM');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-9/7/2018-1:08:48 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-9/7/2018-1:08:48 PM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-9/7/2018-1:08:48 PM');