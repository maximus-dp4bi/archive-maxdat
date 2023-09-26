-- NYHIX-51346
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = 'NYSOH_MAIL-874270-7/19/2019-11:01:35 PM-150812';

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_MAIL-874270-7/19/2019-11:01:35 PM-150812';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = 'NYSOH_MAIL-874270-7/19/2019-11:01:35 PM-150812';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = 'NYSOH_MAIL-874270-7/19/2019-11:01:35 PM-150812';

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_MAIL-874270-7/19/2019-11:01:35 PM-150812';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name = 'NYSOH_MAIL-874270-7/19/2019-11:01:35 PM-150812';
