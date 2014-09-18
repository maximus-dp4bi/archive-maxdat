update corp_etl_list_lkup
set out_var = 3
where name = 'MFD_JEOPARDY_DAYS';

update corp_etl_list_lkup
set out_var = 5
where name = 'MFD_TIMELINESS_DAYS';

commit;
