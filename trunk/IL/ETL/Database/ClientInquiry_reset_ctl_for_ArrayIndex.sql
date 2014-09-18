-- 7/31/13 Fix DB Join - MAXDAT Staff Update - java.lang.ArrayIndexOutOfBoundsException: 52

UPDATE corp_etl_control SET value= '30' WHERE name = 'CLIENT_INQUIRY_CONTACT_DAYS'
/
COMMIT
/
