--- NYHIX-32886

alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('07/19/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-32886' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('07/19/2017', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('07/19/2017', 'mm/dd/yyyy') 
where dcn in 
('15640957',
'15640958',
'15640959',
'15640960',
'15640961',
'15640962',
'15640963',
'15640964',
'15640965',
'15640966',
'15640967');

commit;
