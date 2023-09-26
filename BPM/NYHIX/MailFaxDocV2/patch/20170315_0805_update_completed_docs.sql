--  NYHIX-29902
---  
alter session set current_schema = MAXDAT;
update NYHIX_ETL_MAIL_FAX_DOC_V2 
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('09-MAR-2017 09:01:22','dd-MON-yyyy hh24:mi:ss'),
    INSTANCE_END_DATE=to_date('09-MAR-2017 09:01:22','dd-MON-yyyy hh24:mi:ss'),
    STG_DONE_DATE=to_date('09-MAR-2017 09:01:22','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O1706658DC003',
'O17066C059001',
'O17066C059004',
'O17066C059009',
'O17066C05D002');

commit;


