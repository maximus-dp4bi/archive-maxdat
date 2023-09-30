update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('11/16/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-34392' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('11/16/2017', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('11/16/2017', 'mm/dd/yyyy') 
where dcn in  ('16155633');
commit;