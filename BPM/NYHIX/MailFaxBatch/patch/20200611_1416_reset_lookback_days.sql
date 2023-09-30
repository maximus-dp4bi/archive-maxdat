

--Set lookback days to 3 after MFB job completion
UPDATE corp_etl_control
SET value = '3'
WHERE NAME in('MFB_CENTRAL_LOOKBACK_DAYS','MFB_REMOTE_LOOKBACK_DAYS','MFB_ARS_LOOKBACK_DAYS');
commit;

