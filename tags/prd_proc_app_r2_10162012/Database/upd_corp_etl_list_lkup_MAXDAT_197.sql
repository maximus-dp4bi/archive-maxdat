--upd_corp_etl_list_lkup_MAXDAT_197 - uat only
select * from  corp_etl_list_lkup
where  name = 'ManageWork_SLA_Jeopardy_Days'
and value = 'State Data Entry Task - Undeliverable';

update   corp_etl_list_lkup
set out_var = '2'
where  name = 'ManageWork_SLA_Jeopardy_Days'
and value = 'State Data Entry Task - Undeliverable';

select * from  corp_etl_list_lkup
where  name = 'ManageWork_SLA_Jeopardy_Days'
and value = 'State Data Entry Task - Undeliverable';
commit;
