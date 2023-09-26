--  NYHIX-30544
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('06-APR-2017 08:01:26','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('06-APR-2017 08:01:26','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('06-APR-2017 08:01:26','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A17067C762001',
'O17087C6B6001',
'O17087C9CC001',
'O17087C9B1001',
'O17087C834001',
'O17087C80C001',
'O17087C76C001',
'O17087C592001',
'O17087C513001',
'A17069D3F1001',
'A17069D3D1001',
'A17068C978001');

commit;