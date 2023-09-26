update nyhix_etl_mail_fax_doc_v2 v
set instance_end_date = null, complete_dt = null, stg_done_date = null,doc_status_cd = (select status_cd from APP_DOC_DATA_STG d where d.dcn = v.dcn),instance_Status = 'Active'
where dcn in('10275153', '10275155', '10643195');

commit;