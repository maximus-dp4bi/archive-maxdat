alter session set current_schema = MAXDAT;
----  NYHIX-47826



update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('03/12/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-47826' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('03/12/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('03/12/2019', 'mm/dd/yyyy')
where dcn = '17853072';



