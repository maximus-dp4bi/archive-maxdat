update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('10/14/2016 08:46:05','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('10/14/2016 08:46:05','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'V16278794F003',
'V1627878EE001'
);

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('10/15/2016 09:00:36','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('10/15/2016 09:00:36','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'O162641FEA001',
'O162797EDF001',
'O162797F19002',
'O162797FB9001',
'O162797FBB001',
'O162797FCD001',
'O1627980AF001',
'O162798132001',
'O16279815D001',
'A16286AA64001',
'A162630C32018',
'O162797F55001'
);

commit;

