update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('06/05/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-41050' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('06/05/2018', 'mm/dd/yyyy'),
 STG_DONE_DATE = to_date('06/05/2018', 'mm/dd/yyyy') 
 where dcn = '17002176';

commit;
