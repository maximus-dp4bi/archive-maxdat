-- NYHIX-45705
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = '772672-11/26/2018-11:24:46 AM-139890';

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name = '772672-11/26/2018-11:24:46 AM-139890';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = '772672-11/26/2018-11:24:46 AM-139890';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = '772672-11/26/2018-11:24:46 AM-139890';

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name = '772672-11/26/2018-11:24:46 AM-139890';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = '772672-11/26/2018-11:24:46 AM-139890';
