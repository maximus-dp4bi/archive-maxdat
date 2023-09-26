alter session set current_schema = MAXDAT;
----  NYHIX-49149
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 2 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('843341-4/25/2019-12:03:48 PM-149078',
'843692-4/25/2019-3:50:18 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-12-42-28-568',
'843504-4/25/2019-2:11:52 PM-146953',
'843756-4/26/2019-8:17:23 AM-146953',
'843760-4/26/2019-8:21:23 AM-146953',
'843768-4/26/2019-8:27:12 AM-146953',
'843772-4/26/2019-8:29:49 AM-146953',
'843926-4/26/2019-11:18:59 AM-89436');
  
update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in  ('843341-4/25/2019-12:03:48 PM-149078',
'843692-4/25/2019-3:50:18 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-12-42-28-568',
'843504-4/25/2019-2:11:52 PM-146953',
'843756-4/26/2019-8:17:23 AM-146953',
'843760-4/26/2019-8:21:23 AM-146953',
'843768-4/26/2019-8:27:12 AM-146953',
'843772-4/26/2019-8:29:49 AM-146953',
'843926-4/26/2019-11:18:59 AM-89436');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('843341-4/25/2019-12:03:48 PM-149078',
'843692-4/25/2019-3:50:18 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-12-42-28-568',
'843504-4/25/2019-2:11:52 PM-146953',
'843756-4/26/2019-8:17:23 AM-146953',
'843760-4/26/2019-8:21:23 AM-146953',
'843768-4/26/2019-8:27:12 AM-146953',
'843772-4/26/2019-8:29:49 AM-146953',
'843926-4/26/2019-11:18:59 AM-89436');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('843341-4/25/2019-12:03:48 PM-149078',
'843692-4/25/2019-3:50:18 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-12-42-28-568',
'843504-4/25/2019-2:11:52 PM-146953',
'843756-4/26/2019-8:17:23 AM-146953',
'843760-4/26/2019-8:21:23 AM-146953',
'843768-4/26/2019-8:27:12 AM-146953',
'843772-4/26/2019-8:29:49 AM-146953',
'843926-4/26/2019-11:18:59 AM-89436');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('843341-4/25/2019-12:03:48 PM-149078',
'843692-4/25/2019-3:50:18 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-12-42-28-568',
'843504-4/25/2019-2:11:52 PM-146953',
'843756-4/26/2019-8:17:23 AM-146953',
'843760-4/26/2019-8:21:23 AM-146953',
'843768-4/26/2019-8:27:12 AM-146953',
'843772-4/26/2019-8:29:49 AM-146953',
'843926-4/26/2019-11:18:59 AM-89436');

----  NYHIX-49149
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/30/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-49149' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('04/30/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('04/30/2019', 'mm/dd/yyyy')
where dcn  in ('18078970',
'18078971',
'18078972',
'18078973',
'18077662',
'18077023',
'18077024',
'18076097',
'18076098',
'18077308',
'18077335',
'18077336',
'18077397',
'18077398',
'18077399',
'18075485',
'18075578');

commit;
