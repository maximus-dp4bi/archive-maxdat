Update MAXDAT.corp_etl_proc_letters 
set QC_FLAG = 'Y' 
where request_driver_table = 'MANUAL_NOTICE_CASE';

commit;


Update MAXDAT.corp_etl_proc_letters_oltp 
set QC_FLAG = 'Y' 
where request_driver_table = 'MANUAL_NOTICE_CASE';

commit;

