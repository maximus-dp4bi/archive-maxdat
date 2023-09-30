-- NYHIX-46141
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = '779779-12/10/2018-3:44:33 PM-89436';

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name = '779779-12/10/2018-3:44:33 PM-89436';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = '779779-12/10/2018-3:44:33 PM-89436';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = '779779-12/10/2018-3:44:33 PM-89436';

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name = '779779-12/10/2018-3:44:33 PM-89436';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name = '779779-12/10/2018-3:44:33 PM-89436';
