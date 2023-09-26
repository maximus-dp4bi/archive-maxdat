--  NYHIX-30765 
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('13-APR-2017 08:00:29','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('13-APR-2017 08:00:29','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('13-APR-2017 08:00:29','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A1705996D7001',
'A17060A1F7001',
'A17060A3F7001',
'A17080FD17001',
'A17061ADDE001',
'A1706760C3001',
'A17080FCBB001',
'A17060A625001');

 
commit;

