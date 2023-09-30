alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/17/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX - 30418' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('04/17/2017', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('04/17/2017', 'mm/dd/yyyy') 
where dcn in 
('14911937',
'14911938',
'14918280',
'14941932',
'14941933',
'14941934',
'14941935');

commit;
