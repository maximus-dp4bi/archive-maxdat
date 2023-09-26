alter session set current_schema = MAXDAT;
update nyhix_etl_mail_fax_doc_v2
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('17-FEB-2017 09:03:55','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in  ('O17047522A009',
'O170475369006',
'O17047535F002',
'O1704751F6006',
'O170475206002',
'O17047522A006',
'O170475269009',
'O170475319007',
'O1704753C7004');
commit;

update nyhix_etl_mail_fax_doc_v2
set INSTANCE_STATUS = 'Complete',
    ASF_PROCESS_DOC = 'Y',
    COMPLETE_DT=to_date('18-FEB-17 09:01:10','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in ('O170401799001','O161452B0E001');
commit;
