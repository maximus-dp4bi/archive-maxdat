-- 7/31/13 Fix DB Join - MAXDAT Staff Update - java.lang.ArrayIndexOutOfBoundsException: 52

UPDATE corp_etl_control SET VALUE='138337' WHERE name = 'CLIENT_INQUIRY_LAST_CALL_ID'
/
UPDATE corp_etl_control SET value= '60' WHERE name = 'CLIENT_INQUIRY_CONTACT_DAYS'
/
COMMIT
/
