Update corp_etl_control
set value = 6 
where name = 'MFB_ARS_LOOKBACK_DAYS';

Update corp_etl_control
set value = '01-OCT-15' 
where name = 'MFB_ARS_LAST_UPDATE_DATE';

commit;