alter session set current_schema = MAXDAT;
----  NYHIX-42876, NYHIX-42775, NYHIX-42840 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-HRA2018-08-09-12-01-27-413',
                     '731047-8/10/2018-11:55:51 AM-146953',
					 '730900-8/9/2018-6:37:47 PM-140860',
                     '729859-8/8/2018-9:44:09 AM-139890');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2018-08-09-12-01-27-413',
                     '731047-8/10/2018-11:55:51 AM-146953',
					 '730900-8/9/2018-6:37:47 PM-140860',
                     '729859-8/8/2018-9:44:09 AM-139890');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-HRA2018-08-09-12-01-27-413',
                     '731047-8/10/2018-11:55:51 AM-146953',
					 '730900-8/9/2018-6:37:47 PM-140860',
                     '729859-8/8/2018-9:44:09 AM-139890');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-HRA2018-08-09-12-01-27-413',
                     '731047-8/10/2018-11:55:51 AM-146953',
					 '730900-8/9/2018-6:37:47 PM-140860',
                     '729859-8/8/2018-9:44:09 AM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-HRA2018-08-09-12-01-27-413',
                     '731047-8/10/2018-11:55:51 AM-146953',
					 '730900-8/9/2018-6:37:47 PM-140860',
                     '729859-8/8/2018-9:44:09 AM-139890');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2018-08-09-12-01-27-413',
                     '731047-8/10/2018-11:55:51 AM-146953',
					 '730900-8/9/2018-6:37:47 PM-140860',
                     '729859-8/8/2018-9:44:09 AM-139890');
