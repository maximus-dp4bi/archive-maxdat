update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('12-NOV-2016 09:00:19','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('12-NOV-2016 09:00:19','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in (
'O162688001593',
'O16295ED33001',
'O163021BF3001',
'O163021C1A001',
'O163021C29001',
'O163157756003',
'O1631579F8005',
'O163157A3C004',
'O163157A50006',
'O163157A4C004',
'O163157A5B001',
'O163157A5B010',
'O163157A56003',
'O163157A61001',
'O163157A61006',
'O163157A67008',
'O163157A70003',
'O1631579A3003'
);
commit;



