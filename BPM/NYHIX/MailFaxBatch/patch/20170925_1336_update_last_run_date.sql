update maxdat.corp_etl_control 
set value = '22-SEP-17' where name in ('MFB_REMOTE_LAST_UPDATE_DATE','MFB_CENTRAL_LAST_UPDATE_DATE', 'MFB_ARS_LAST_UPDATE_DATE');
commit;

    
