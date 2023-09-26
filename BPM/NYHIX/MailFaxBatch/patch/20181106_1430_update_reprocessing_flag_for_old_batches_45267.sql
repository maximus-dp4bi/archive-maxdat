-- NYHIX-45267
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag  -- 1 record
from CORP_ETL_MFB_BATCH
where batch_name = '763770-11/1/2018-3:51:08 PM-139890';

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name = '763770-11/1/2018-3:51:08 PM-139890';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag  -- 1 record
from CORP_ETL_MFB_BATCH
where batch_name = '763770-11/1/2018-3:51:08 PM-139890';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag  -- 1 record
from corp_etl_mfb_batch_stg
where batch_name = '763770-11/1/2018-3:51:08 PM-139890';

update corp_etl_mfb_batch_stg  -- 1 record
set reprocessed_flag = 'Y'
where batch_name = '763770-11/1/2018-3:51:08 PM-139890';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag  -- 1 record
from corp_etl_mfb_batch_stg
where batch_name = '763770-11/1/2018-3:51:08 PM-139890';
