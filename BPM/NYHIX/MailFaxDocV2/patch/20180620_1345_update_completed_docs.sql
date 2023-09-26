--- NYHIX-41350
----
update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('06/08/2018 08:46:20','mm/dd/yyyy HH:MI:SS')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('06/08/2018 08:46:20','mm/dd/yyyy HH:MI:SS')
where kofax_dcn ='H181587DA5001';

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('06/08/2018 08:46:20','mm/dd/yyyy HH:MI:SS')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('06/08/2018 08:46:20','mm/dd/yyyy HH:MI:SS')
where kofax_dcn ='H181587DA5002';

commit;

