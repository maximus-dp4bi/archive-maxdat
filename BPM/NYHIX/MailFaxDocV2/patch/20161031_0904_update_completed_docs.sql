update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('29-OCT-2016 09:00:11','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('29-OCT-2016 09:00:11','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in (
'O16258EBB6001',
'O162819272001'
);


commit;

