update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('10/21/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-26205' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('10/21/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('10/21/2016', 'mm/dd/yyyy') 
where dcn in 
('13929187'
);

commit;
