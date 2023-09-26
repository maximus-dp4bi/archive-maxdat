update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('11/10/2016', 'mm/dd/yyyy') 
,CANCEL_BY = 'NYHIX-26866' 
,ASF_CANCEL_DOC = 'Y' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
,INSTANCE_END_DATE = to_date('11/10/2016', 'mm/dd/yyyy')
, STG_DONE_DATE = to_date('11/10/2016', 'mm/dd/yyyy') 
where dcn in 
('14008222','14015067','14015070','14015071','14015072','14015073','14015074','14015075','14015076',
'14015077','14015079','14015047','14015048','14015049','14015050','14015051','14015052','14015054',
'14015055','14015056','14015057','14015058','14015059','14015060','14015061','14015063','14015064',
'14015065','14015066','14015046','14015053','14015062','14015068','14015069','14015078');

commit;
