------NYHIX-40917
-----
update NYHIX_ETL_MAIL_FAX_DOC_V2
 set CANCEL_DT  = to_date('05/24/2018', 'mm/dd/yyyy') ,
 CANCEL_BY = 'NYHIX-40917' ,
 ASF_CANCEL_DOC = 'Y' ,
 CANCEL_REASON = 'Inactivated' ,
 CANCEL_METHOD = 'Exception' ,
 INSTANCE_STATUS = 'Complete' ,
 INSTANCE_END_DATE = to_date('05/24/2018', 'mm/dd/yyyy') 
 where dcn = '16983293';


commit;


