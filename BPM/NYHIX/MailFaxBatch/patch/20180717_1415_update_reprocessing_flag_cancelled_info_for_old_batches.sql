alter session set current_schema = MAXDAT;
----  NYHIX-42134
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from D_MFB_CURRENT
where batch_name in ('718508-7/10/2018-8:55:08 AM-139890')

update D_MFB_CURRENT
set reprocessed_flag = 'Y'
where batch_name in ('718508-7/10/2018-8:55:08 AM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from D_MFB_CURRENT
where batch_name in ('718508-7/10/2018-8:55:08 AM-139890');


select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('718508-7/10/2018-8:55:08 AM-139890')

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('718508-7/10/2018-8:55:08 AM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('718508-7/10/2018-8:55:08 AM-139890');
