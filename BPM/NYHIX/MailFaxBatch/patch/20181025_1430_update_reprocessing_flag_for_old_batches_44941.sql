-- NYHIX-44941
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = ('759573-10/23/2018-12:20:12 PM-149078');

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name = ('759573-10/23/2018-12:20:12 PM-149078');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = ('759573-10/23/2018-12:20:12 PM-149078');

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = ('759573-10/23/2018-12:20:12 PM-149078');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name = ('759573-10/23/2018-12:20:12 PM-149078');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = ('759573-10/23/2018-12:20:12 PM-149078');
