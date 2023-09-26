alter session set current_schema = MAXDAT;





update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/17/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-48816' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('04/17/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('04/17/2019', 'mm/dd/yyyy')
where dcn  in ( '18024144',
'18024229',
'18024230',
'18024231',
'18025899',
'18025900',
'18025901',
'18026597',
'18026694',
'18026695');

commit;



