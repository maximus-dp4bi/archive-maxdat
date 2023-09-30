alter session set current_schema = MAXDAT;

----  NYHIX-49035
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/26/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-49035' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('04/26/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('04/26/2019', 'mm/dd/yyyy')
where dcn  in ( '18058071',
'18058072',
'18058073',
'18058074',
'18058075','18056052'
)

commit;

