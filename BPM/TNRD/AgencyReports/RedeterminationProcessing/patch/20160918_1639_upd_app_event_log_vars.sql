alter session set current_schema = MAXDAT;


update corp_etl_list_lkup
set out_var = out_var||',''COB_ESTABLISHED'''
where name = 'APPEVENT_EVENT_CODES';

commit;
