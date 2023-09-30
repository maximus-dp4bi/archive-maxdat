update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('01-SEP-16 08:45:41','dd-MON-yy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('01-SEP-16 08:45:41','dd-MON-yy hh24:mi:ss')
where kofax_dcn in (
'A16217EAA8001',
'A16217EDA8001',
'A16217F0F5001',
'A162210388001',
'A162210544001',
'A1622209C6001',
'A162220B9B001',
'A162220BA4001',
'A162220D54001',
'O1622825F0001',
'A162210364001',
'A162210599001',
'A1622207C0001',
'A1622207D5001',
'A16222098E001',
'A162220A81001',
'A162220D92001',
'A1622315BE001'
);

commit;

