update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('18-NOV-16 08:48:08', 'dd-MON-YY HH24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = complete_dt
where kofax_dcn in (
'A16179F1CC001',
'A161831483001',
'A161872074001',
'A16217E6F4017',
'A16217EE3A001',
'A1622520E4001',
'A162282DF9001',
'A162282E62001',
'A1623040DE001',
'O162079EF0007',
'A162017E8B001',
'A1620182BF001',
'A16216E18C001',
'A16217EFC1001');

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('24-NOV-16 08:45:41', 'dd-MON-YY HH24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = complete_dt
where kofax_dcn in (
'A161115AE7001',
'A16167A94A001',
'A16188271B001',
'A161882A33001',
'O162459E29001',
'O16245A308001',
'O16245A3EB001',
'O16245A965001',
'O16246AAD0001',
'O16252C812001',
'O16252CC05001',
'O16252CCB3001',
'O16252CD38001',
'O16253D361001',
'O16256DDE3001');
commit;