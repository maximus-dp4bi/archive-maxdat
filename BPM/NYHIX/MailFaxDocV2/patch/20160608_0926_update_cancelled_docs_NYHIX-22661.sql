update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('06/08/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-22661' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('06/08/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('06/08/2016', 'mm/dd/yyyy') 
where dcn in  ('13316285', '13316286');

commit;
