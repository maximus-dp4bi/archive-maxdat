-- NYHIX-45909
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = '775340-11/30/2018-9:20:06 AM-146947';

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name = '775340-11/30/2018-9:20:06 AM-146947';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = '775340-11/30/2018-9:20:06 AM-146947';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = '775340-11/30/2018-9:20:06 AM-146947';

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name = '775340-11/30/2018-9:20:06 AM-146947';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = '775340-11/30/2018-9:20:06 AM-146947';
