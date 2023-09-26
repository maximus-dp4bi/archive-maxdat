update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('06-JAN-2017 09:02:18','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('06-JAN-2017 09:02:18','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in (
'O16362B787001',
'O16362B7B9001',
'O16362B7BA001',
'O16362B7BE003',
'O16362B7DB001',
'O16362B7FF001',
'O16362B805001',
'O16362B845001',
'O16362B847001',
'O16362B84A001',
'O16362B86E001'
);


commit;

