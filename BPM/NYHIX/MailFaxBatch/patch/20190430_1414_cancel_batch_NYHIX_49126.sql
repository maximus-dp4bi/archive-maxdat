alter session set current_schema = MAXDAT;
----  NYHIX-49126
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 2 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('842398-4/24/2019-10:29:01 AM-150802',
'842604-4/24/2019-1:33:42 PM-142749',
'NYSOH-FAX-NavCAC2019-04-24-15-08-53-389',
'842895-4/24/2019-4:28:28 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-11-20-27-114',
'843307-4/25/2019-11:47:22 AM-142749');
  
update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in  ('842398-4/24/2019-10:29:01 AM-150802',
'842604-4/24/2019-1:33:42 PM-142749',
'NYSOH-FAX-NavCAC2019-04-24-15-08-53-389',
'842895-4/24/2019-4:28:28 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-11-20-27-114',
'843307-4/25/2019-11:47:22 AM-142749');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('842398-4/24/2019-10:29:01 AM-150802',
'842604-4/24/2019-1:33:42 PM-142749',
'NYSOH-FAX-NavCAC2019-04-24-15-08-53-389',
'842895-4/24/2019-4:28:28 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-11-20-27-114',
'843307-4/25/2019-11:47:22 AM-142749');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('842398-4/24/2019-10:29:01 AM-150802',
'842604-4/24/2019-1:33:42 PM-142749',
'NYSOH-FAX-NavCAC2019-04-24-15-08-53-389',
'842895-4/24/2019-4:28:28 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-11-20-27-114',
'843307-4/25/2019-11:47:22 AM-142749');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('842398-4/24/2019-10:29:01 AM-150802',
'842604-4/24/2019-1:33:42 PM-142749',
'NYSOH-FAX-NavCAC2019-04-24-15-08-53-389',
'842895-4/24/2019-4:28:28 PM-142749',
'NYSOH-FAX-NavCAC2019-04-25-11-20-27-114',
'843307-4/25/2019-11:47:22 AM-142749');

----  NYHIX-49126
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/30/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-49126' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('04/30/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('04/30/2019', 'mm/dd/yyyy')
where dcn  in ('18071400',
'18071401',
'18071402',
'18074216',
'18071285',
'18071286',
'18074506',
'18071771',
'18072249',
'18072250',
'18072251',
'18072252',
'18071892');

commit;

