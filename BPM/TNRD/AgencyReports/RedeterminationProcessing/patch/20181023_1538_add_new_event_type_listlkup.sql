alter table corp_etl_list_lkup
modify out_var varchar2(1000);

update corp_etl_list_lkup
set out_var = out_var||',''DOCUMENT_REMOVED'''
where name = 'APPEVENT_EVENT_CODES';


commit;