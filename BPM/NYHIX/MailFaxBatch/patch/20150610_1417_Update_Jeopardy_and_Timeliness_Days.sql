select 'Before_State', name,  out_var from corp_etl_list_lkup 
where name in ('MFB_JEOPARDY_DAYS','MFB_TIMELINESS_DAYS');

update corp_etl_list_lkup
set out_var = 2 
where name = 'MFB_JEOPARDY_DAYS';

update corp_etl_list_lkup
set out_var = 3 
where name = 'MFB_TIMELINESS_DAYS';

select 'After_State', name,  out_var from corp_etl_list_lkup 
where name in ('MFB_JEOPARDY_DAYS','MFB_TIMELINESS_DAYS');
