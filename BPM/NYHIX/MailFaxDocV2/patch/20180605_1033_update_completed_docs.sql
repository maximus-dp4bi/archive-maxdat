--- NYHIX-411152
----
update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('06/01/2018','mm/dd/yyyy')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('06/01/2018','mm/dd/yyyy')
where kofax_dcn ='V18123BB81001';
commit;

