update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('11-JAN-2017 08:50:10','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('11-JAN-2017 08:50:10','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn = 'O1631364B5002';

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('12-JAN-2017 09:04:21','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('12-JAN-2017 09:04:21','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in 
('O17011209F010',
'O1701120AF001',
'O170112199008',
'V16365D667008',
'V16365D667009',
'V17003DC30001',
'V170101CF3001'
);

commit;
