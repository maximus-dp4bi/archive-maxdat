update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/03/2018', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-39591' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('04/03/2018', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('04/03/2018', 'mm/dd/yyyy') 
where dcn in  ('16816199','16816200','16816201','16819305');
commit;