update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('02-FEB-17 11:27:49','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('02-FEB-17 11:27:49','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in  ('A16293DABF001','A17004EDAF001','A17006FEEA001','A16357C1FE001','A163579AAA001');
commit;

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('03-FEB-17 09:14:15','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('03-FEB-17 09:14:15','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in  ('A17005F5EE001','A17006FFC4001','A17006FF8E001','A17005F9F6001','A1635698D0001');
commit;
