update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('01/24/2018', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-37664' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('01/24/2018', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('01/24/2018', 'mm/dd/yyyy') 
where dcn in  ('16566984',
'16566985',
'16566986',
'16566987',
'16566988',
'16566989',
'16566990',
'16566991',
'16566992',
'16566993',
'16566994',
'16566995',
'16566996',
'16566997');
commit;