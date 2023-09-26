alter session set current_schema = MAXDAT;
----  NYHIX-43867
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name 
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-HRA2018-09-14-12-02-23-212');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2018-09-14-12-02-23-212');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-HRA2018-09-14-12-02-23-212');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-HRA2018-09-14-12-02-23-212');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-HRA2018-09-14-12-02-23-212');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2018-09-14-12-02-23-212');