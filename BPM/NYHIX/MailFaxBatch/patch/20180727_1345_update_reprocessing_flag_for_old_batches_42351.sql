alter session set current_schema = MAXDAT;
----  NYHIX-42351
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('722586-7/20/2018-12:51:09 PM-149459','722739-7/20/2018-3:50:18 PM-89436');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('722586-7/20/2018-12:51:09 PM-149459','722739-7/20/2018-3:50:18 PM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('722586-7/20/2018-12:51:09 PM-149459','722739-7/20/2018-3:50:18 PM-89436');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  -- 2 records
from corp_etl_mfb_batch
where batch_name in ('722586-7/20/2018-12:51:09 PM-149459','722739-7/20/2018-3:50:18 PM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('722586-7/20/2018-12:51:09 PM-149459','722739-7/20/2018-3:50:18 PM-89436');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('722586-7/20/2018-12:51:09 PM-149459','722739-7/20/2018-3:50:18 PM-89436');
