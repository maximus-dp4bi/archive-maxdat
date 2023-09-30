-- NYHIX-45576
alter session set current_schema = MAXDAT;

select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('768846-11/14/2018-1:05:23 PM-89436','NYSOH-FAX-11/14/2018-10:35:25 AM');

update CORP_ETL_MFB_BATCH
set reprocessed_flag = 'Y'
where batch_name IN ('768846-11/14/2018-1:05:23 PM-89436','NYSOH-FAX-11/14/2018-10:35:25 AM');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH
where batch_name IN ('768846-11/14/2018-1:05:23 PM-89436','NYSOH-FAX-11/14/2018-10:35:25 AM');

------------
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('768846-11/14/2018-1:05:23 PM-89436','NYSOH-FAX-11/14/2018-10:35:25 AM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name IN ('768846-11/14/2018-1:05:23 PM-89436','NYSOH-FAX-11/14/2018-10:35:25 AM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_name IN ('768846-11/14/2018-1:05:23 PM-89436','NYSOH-FAX-11/14/2018-10:35:25 AM');
