alter session set current_schema = MAXDAT;
----  NYHIX-47120
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-1/24/2019-1:23:58 PM','800219-1/24/2019-8:42:00 AM-139890');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-1/24/2019-1:23:58 PM','800219-1/24/2019-8:42:00 AM-139890');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-1/24/2019-1:23:58 PM','800219-1/24/2019-8:42:00 AM-139890');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-1/24/2019-1:23:58 PM','800219-1/24/2019-8:42:00 AM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-1/24/2019-1:23:58 PM','800219-1/24/2019-8:42:00 AM-139890');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-1/24/2019-1:23:58 PM','800219-1/24/2019-8:42:00 AM-139890');