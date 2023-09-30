---
--- NYHIX-29686
---
update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('03-MAR-2017 09:01:14','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = to_date('03-MAR-2017 09:01:14','dd-MON-yyyy hh24:mi:ss')
where kofax_dcn in  
('O170488002552','O170518001554','O170518003590','O170518004520');
commit;
