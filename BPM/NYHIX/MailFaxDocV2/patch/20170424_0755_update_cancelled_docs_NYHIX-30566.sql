alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/24/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX - 30566' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('04/24/2017', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('04/24/2017', 'mm/dd/yyyy') 
where dcn in 
('14960964',
'14960965',
'14960966',
'14974713',
'14974731',
'14995855',
'14995856',
'14995857',
'14995858',
'14995859');

commit;
