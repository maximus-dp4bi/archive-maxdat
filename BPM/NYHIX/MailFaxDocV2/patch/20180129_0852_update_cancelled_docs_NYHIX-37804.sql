update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('01/29/2018', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-37804' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('01/29/2018', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('01/29/2018', 'mm/dd/yyyy') 
where dcn in  
('16574524',
'16574525',
'16574526',
'16574527',
'16574528',
'16574529',
'16574530',
'16574531');
commit;