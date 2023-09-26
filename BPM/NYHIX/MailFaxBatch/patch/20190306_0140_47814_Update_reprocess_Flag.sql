alter session set current_schema = MAXDAT;
----  NYHIX-47814/47740/47826
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 7 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-2/22/2019-11:56:03 AM','NYSOH-FAX-2/20/2019-8:29:59 AM','812576-2/20/2019-2:07:05 PM-89436');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-2/22/2019-11:56:03 AM','NYSOH-FAX-2/20/2019-8:29:59 AM','812576-2/20/2019-2:07:05 PM-89436');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-2/22/2019-11:56:03 AM','NYSOH-FAX-2/20/2019-8:29:59 AM','812576-2/20/2019-2:07:05 PM-89436');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 4 records
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-2/22/2019-11:56:03 AM','NYSOH-FAX-2/20/2019-8:29:59 AM','812576-2/20/2019-2:07:05 PM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-2/22/2019-11:56:03 AM','NYSOH-FAX-2/20/2019-8:29:59 AM','812576-2/20/2019-2:07:05 PM-89436');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-2/22/2019-11:56:03 AM','NYSOH-FAX-2/20/2019-8:29:59 AM','812576-2/20/2019-2:07:05 PM-89436');



