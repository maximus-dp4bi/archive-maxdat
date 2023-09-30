alter session set current_schema = MAXDAT;
----  NYHIX-49179
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 2 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-NavCAC2019-04-26-17-08-25-949',
'844445-4/26/2019-5:01:14 PM-142749',
'844050-4/26/2019-12:27:39 PM-140860',
'843986-4/26/2019-11:46:34 AM-149078');
  
update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-26-17-08-25-949',
'844445-4/26/2019-5:01:14 PM-142749',
'844050-4/26/2019-12:27:39 PM-140860',
'843986-4/26/2019-11:46:34 AM-149078');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-26-17-08-25-949',
'844445-4/26/2019-5:01:14 PM-142749',
'844050-4/26/2019-12:27:39 PM-140860',
'843986-4/26/2019-11:46:34 AM-149078');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-26-17-08-25-949',
'844445-4/26/2019-5:01:14 PM-142749',
'844050-4/26/2019-12:27:39 PM-140860',
'843986-4/26/2019-11:46:34 AM-149078');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-NavCAC2019-04-26-17-08-25-949',
'844445-4/26/2019-5:01:14 PM-142749',
'844050-4/26/2019-12:27:39 PM-140860',
'843986-4/26/2019-11:46:34 AM-149078');

----  NYHIX-49179
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('05/01/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-49179' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('05/01/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('05/01/2019', 'mm/dd/yyyy')
where dcn  in ('18082158',
'18082357',
'18080121',
'18080122',
'18080123',
'18080029',
'18080030');

commit;

