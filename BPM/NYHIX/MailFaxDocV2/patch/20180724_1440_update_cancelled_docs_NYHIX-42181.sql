update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('07/24/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-42181' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('07/24/2018', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('07/24/2018', 'mm/dd/yyyy')
 where dcn in ('17128610','17128611','17128612','17128613','17128614','17128615','17128616');

commit;
