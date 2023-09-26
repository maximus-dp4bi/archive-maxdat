--  NYHIX-30393
---  
alter session set current_schema = MAXDAT;
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('02-APR-2017 13:20:45','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('02-APR-2017 13:20:45','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('02-APR-2017 13:20:45','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A170591B0F001',
 'A1706544B1001');
commit; 

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('28-MAR-2017 08:00:22','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('28-MAR-2017 08:00:22','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('28-MAR-2017 08:00:22','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A170442D61001',
 'A1704863FA001');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('29-MAR-2017 08:04:31','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('29-MAR-2017 08:04:31','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('29-MAR-2017 08:04:31','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('A1705999D3001',
'A170602DE0001',
'A170609B5C001',
'A170609C37001',
'A17060A12F001',
'A17060ACB8001',
'A1706137EC001',
'A17065445D001',
'A17065B16F001');
commit;
