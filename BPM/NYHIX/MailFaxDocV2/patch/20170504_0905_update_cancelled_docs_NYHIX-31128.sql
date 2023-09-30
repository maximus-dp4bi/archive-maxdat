alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('05/02/2017', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX - 31128' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('05/02/2017', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('05/02/2017', 'mm/dd/yyyy') 
where dcn in 
('11499623',
'11340365',
'11581095',
'11601676',
'11677388',
'11832098',
'11881939',
'11968034',
'12064329',
'12064507',
'12357007',
'12423215',
'12457890',
'12537989',
'12563117',
'12533589',
'12638299',
'12638301',
'12641895',
'12652017',
'12657182',
'12689334',
'12753443',
'13526046',
'13572866',
'13666290',
'13759767',
'13759783',
'13759798',
'13770325',
'13770348',
'13770623',
'13783498',
'13794980',
'13794889',
'14590394',
'14960963',
'14963860',
'14974712',
'14974730',
'14995854',
'15036190',
'15104577',
'15099672',
'15138302',
'11430989',
'11620505');
commit;