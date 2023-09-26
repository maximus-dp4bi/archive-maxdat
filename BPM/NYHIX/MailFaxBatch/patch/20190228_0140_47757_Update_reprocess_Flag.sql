alter session set current_schema = MAXDAT;
----  NYHIX-47757
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 7 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('812751-2/20/2019-4:09:27 PM-149078','812828-2/21/2019-8:41:56 AM-139890','813280-2/21/2019-1:29:27 PM-139890','813101-2/21/2019-11:25:30 AM-132972');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('812751-2/20/2019-4:09:27 PM-149078','812828-2/21/2019-8:41:56 AM-139890','813280-2/21/2019-1:29:27 PM-139890','813101-2/21/2019-11:25:30 AM-132972');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('812751-2/20/2019-4:09:27 PM-149078','812828-2/21/2019-8:41:56 AM-139890','813280-2/21/2019-1:29:27 PM-139890','813101-2/21/2019-11:25:30 AM-132972');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 4 records
from corp_etl_mfb_batch
where batch_name in  ('812751-2/20/2019-4:09:27 PM-149078','812828-2/21/2019-8:41:56 AM-139890','813280-2/21/2019-1:29:27 PM-139890','813101-2/21/2019-11:25:30 AM-132972');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('812751-2/20/2019-4:09:27 PM-149078','812828-2/21/2019-8:41:56 AM-139890','813280-2/21/2019-1:29:27 PM-139890','813101-2/21/2019-11:25:30 AM-132972');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('812751-2/20/2019-4:09:27 PM-149078','812828-2/21/2019-8:41:56 AM-139890','813280-2/21/2019-1:29:27 PM-139890','813101-2/21/2019-11:25:30 AM-132972');



