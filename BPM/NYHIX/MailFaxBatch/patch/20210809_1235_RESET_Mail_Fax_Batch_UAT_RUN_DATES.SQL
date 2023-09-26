UPDATE maxdat.corp_etl_control
set value = '01-JUN-21'
WHERE NAME = 'MFB_ARS_LAST_UPDATE_DATE';

UPDATE maxdat.corp_etl_control
set value = '01-JUN-21'
WHERE NAME = 'MFB_CENTRAL_LAST_UPDATE_DATE';

UPDATE maxdat.corp_etl_control
set value = '01-JUN-21'
WHERE NAME = 'MFB_REMOTE_LAST_UPDATE_DATE';

COMMIT;