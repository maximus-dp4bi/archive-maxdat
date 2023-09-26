alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('09/18/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-43867' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('09/18/2018', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('09/18/2018', 'mm/dd/yyyy')
 where dcn in ( '17341786','17341787','17341788','17341789');

commit;















