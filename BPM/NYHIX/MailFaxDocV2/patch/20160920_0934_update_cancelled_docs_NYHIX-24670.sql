update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('09/19/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-24670' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('09/19/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('09/19/2016', 'mm/dd/yyyy') 
where dcn in 
('13759768',
'13759784',
'13759799'
);

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('09/19/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-24764' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('09/19/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('09/19/2016', 'mm/dd/yyyy') 
where dcn in
('13770326',
'13770327',
'13770328',
'13770349',
'13770350',
'13770351',
'13770352',
'13770353',
'13770354',
'13770355',
'13770356',
'13770357',
'13770358',
'13770359',
'13770624',
'13770625',
'13770626',
'13770627'
);

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('09/19/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-24831' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('09/19/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('09/19/2016', 'mm/dd/yyyy') 
where dcn in
('13783499',
'13783500',
'13783501',
'13783502',
'13783503',
'13783504',
'13783505',
'13783506',
'13783507',
'13783508',
'13783509',
'13783510'
);

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('09/19/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-24973' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('09/19/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('09/19/2016', 'mm/dd/yyyy') 
where dcn in
('13794890',
'13794891',
'13794892',
'13794893',
'13794894',
'13794981',
'13794982',
'13794983'
);

commit;
