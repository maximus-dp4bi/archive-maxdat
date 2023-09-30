--  NYHIX-30868
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('20-APR-2017 08:15:13','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('20-APR-2017 08:15:13','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('20-APR-2017 08:15:13','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A170810B37001',
'A170810B52001',
'A1708117AD001',
'A1708228DF001',
'A17087C606001'); 
commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('19-APR-2017 08:00:21','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('19-APR-2017 08:00:21','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('19-APR-2017 08:00:21','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O1709306F2001',
'O170962AEC001',
'O170988001562',
'O170988003530',
'O171003C26001',
'O171003C35001',
'O171003C3E001',
'O171003C46001',
'O171003C48001'); 
commit;