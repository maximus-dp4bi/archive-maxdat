--run to get data from 3/25
 UPDATE corp_etl_control
 SET value = '15'
 WHERE name in('MFB_CENTRAL_LOOKBACK_DAYS','MFB_REMOTE_LOOKBACK_DAYS','MFB_ARS_LOOKBACK_DAYS');
 
 COMMIT;
 
 --run after MFB process is done
 UPDATE corp_etl_control
 SET value = '3'
 WHERE name in('MFB_CENTRAL_LOOKBACK_DAYS','MFB_REMOTE_LOOKBACK_DAYS','MFB_ARS_LOOKBACK_DAYS');
 
 COMMIT;