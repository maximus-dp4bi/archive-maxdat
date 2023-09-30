update corp_etl_control
set value = '2016/01/11 14:59:00'
where name in ('MAX_UPDATE_TS_APP_DOC',
'MAX_UPDATE_TS_DOCUMENT');

Commit;
