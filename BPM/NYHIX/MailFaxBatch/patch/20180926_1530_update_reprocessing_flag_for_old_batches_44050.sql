alter session set current_schema = MAXDAT;
----  NYHIX-44019
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-9/19/2018-5:58:25 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-9/19/2018-5:58:25 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-9/19/2018-5:58:25 PM');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-9/19/2018-5:58:25 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-9/19/2018-5:58:25 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-9/19/2018-5:58:25 PM');
