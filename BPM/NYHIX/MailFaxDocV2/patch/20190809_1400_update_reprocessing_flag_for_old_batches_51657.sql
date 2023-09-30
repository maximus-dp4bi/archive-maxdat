-- NYHIX-51657
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('NYSOH_MAIL-879444-8/2/2019-9:03:40 AM-89436','NYSOH_MAIL-879020-7/31/2019-2:53:26 PM-146953');

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name IN ('NYSOH_MAIL-879444-8/2/2019-9:03:40 AM-89436','NYSOH_MAIL-879020-7/31/2019-2:53:26 PM-146953');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('NYSOH_MAIL-879444-8/2/2019-9:03:40 AM-89436','NYSOH_MAIL-879020-7/31/2019-2:53:26 PM-146953');

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('NYSOH_MAIL-879444-8/2/2019-9:03:40 AM-89436','NYSOH_MAIL-879020-7/31/2019-2:53:26 PM-146953');

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name IN ('NYSOH_MAIL-879444-8/2/2019-9:03:40 AM-89436','NYSOH_MAIL-879020-7/31/2019-2:53:26 PM-146953');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name IN ('NYSOH_MAIL-879444-8/2/2019-9:03:40 AM-89436','NYSOH_MAIL-879020-7/31/2019-2:53:26 PM-146953');
