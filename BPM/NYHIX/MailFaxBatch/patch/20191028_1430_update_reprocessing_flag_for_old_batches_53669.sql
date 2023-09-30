alter session set current_schema = MAXDAT;
----  NYHIX-53669
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name IN( 'NYSOH_FAX-10/25/2019-9:23:55 PM','NYSOH_Mail-909261-84552-10/25/2019-9:23:36 PM','NYSOH_Mail-909268-84552-10/25/2019-9:51:38 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name IN( 'NYSOH_FAX-10/25/2019-9:23:55 PM','NYSOH_Mail-909261-84552-10/25/2019-9:23:36 PM','NYSOH_Mail-909268-84552-10/25/2019-9:51:38 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name IN( 'NYSOH_FAX-10/25/2019-9:23:55 PM','NYSOH_Mail-909261-84552-10/25/2019-9:23:36 PM','NYSOH_Mail-909268-84552-10/25/2019-9:51:38 PM');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name IN( 'NYSOH_FAX-10/25/2019-9:23:55 PM','NYSOH_Mail-909261-84552-10/25/2019-9:23:36 PM','NYSOH_Mail-909268-84552-10/25/2019-9:51:38 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name IN( 'NYSOH_FAX-10/25/2019-9:23:55 PM','NYSOH_Mail-909261-84552-10/25/2019-9:23:36 PM','NYSOH_Mail-909268-84552-10/25/2019-9:51:38 PM');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name IN( 'NYSOH_FAX-10/25/2019-9:23:55 PM','NYSOH_Mail-909261-84552-10/25/2019-9:23:36 PM','NYSOH_Mail-909268-84552-10/25/2019-9:51:38 PM');
