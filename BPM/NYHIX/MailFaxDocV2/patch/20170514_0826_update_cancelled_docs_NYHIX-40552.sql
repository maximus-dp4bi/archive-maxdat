alter session set current_schema = MAXDAT;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('05/14/2018', 'mm/dd/yyyy') 
,CANCEL_BY = ' NYHIX-40552' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('05/14/2018', 'mm/dd/yyyy')
,STG_DONE_DATE = to_date('05/14/2018', 'mm/dd/yyyy') 
where dcn in 
('16941203',
'16943015',
'16941204',
'16941205',
'16943016',
'16943017');
commit;
