UPDATE corp_etl_list_lkup
SET out_var = '''Referred to HHSC'',''Referred to Plan'',''Referred to MTP'',''Referred to DSHS'',''Referred to OIG'',''Referred to Office of Civil Rights'''
WHERE list_type = 'INC_STATUS'
AND name = 'PI_INC_STATS_ESCLT_TRMNL_BPM';

UPDATE corp_etl_list_lkup
SET out_var = '''REFERRED_TO_STATE'',''REFERRED_TO_STATE_2'',''REFERRED_TO_PLAN'',''REFERRED_TO_MTP'',''REFERRED_TO_DSHS'',''REFERRED_TO_OIG'',''REFERRED_TO_OCR'''
WHERE list_type = 'INC_STATUS'
AND name = 'PI_INC_STATS_ESCLT_TRMNL_OLTP';



commit;