update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('20-JAN-17 08:58:55','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('20-JAN-17 08:58:55','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in  ('A163000266015','A163558C00001','A1635698BC001');


commit;
