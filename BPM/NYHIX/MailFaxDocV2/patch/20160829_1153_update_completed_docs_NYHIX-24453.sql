update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('8/25/2016 08:45:15','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('8/25/2016 08:45:15','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'H161976D44001',
'O161463207001',
'O16146327A001',
'O16146331C001',
'O1614634C5001',
'O1614635C9001',
'O1614635DA001',
'O1614636A9001',
'O1614636D3001',
'O1614636EC001',
'O16146377D001',
'O16146383E001',
'O161463848001',
'A16126B73C001'
);

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('8/27/2016 09:00:29','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('8/27/2016 09:00:29','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'A16211CA11001',
'O16175E3C0001',
'O1620499B8001',
'O16208AA55001',
'O16208AF9C001',
'O16210C1DD001',
'O16215DD52001',
'O16215DD97001'
);

commit;

