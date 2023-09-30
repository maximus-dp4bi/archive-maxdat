update corp_etl_list_lkup
set out_var = out_var||',''RFE_STATUS_CHANGE'',''ELIG_OUTCOME_CHANGED'''
where name = 'APPEVENT_EVENT_CODES';

update corp_etl_control
set value = '2015/10/01 00:00:00'
where name = 'APPEVENT_LAST_CREATE_DATE';

commit;
