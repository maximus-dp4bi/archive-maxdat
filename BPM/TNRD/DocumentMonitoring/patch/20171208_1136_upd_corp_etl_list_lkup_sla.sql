UPDATE corp_etl_list_lkup
SET out_var = '1'
WHERE name = 'MFD_JEOPARDY_DAYS';

UPDATE corp_etl_list_lkup
SET out_var = 'B'
WHERE name = 'MFD_JEOPARDY_DAYS_TYPE';


UPDATE corp_etl_list_lkup
SET out_var = '1'
WHERE name = 'MFD_TIMELINESS_DAYS';

UPDATE corp_etl_list_lkup
SET out_var = 'B'
WHERE name = 'MFD_TIMELINESS_DAYS_TYPE';

commit;