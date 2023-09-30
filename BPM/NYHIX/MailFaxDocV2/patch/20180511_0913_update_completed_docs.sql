--- NYHIX-40225
----
update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('04/25/2018 09:01:18','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('04/25/2018 09:01:18','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'H18114827F001'
);
commit;

