alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('05/01/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX - 30940' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('05/01/2017', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('05/01/2017', 'mm/dd/yyyy') 
where dcn in 
('15099672',
'15099673',
'15099675',
'15099678',
'15099681',
'15099682',
'15099683',
'15099684',
'15099686',
'15099688',
'15099689',
'15099691',
'15099694',
'15099674',
'15099676',
'15099677',
'15099690',
'15099692',
'15099693',
'15099695',
'15099679',
'15099680',
'15099685',
'15099687',
'15099696');

commit;
