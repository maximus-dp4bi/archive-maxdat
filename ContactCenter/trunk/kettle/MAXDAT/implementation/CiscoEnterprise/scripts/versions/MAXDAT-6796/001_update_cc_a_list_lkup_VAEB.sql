
update cc_a_list_lkup
set ref_type = 'Multiple'
where list_type = 'IVR_APP_NAME'
and value = 'MAXVAEB';

commit;