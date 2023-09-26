update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('9/15/2016 08:45:50','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('9/15/2016 08:45:50','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'O161053205001'
);

commit;

