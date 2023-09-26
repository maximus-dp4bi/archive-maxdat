update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('03/02/2018', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-38657' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('03/02/2018', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('03/02/2018', 'mm/dd/yyyy') 
where dcn in  ('16703475','16703476','16703477','16703478',
'16703479','16703480','16703481','16703482','16703483','16703484');
commit;