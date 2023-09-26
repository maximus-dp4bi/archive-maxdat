alter session set current_schema = MAXDAT;
----  NYHIX-57282
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH_Mail-992767-150812-6/5/2020-10:58:19 AM';

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_Mail-992767-150812-6/5/2020-10:58:19 AM';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH_Mail-992767-150812-6/5/2020-10:58:19 AM' ;

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = 'NYSOH_Mail-992767-150812-6/5/2020-10:58:19 AM' ;

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_Mail-992767-150812-6/5/2020-10:58:19 AM';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = 'NYSOH_Mail-992767-150812-6/5/2020-10:58:19 AM';

------------
