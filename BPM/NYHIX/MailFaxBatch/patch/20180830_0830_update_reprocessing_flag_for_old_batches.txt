alter session set current_schema = MAXDAT;
----  NYHIX-43319
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-HRA2018-08-28-12-01-25-906');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2018-08-28-12-01-25-906');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-HRA2018-08-28-12-01-25-906');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-HRA2018-08-28-12-01-25-906');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-HRA2018-08-28-12-01-25-906');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2018-08-28-12-01-25-906');