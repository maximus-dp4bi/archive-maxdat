--  NYHIX-31758
---  
alter session set current_schema = MAXDAT;
alter session set NLS_DATE_FORMAT='dd-MON-yyyy hh24:mi:ss';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('10-NOV-2015 23:46:01','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('10-NOV-2015 23:46:01','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('10-NOV-2015 23:46:01','dd-MON-yyyy hh24:mi:ss')
where dcn in 
('11736799',
'11736800',
'11736801');
commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('25-DEC-2013 08:06:08','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('25-DEC-2013 08:06:08','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('25-DEC-2013 08:06:08','dd-MON-yyyy hh24:mi:ss')
where dcn in 
('10011251');
commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('11-DEC-2013 15:21:19','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('11-DEC-2013 15:21:19','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('11-DEC-2013 15:21:19','dd-MON-yyyy hh24:mi:ss')
where dcn in 
('10005304');
commit;


update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('28-MAY-2014 23:01:27','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('28-MAY-2014 23:01:27','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('28-MAY-2014 23:01:27','dd-MON-yyyy hh24:mi:ss')
where dcn in 
('10005303');
commit;


update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('28-MAY-17 23:01:27','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('28-MAY-17 23:01:27','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('28-MAY-17 23:01:27','dd-MON-yyyy hh24:mi:ss')
where dcn in 
('DCN1112223338867',
'DCN1112223334567');
commit;