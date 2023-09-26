update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('08/15/2016','mm/dd/yyyy')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('08/15/2016','mm/dd/yyyy')
where kofax_dcn in (
'A16092E17F001',
'O161965F45001',
'O1619668A5008',
'O1620078C0001',
'O1620180EC003',
'A16202844C001',
'O162038F96001',
'O162038FC6001',
'O1620390AB001'
);

commit;

