alter session set current_schema = MAXDAT;
----  NYHIX-47519/47521



update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('02/21/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-47521' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('02/21/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('02/21/2019', 'mm/dd/yyyy')
where dcn = '17802454';


update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('02/21/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-47519',
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('02/21/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('02/21/2019', 'mm/dd/yyyy')
where dcn  in ('17810925',
'17810926',
'17810927',
'17810928',
'17810929',
'17810930',
'17810931',
'17810932',
'17810933',
'17810934',
'17810935',
'17810936'
);'
';

commit;
