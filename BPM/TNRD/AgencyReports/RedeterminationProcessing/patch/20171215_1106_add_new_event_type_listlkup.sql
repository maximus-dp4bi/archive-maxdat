update corp_etl_list_lkup
set out_var = out_var||',''APP_REACTIVATED'''
where name = 'APPEVENT_EVENT_CODES';

commit;