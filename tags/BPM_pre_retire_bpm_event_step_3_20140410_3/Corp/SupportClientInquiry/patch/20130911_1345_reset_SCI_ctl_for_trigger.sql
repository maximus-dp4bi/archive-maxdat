-- 9/11/13 Fix "ORA-20114: Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY"
--         Ocurred since 6/11. Last incident of missing records is 8/19/2013 12:01:36 PM contact ID 200105

UPDATE corp_etl_control SET VALUE='200100' WHERE name = 'CLIENT_INQUIRY_LAST_CALL_ID'
/
COMMIT
/
