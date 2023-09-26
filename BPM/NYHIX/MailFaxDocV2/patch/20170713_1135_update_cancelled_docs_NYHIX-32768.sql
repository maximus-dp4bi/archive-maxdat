--- NYHIX-32768

alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('07/13/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-32768' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('07/13/2017', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('07/13/2017', 'mm/dd/yyyy') 
where dcn in 
('15616124',
'15616608',
'15620279',
'15620289',
'15621267',
'15622519',
'15622551',
'15622911',
'15623131');

commit;
