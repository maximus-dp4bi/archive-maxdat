--  NYHIX-29498 
---
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('03/08/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-29498' 
,ASF_PROCESS_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('03/08/2017', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('03/08/2017', 'mm/dd/yyyy') 
where dcn in (
'14666424',
'14666425',
'14671347',
'14671348'
);

commit;
