INSERT INTO emrs_d_client_ref(client_number)
VALUES(0);



INSERT INTO emrs_d_client(CLIENT_ID
,SOURCE_RECORD_ID
,CLIENT_NUMBER
,CREATED_BY
,DATE_CREATED
,DATE_OF_VALIDITY_END
,DATE_OF_VALIDITY_START
,FIRST_NAME
,LAST_NAME
,MANAGED_CARE_PROGRAM
,VERSION
,CURRENT_FLAG
,CURRENT_CLIENT_ID)
VALUES
(0
 ,0
 ,0 
 ,'AANTONIO' 
 ,SYSDATE
 , '31-DEC-2050'
 , '01-JAN-1995'
 ,'Unknown'
 ,'Unknown'
 ,'Unknown'
 ,0
 ,'Y'
 ,0);