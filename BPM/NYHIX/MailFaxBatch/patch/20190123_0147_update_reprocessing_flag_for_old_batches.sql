alter session set current_schema = MAXDAT;
----  NYHIX-46922/46933
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-HRA2019-01-15-12-01-28-291','NYSOH-FAX-1/15/2019-5:25:44 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2019-01-15-12-01-28-291','NYSOH-FAX-1/15/2019-5:25:44 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-HRA2019-01-15-12-01-28-291','NYSOH-FAX-1/15/2019-5:25:44 PM');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-HRA2019-01-15-12-01-28-291','NYSOH-FAX-1/15/2019-5:25:44 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-HRA2019-01-15-12-01-28-291','NYSOH-FAX-1/15/2019-5:25:44 PM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2019-01-15-12-01-28-291','NYSOH-FAX-1/15/2019-5:25:44 PM');