-- 6/12/13 Reset control to pick up calls without note
UPDATE corp_etl_control SET value='0' WHERE name = 'CLIENT_INQUIRY_LAST_CALL_ID';
COMMIT;