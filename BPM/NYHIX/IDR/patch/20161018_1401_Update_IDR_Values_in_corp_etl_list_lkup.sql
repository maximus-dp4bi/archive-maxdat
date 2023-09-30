update corp_etl_list_lkup
set out_var = '''IDR Open'''
where name = 'IDR_INCIDENT_OPEN_2';

update corp_etl_list_lkup
set out_var = '''IDR Not Resolved'''
where name = 'IDR_CLOSED_NOT_SUCCESSFUL_2';

update corp_etl_list_lkup
set out_var = '''IDR Resolved'''
where name = 'IDR_CLOSED_SUCCESSFUL_2';

update corp_etl_list_lkup
set out_var = '''IDR Closed - Duplicate/Error'''
where name = 'IDR_INC_CLOSED_DUP_2';

commit;
