UPDATE corp_etl_control
SET value = '2023/01/01 00:00:00'
WHERE name IN('DLY_MAX_UPDATE_TS_DOC_NOTIF','DLY_MAX_UPDATE_TS_APP_DOC');

COMMIT;