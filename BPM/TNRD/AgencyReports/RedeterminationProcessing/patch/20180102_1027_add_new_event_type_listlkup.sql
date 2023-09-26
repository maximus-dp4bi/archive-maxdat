update corp_etl_list_lkup
set out_var = out_var||',''CK_APPR_MA'',''TRMDN'',''NR'''
where name = 'APPEVENT_EVENT_CODES';

commit;