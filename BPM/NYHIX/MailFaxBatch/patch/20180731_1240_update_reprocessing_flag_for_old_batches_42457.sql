alter session set current_schema = MAXDAT;
----  NYHIX-42433
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH-FAX-7/25/2018-7:49:35 PM';

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-7/25/2018-7:49:35 PM';

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH-FAX-7/25/2018-7:49:35 PM';
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  -- 2 records
from corp_etl_mfb_batch
where batch_name = 'NYSOH-FAX-7/25/2018-7:49:35 PM';

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-7/25/2018-7:49:35 PM';

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name = 'NYSOH-FAX-7/25/2018-7:49:35 PM';
