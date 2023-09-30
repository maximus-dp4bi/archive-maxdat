INSERT INTO emrs_d_provider_ref(provider_number)
SELECT 0
FROM emrs_d_provider_ref
WHERE provider_number = 0
HAVING COUNT(*) = 0;

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
 SELECT user
       ,SYSDATE
       , TO_DATE('12/31/2050','MM/DD/YYYY')
       , TO_DATE('01/01/1995','MM/DD/YYYY')   
       , 'Unknown'
       ,0
       ,'0'
       ,0
       ,0
       ,0
       ,0
       ,'Y'
       ,0
FROM emrs_d_provider
WHERE provider_code = '0'
HAVING COUNT(*) = 0;       