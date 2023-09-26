update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('09/23/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-25406' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('09/23/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('09/23/2016', 'mm/dd/yyyy') 
where dcn in 
('13834052',
'13834053',
'13834054',
'13834055',
'13834056',
'13834057',
'13834058',
'13834059',
'13834060',
'13834211',
'13834212',
'13834213',
'13834214',
'13834215',
'13834216',
'13834217',
'13834218'
);


commit;
