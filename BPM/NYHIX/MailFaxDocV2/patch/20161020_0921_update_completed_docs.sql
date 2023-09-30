update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('09/28/2016 23:59:59','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('09/28/2016 23:59:59','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'V1627254E8002'
);

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('09/28/2016 23:59:59','mm/dd/yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('09/28/2016 23:59:59','mm/dd/yyyy hh24:mi:ss')
where kofax_dcn in (
'O1626418B9012'
);


commit;

