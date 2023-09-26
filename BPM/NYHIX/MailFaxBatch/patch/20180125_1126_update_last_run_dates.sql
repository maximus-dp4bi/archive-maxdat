update maxdat.corp_etl_control 
set value = '25-JAN-18' 
where name in ('MFB_ARS_LAST_UPDATE_DATE', 'MFB_CENTRAL_LAST_UPDATE_DATE', 'MFB_REMOTE_LAST_UPDATE_DATE');

commit;