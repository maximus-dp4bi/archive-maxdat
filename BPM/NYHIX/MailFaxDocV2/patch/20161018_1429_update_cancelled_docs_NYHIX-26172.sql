update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('10/18/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-26172' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('10/18/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('10/18/2016', 'mm/dd/yyyy') 
where dcn in 
('13918031',
'13918033',
'13918035',
'13918055',
'13918056',
'13918406',
'13917803',
'13917804',
'13917806',
'13918407',
'13918408',
'13917559',
'13917561',
'13918032',
'13918034',
'13917558',
'13918054',
'13917805',
'13917560'
);



update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('10/18/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-25990' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('10/18/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('10/18/2016', 'mm/dd/yyyy') 
where dcn in 
('13877706',
'13877707',
'13877708',
'13877709'
);

commit;
