update corp_etl_list_lkup
set out_var = out_var||',''APPLICANT_RELINKED'''
where name = 'APPEVENT_EVENT_CODES';

commit;