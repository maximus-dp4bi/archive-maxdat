update corp_etl_list_lkup
set out_var = '''REFERRED_TO_STATE'',''REFERRED_TO_STATE_2'',''REFERRED_TO_PLAN'',''REFERRED_TO_MTP'',''REFERRED_TO_DSHS'',''REFERRED_TO_OIG'',''REFERRED_TO_OCR'''
where name = 'PI_INCIDENT_STATUS_ESCLT_OLTP';

update corp_etl_list_lkup
set out_var = '''NA'''
where name in('PI_INC_STATS_ESCLT_TRMNL_BPM','PI_INC_STATS_ESCLT_TRMNL_OLTP');

commit;