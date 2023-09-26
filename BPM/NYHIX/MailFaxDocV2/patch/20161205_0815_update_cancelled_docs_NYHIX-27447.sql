select 'BEFORE', kofax_dcn, instance_status, asf_process_doc, instance_end_date 
from maxdat.nyhix_etl_mail_fax_doc_v2
where kofax_dcn in 
('O163360D18001',
'O16336EBB7002',
'O16336EBF4010',
'O16336EC26001',
'O16336EC5B003',
'O16336EC68010',
'O16336EC76008',
'V16327B6B1001',
'V16327B786001',
'V16336EC72001',
'V16336ED31001',
'V16336ED74001',
'V16336EE31001',
'V16336EE44001');

update maxdat.nyhix_etl_mail_fax_doc_v2
set complete_dt = to_date('02-DEC-16 08:48:58', 'dd-MON-YY HH24:mi:ss')
, asf_process_doc = 'Y'
, instance_status = 'Complete'
, instance_end_date = complete_dt
where kofax_dcn in 
('O163360D18001',
'O16336EBB7002',
'O16336EBF4010',
'O16336EC26001',
'O16336EC5B003',
'O16336EC68010',
'O16336EC76008',
'V16327B6B1001',
'V16327B786001',
'V16336EC72001',
'V16336ED31001',
'V16336ED74001',
'V16336EE31001',
'V16336EE44001');
commit;


select 'AFTER', kofax_dcn, instance_status, asf_process_doc, instance_end_date 
from maxdat.nyhix_etl_mail_fax_doc_v2
where kofax_dcn in 
('O163360D18001',
'O16336EBB7002',
'O16336EBF4010',
'O16336EC26001',
'O16336EC5B003',
'O16336EC68010',
'O16336EC76008',
'V16327B6B1001',
'V16327B786001',
'V16336EC72001',
'V16336ED31001',
'V16336ED74001',
'V16336EE31001',
'V16336EE44001');
