INSERT INTO emrs_d_provider_ref(provider_number)
VALUES(0);



insert into emrs_d_provider(
CREATED_BY
,DATE_CREATED
,DATE_OF_VALIDITY_END
,DATE_OF_VALIDITY_START
,MANAGED_CARE_PROGRAM
,PLAN_ID
,PROVIDER_CODE
,PROVIDER_ID
,SOURCE_RECORD_ID
,PROVIDER_NUMBER
,VERSION
,CURRENT_FLAG
,CURRENT_PROVIDER_ID)
VALUES('AANTONIO'
       ,SYSDATE
       , '31-DEC-2050'
       , '01-JAN-1995'   
       , 'Unknown'
       ,0
       ,'0'
       ,0
       ,0
       ,0
       ,0
       ,'Y'
       ,0);