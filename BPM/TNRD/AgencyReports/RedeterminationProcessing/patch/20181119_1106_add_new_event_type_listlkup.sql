alter table corp_etl_list_lkup_hist
modify out_var varchar2(1000);

update corp_etl_list_lkup
set out_var = out_var||',''COB_INDICATOR_UPDATE'''
where name = 'APPEVENT_EVENT_CODES';


commit;