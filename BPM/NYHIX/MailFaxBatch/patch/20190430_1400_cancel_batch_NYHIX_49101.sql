alter session set current_schema = MAXDAT;
----  NYHIX-49101
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 2 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-NavCAC2019-04-23-17-07-30-479',
'NYSOH-FAX-NavCAC2019-04-23-17-49-39-136',
'NYSOH-FAX-NavCAC2019-04-23-17-09-44-836',
'NYSOH-FAX-NavCAC2019-04-23-19-08-36-478',
'842273-4/24/2019-9:22:44 AM-139890',
'842350-4/24/2019-9:56:28 AM-146953',
'842578-4/24/2019-12:58:11 PM-149078',
'NYSOH-FAX-4/23/2019-10:36:45 PM',
'842495-4/24/2019-11:47:03 AM-139890',
'841922-4/23/2019-9:31:01 AM-146953',
'842606-4/24/2019-1:34:17 PM-146953',
'842597-4/24/2019-1:28:26 PM-146953',
'NYSOH-FAX-4/24/2019-12:55:50 PM');
  
update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-23-17-07-30-479',
'NYSOH-FAX-NavCAC2019-04-23-17-49-39-136',
'NYSOH-FAX-NavCAC2019-04-23-17-09-44-836',
'NYSOH-FAX-NavCAC2019-04-23-19-08-36-478',
'842273-4/24/2019-9:22:44 AM-139890',
'842350-4/24/2019-9:56:28 AM-146953',
'842578-4/24/2019-12:58:11 PM-149078',
'NYSOH-FAX-4/23/2019-10:36:45 PM',
'842495-4/24/2019-11:47:03 AM-139890',
'841922-4/23/2019-9:31:01 AM-146953',
'842606-4/24/2019-1:34:17 PM-146953',
'842597-4/24/2019-1:28:26 PM-146953',
'NYSOH-FAX-4/24/2019-12:55:50 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-23-17-07-30-479',
'NYSOH-FAX-NavCAC2019-04-23-17-49-39-136',
'NYSOH-FAX-NavCAC2019-04-23-17-09-44-836',
'NYSOH-FAX-NavCAC2019-04-23-19-08-36-478',
'842273-4/24/2019-9:22:44 AM-139890',
'842350-4/24/2019-9:56:28 AM-146953',
'842578-4/24/2019-12:58:11 PM-149078',
'NYSOH-FAX-4/23/2019-10:36:45 PM',
'842495-4/24/2019-11:47:03 AM-139890',
'841922-4/23/2019-9:31:01 AM-146953',
'842606-4/24/2019-1:34:17 PM-146953',
'842597-4/24/2019-1:28:26 PM-146953',
'NYSOH-FAX-4/24/2019-12:55:50 PM');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-NavCAC2019-04-23-17-07-30-479',
'NYSOH-FAX-NavCAC2019-04-23-17-49-39-136',
'NYSOH-FAX-NavCAC2019-04-23-17-09-44-836',
'NYSOH-FAX-NavCAC2019-04-23-19-08-36-478',
'842273-4/24/2019-9:22:44 AM-139890',
'842350-4/24/2019-9:56:28 AM-146953',
'842578-4/24/2019-12:58:11 PM-149078',
'NYSOH-FAX-4/23/2019-10:36:45 PM',
'842495-4/24/2019-11:47:03 AM-139890',
'841922-4/23/2019-9:31:01 AM-146953',
'842606-4/24/2019-1:34:17 PM-146953',
'842597-4/24/2019-1:28:26 PM-146953',
'NYSOH-FAX-4/24/2019-12:55:50 PM');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-NavCAC2019-04-23-17-07-30-479',
'NYSOH-FAX-NavCAC2019-04-23-17-49-39-136',
'NYSOH-FAX-NavCAC2019-04-23-17-09-44-836',
'NYSOH-FAX-NavCAC2019-04-23-19-08-36-478',
'842273-4/24/2019-9:22:44 AM-139890',
'842350-4/24/2019-9:56:28 AM-146953',
'842578-4/24/2019-12:58:11 PM-149078',
'NYSOH-FAX-4/23/2019-10:36:45 PM',
'842495-4/24/2019-11:47:03 AM-139890',
'841922-4/23/2019-9:31:01 AM-146953',
'842606-4/24/2019-1:34:17 PM-146953',
'842597-4/24/2019-1:28:26 PM-146953',
'NYSOH-FAX-4/24/2019-12:55:50 PM');

----  NYHIX-49101
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/30/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-49101' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('04/30/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('04/30/2019', 'mm/dd/yyyy')
where dcn  in ('18064222',
'18068529',
'18068530',
'18067126',
'18067131',
'18068531',
'18068532',
'18068533',
'18068534',
'18068535',
'18067369',
'18067405',
'18067022',
'18070202',
'18070661',
'18070662',
'18069991',
'18070239',
'18070240',
'18070657',
'18070658',
'18070659',
'18070660',
'18069710',
'18069711',
'18070372',
'18070373',
'18070374');

commit;
