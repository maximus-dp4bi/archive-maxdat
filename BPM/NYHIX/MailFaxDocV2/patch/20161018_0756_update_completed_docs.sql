update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('10/14/2016 08:46:05','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('10/14/2016 08:46:05','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'A16172C255001',
'A16187211F001',
'O16244A0C0001',
'O16244A0D3001',
'O16257E2EF001',
'O162746823007',
'V162787A35001'
);


commit;

