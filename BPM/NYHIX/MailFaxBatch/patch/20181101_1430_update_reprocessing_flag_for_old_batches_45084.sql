-- NYHIX-45084
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('760972-10/26/2018-8:44:19 AM-139890','NYSOH-FAX-10/26/2018-12:29:28 PM');

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name IN ('760972-10/26/2018-8:44:19 AM-139890','NYSOH-FAX-10/26/2018-12:29:28 PM');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('760972-10/26/2018-8:44:19 AM-139890','NYSOH-FAX-10/26/2018-12:29:28 PM');

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('760972-10/26/2018-8:44:19 AM-139890','NYSOH-FAX-10/26/2018-12:29:28 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name IN ('760972-10/26/2018-8:44:19 AM-139890','NYSOH-FAX-10/26/2018-12:29:28 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('760972-10/26/2018-8:44:19 AM-139890','NYSOH-FAX-10/26/2018-12:29:28 PM');
