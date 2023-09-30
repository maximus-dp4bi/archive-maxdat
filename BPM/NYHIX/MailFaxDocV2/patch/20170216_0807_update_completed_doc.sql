update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('08-FEB-17 09:01:23','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
where kofax_dcn in  ('O170388005553','V17026B367014','V17026B367015','V17026B367016');
commit;

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('08-FEB-17 09:02:30','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
where kofax_dcn in  ('O17037F8CC010','O17037F8D8009','O17037F8E7009');
commit;

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('08-FEB-17 09:02:44','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
where kofax_dcn in ('O17034F83C002','O17034F83C008','O17034F83C009','O17034F840004',
'O17034F845001','O17034F84A007','O17037F82E009','O17037F857010','O17037F858003','O17037F858010',
'O17037FB97006','O17037FBDB009','O17037FBDB010','O17037FBDD010','O17037FC05009','O17037FC05010',
'O17037FC16010','O17037FC21002');
commit;

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('09-FEB-17 09:00:36','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
where kofax_dcn in ('O17031CD1F001','O17031CD8C001','O17031CE1C001','O17031CE42001');
commit;

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('10-FEB-17 09:00:47','dd-MON-yyyy hh24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
where kofax_dcn in ('O17031D840001','O17031D865001','O17032D877001');
commit;
