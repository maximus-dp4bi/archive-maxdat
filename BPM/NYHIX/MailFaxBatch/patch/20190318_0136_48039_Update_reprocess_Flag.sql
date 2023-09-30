alter session set current_schema = MAXDAT;
----  NYHIX-48039/48119/48064
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 8 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('819977-3/7/2019-10:54:50 AM-139890','821432-3/11/2019-10:59:57 AM-139890','822532-3/12/2019-2:14:45 PM-150802');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('819977-3/7/2019-10:54:50 AM-139890','821432-3/11/2019-10:59:57 AM-139890','822532-3/12/2019-2:14:45 PM-150802');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('819977-3/7/2019-10:54:50 AM-139890','821432-3/11/2019-10:59:57 AM-139890','822532-3/12/2019-2:14:45 PM-150802');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 3 records
from corp_etl_mfb_batch
where batch_name in  ('819977-3/7/2019-10:54:50 AM-139890','821432-3/11/2019-10:59:57 AM-139890','822532-3/12/2019-2:14:45 PM-150802');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('819977-3/7/2019-10:54:50 AM-139890','821432-3/11/2019-10:59:57 AM-139890','822532-3/12/2019-2:14:45 PM-150802');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('819977-3/7/2019-10:54:50 AM-139890','821432-3/11/2019-10:59:57 AM-139890','822532-3/12/2019-2:14:45 PM-150802');



