--  NYHIX-31105
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('27-APR-2017 08:15:26','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('27-APR-2017 08:15:26','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('27-APR-2017 08:15:26','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A1708117FA001');
commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('28-APR-2017 08:00:23','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('28-APR-2017 08:00:23','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('28-APR-2017 08:00:23','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A17086BE51001',
'A17089E692001',
'A17089E692001',
'A17089E64F001',
'A17089E64F001',
'A17089E594001',
'A17089E594001',
'A17086BE51001'); 
commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('30-APR-2017 13:02:10','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('30-APR-2017 13:02:10','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('30-APR-2017 13:02:10','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O171098617001',
'O171098611001',
'O171098609001',
'O171098589001',
'O171098542001',
'O17104664A001',
'A17089E950001',
'O171098628001'); 
commit;