update corp_etl_list_lkup
set value = 'Sent in Error'
where name = 'PC_ERROR_STATUS';

commit;