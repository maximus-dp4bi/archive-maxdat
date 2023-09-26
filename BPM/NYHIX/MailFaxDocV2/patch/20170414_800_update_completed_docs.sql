--  NYHIX-30722
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('11-APR-2017 08:16:09','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('11-APR-2017 08:16:09','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('11-APR-2017 08:16:09','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O1709738AE005',
'O1709738E3005',
'O1709738D0008');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('12-APR-2017 08:00:21','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('12-APR-2017 08:00:21','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('12-APR-2017 08:00:21','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A170664E65001',
 'A170664E8C001');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('12-APR-2017 08:00:22','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('12-APR-2017 08:00:22','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('12-APR-2017 08:00:22','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A17076F08C001',
'A170799BCF001',
'A17079F0B1001',
'O170918006585',
'A170769531001',
'O1709305FE001',
'O17093FC72001',
'A170665D71001',
'A170665D28001',
'O1709301BE001');
 
commit;

