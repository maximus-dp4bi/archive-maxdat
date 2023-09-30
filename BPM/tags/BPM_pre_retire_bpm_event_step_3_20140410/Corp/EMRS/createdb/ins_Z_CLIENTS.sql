INSERT INTO emrs_d_client_ref(client_number)
SELECT 0
 FROM emrs_d_client_ref
 WHERE client_number = 0
 HAVING COUNT(*) = 0;           



INSERT INTO emrs_d_client(CLIENT_ID
,SOURCE_RECORD_ID
,CLIENT_NUMBER
,CREATED_BY
,DATE_CREATED
,DATE_OF_VALIDITY_START
,DATE_OF_VALIDITY_END
,FIRST_NAME
,LAST_NAME
,MANAGED_CARE_PROGRAM
,VERSION
,CURRENT_FLAG
,CURRENT_CLIENT_ID)
SELECT 0
 ,0
 ,0 
 ,user
 ,SYSDATE
 ,TO_DATE('01/01/1995','MM/DD/YYYY')
 ,TO_DATE('12/31/2050','MM/DD/YYYY')
 ,'Unknown'
 ,'Unknown'
 ,'Unknown'
 ,0
 ,'Y'
 ,0
 FROM emrs_d_client
 WHERE client_number = 0
 HAVING COUNT(*) = 0;      