UPDATE corp_etl_control
SET value = '20190301'
WHERE name in('MAX_SURVEY_CREATE_DATE',
'MAX_SURVEY_UPDATE_DATE',
'MAX_SURVEY_HEADER_CREATE_DATE',
'MAX_SURVEY_HEADER_UPDATE_DATE',
'MAX_SURVEY_SCORE_CREATE_DATE',
'MAX_SURVEY_SCORE_UPDATE_DATE',
'MAX_SURVEY_RESP_CREATE_DATE',
'MAX_SURVEY_RESP_UPDATE_DATE');

COMMIT;