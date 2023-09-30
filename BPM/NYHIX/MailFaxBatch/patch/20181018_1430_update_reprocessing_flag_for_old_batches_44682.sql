-- NYHIX-44682
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = ('755852-10/15/2018-4:10:07 PM-139890');

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name = ('755852-10/15/2018-4:10:07 PM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = ('755852-10/15/2018-4:10:07 PM-139890');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = ('755852-10/15/2018-4:10:07 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name = ('755852-10/15/2018-4:10:07 PM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = ('755852-10/15/2018-4:10:07 PM-139890');
