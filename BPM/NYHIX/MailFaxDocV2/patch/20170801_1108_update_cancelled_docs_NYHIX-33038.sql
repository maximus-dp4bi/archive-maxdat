update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('08/01/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-33038' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('08/01/2017', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('08/01/2017', 'mm/dd/yyyy') 
where dcn = '15699279';

commit;
 