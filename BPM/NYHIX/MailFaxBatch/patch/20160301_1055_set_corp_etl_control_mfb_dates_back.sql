update corp_etl_control
set value = '19-FEB-16'
where name in (
'MFB_CENTRAL_LAST_UPDATE_DATE',
'MFB_ARS_LAST_UPDATE_DATE',
'MFB_REMOTE_LAST_UPDATE_DATE');

commit;
