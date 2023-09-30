-- NYHIX-50835
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = 'NYSOH_MAIL-867782-6/28/2019-11:58:57 PM-84552';

update CORP_ETL_MFB_BATCH  -- 1 record
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_MAIL-867782-6/28/2019-11:58:57 PM-84552';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = 'NYSOH_MAIL-867782-6/28/2019-11:58:57 PM-84552';

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = 'NYSOH_MAIL-867782-6/28/2019-11:58:57 PM-84552';

update corp_etl_mfb_batch_stg  -- 2 records
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_MAIL-867782-6/28/2019-11:58:57 PM-84552';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg  -- 1 record
where batch_name = 'NYSOH_MAIL-867782-6/28/2019-11:58:57 PM-84552';
