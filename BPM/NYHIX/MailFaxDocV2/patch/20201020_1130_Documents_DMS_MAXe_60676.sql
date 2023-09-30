alter session set current_schema = MAXDAT;
----  NYHIX-60676
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH_Mail-1532036-262733-10/8/2020-1:08:43 AM');


update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'
where batch_name in ('NYSOH_Mail-1532036-262733-10/8/2020-1:08:43 AM');
commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG 
where batch_name in ('NYSOH_Mail-1532036-262733-10/8/2020-1:08:43 AM');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch 
where batch_name in ('NYSOH_Mail-1532036-262733-10/8/2020-1:08:43 AM');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH_Mail-1532036-262733-10/8/2020-1:08:43 AM');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch 
where batch_name in ('NYSOH_Mail-1532036-262733-10/8/2020-1:08:43 AM');
------------