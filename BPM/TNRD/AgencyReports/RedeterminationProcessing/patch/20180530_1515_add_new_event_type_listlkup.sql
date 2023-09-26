update corp_etl_list_lkup
set out_var = out_var||',''APP_PRIORITY_UPDATED'''
where name = 'APPEVENT_EVENT_CODES';

update corp_etl_control
set value = '2018/05/19 00:00:00'
where name = 'APPEVENT_LAST_CREATE_DATE';

commit;