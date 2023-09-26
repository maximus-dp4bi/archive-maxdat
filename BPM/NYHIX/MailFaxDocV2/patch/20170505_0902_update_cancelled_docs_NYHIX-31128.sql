alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('05/05/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX - 31128' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('05/05/2017', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('05/05/2017', 'mm/dd/yyyy') 
where dcn in 
('11579614',
'14493817',
'14493866',
'14493867',
'14493868',
'14493890',
'14810861',
'14810993',
'14814352',
'14965744');

commit;
