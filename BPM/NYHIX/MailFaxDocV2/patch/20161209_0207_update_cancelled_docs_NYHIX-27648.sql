update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('12/09/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-27648' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('12/09/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('12/09/2016', 'mm/dd/yyyy') 
where dcn in 
('14150689','14150691','14150692', '14150687','14150688','14150690','14150693','14150694');

commit;
