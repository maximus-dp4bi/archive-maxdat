-- NYHIX-44606
-- Part 2
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = ('753036-10/10/2018-10:39:10 AM-146953');

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name = ('753036-10/10/2018-10:39:10 AM-146953');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name = ('753036-10/10/2018-10:39:10 AM-146953');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = ('753886-10/11/2018-11:56:37 AM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name = ('753886-10/11/2018-11:56:37 AM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name = ('753886-10/11/2018-11:56:37 AM-89436');
