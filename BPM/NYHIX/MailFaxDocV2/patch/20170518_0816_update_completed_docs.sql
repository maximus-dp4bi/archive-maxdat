--  NYHIX-31475
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('16-MAY-2017 08:33:12','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('16-MAY-2017 08:33:12','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('16-MAY-2017 08:33:12','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A17089EFE3001',
'A17090F8E2001');

commit;

