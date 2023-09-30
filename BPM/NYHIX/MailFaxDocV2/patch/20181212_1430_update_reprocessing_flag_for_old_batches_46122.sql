-- NYHIX-46122
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = 'NYSOH-FAX-12/6/2018-11:41:35 PM';

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-12/6/2018-11:41:35 PM';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = 'NYSOH-FAX-12/6/2018-11:41:35 PM';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = 'NYSOH-FAX-12/6/2018-11:41:35 PM';

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH-FAX-12/6/2018-11:41:35 PM';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name = 'NYSOH-FAX-12/6/2018-11:41:35 PM';
