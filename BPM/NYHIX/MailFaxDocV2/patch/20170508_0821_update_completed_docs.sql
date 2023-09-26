--  NYHIX-31222
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('04-MAY-2017 08:15:29','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('04-MAY-2017 08:15:29','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('04-MAY-2017 08:15:29','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O17118DD07007',
 'O17118DD07005',
 'O17118DD01009',
 'O17118DD00005',
 'O17118DD0F001',
 'O17118DD0A002');
commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('05-MAY-2017 07:45:43','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('05-MAY-2017 07:45:43','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('05-MAY-2017 07:45:43','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O17121E712002',
'O17121E715008',
'O17121E716007',
'O17121E71A008',
'O17121E70E010',
'O17121E70E008',
'O17121E707009',
'O17121E720007',
'O17121E6FA005',
'O17121E6E1001',
'O17121E703005');