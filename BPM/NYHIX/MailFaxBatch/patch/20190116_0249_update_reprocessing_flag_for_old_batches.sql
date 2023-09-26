alter session set current_schema = MAXDAT;
----  NYHIX-46838
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 4 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('794713-1/11/2019-8:39:43 AM-139890','NYSOH-FAX-1/11/2019-8:41:23 AM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('794713-1/11/2019-8:39:43 AM-139890','NYSOH-FAX-1/11/2019-8:41:23 AM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('794713-1/11/2019-8:39:43 AM-139890','NYSOH-FAX-1/11/2019-8:41:23 AM');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('794713-1/11/2019-8:39:43 AM-139890','NYSOH-FAX-1/11/2019-8:41:23 AM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('794713-1/11/2019-8:39:43 AM-139890','NYSOH-FAX-1/11/2019-8:41:23 AM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('794713-1/11/2019-8:39:43 AM-139890','NYSOH-FAX-1/11/2019-8:41:23 AM');