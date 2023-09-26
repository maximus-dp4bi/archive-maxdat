update maxdat.corp_etl_control 
set value =1 where name in ('MFB_REMOTE_LOOKBACK_DAYS', 'MFB_CENTRAL_LOOKBACK_DAYS', 'MFB_ARS_LOOKBACK_DAYS');
update maxdat.corp_etl_control 
set value = '11-SEP-17' where name in ('MFB_REMOTE_LAST_UPDATE_DATE','MFB_CENTRAL_LAST_UPDATE_DATE', 'MFB_ARS_LAST_UPDATE_DATE');
commit;

    
