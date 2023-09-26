-- NYHIX-46385
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('785507-12/21/2018-8:27:12 AM-89436','786180-12/24/2018-9:14:40 AM-139890');

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name IN ('785507-12/21/2018-8:27:12 AM-89436','786180-12/24/2018-9:14:40 AM-139890');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('785507-12/21/2018-8:27:12 AM-89436','786180-12/24/2018-9:14:40 AM-139890');

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('785507-12/21/2018-8:27:12 AM-89436','786180-12/24/2018-9:14:40 AM-139890');

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name IN ('785507-12/21/2018-8:27:12 AM-89436','786180-12/24/2018-9:14:40 AM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name IN ('785507-12/21/2018-8:27:12 AM-89436','786180-12/24/2018-9:14:40 AM-139890');
