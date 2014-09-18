-- 9/7/13 Initially for TXEB deployment. Reset because something missed on initial run.

UPDATE corp_etl_control SET value = '0' WHERE name = 'CLIENT_INQUIRY_LAST_CALL_ID';
COMMIT;
