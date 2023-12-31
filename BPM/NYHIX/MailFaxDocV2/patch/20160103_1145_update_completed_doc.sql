update NYHIX_ETL_MAIL_FAX_DOC_V2 
set COMPLETE_DT  = to_date('12/30/2016 09:01:12', 'mm/dd/yyyy HH:MI:SS') 
,CANCEL_DT = Null
,CANCEL_BY = Null
,ASF_PROCESS_DOC = 'Y' 
,CANCEL_REASON = Null
,CANCEL_METHOD = Null
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('12/30/2016 09:01:12', 'mm/dd/yyyy HH:MI:SS')
,STG_DONE_DATE = to_date('12/30/2016 09:01:12', 'mm/dd/yyyy HH:MI:SS') 
where kofax_dcn in (
'O163558A65001',
'O163558AB7001',
'O163558ACB001',
'O163558AE1001',
'O163558B0D001',
'O163558B75001',
'O163558C82001',
'O163558CDC001',
'O163558D83001',
'O163558D98001',
'O163558DFD001',
'O163558E53001',
'O163558E82001',
'O163558F47001'
);

commit;
