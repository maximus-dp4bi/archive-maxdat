update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('12/19/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-36857' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('12/19/2017', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('12/19/2017', 'mm/dd/yyyy') 
where dcn in  ('16455485',
'16455486',
'16455487',
'16455488',
'16455489',
'16455490',
'16455491',
'16455492',
'16455493',
'16455494',
'16455495');
commit;