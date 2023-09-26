alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('05/01/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX - 30750' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('05/01/2017', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('05/01/2017', 'mm/dd/yyyy') 
where dcn in 
('15036190',
 '15036191',
 '15036192',
 '15036193');

commit;
