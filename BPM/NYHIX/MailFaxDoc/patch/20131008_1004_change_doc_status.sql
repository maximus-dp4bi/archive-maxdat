update CORP_ETL_LIST_LKUP
set out_var = 'PROCESSED' 
where name = 'MFD_DOC_STATUS';

commit;