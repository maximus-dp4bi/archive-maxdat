INSERT INTO emrs_d_client_plan_eligibility
(CLIENT_PLAN_ELIGIBILITY_ID
 ,CLIENT_NUMBER 
 ,PLAN_TYPE_ID
 ,SUB_PROGRAM_ID
 ,ELIGIBILITY_STATUS_CODE 
 ,CURRENT_ELIGIBILITY_STATUS_CD 
 ,CREATED_BY 
 ,DATE_CREATED
 ,DATE_OF_VALIDITY_START 
 ,DATE_OF_VALIDITY_END 
 ,CURRENT_FLAG 
 ,VERSION 
 ,SOURCE_RECORD_ID)
SELECT 0
       ,0
       ,0
       ,0
       ,'X'
       ,'X'
       ,user
       ,SYSDATE
       ,TO_DATE('01/01/1995','MM/DD/YYYY')
       ,TO_DATE('12/31/2050','MM/DD/YYYY')
       ,'N'
       ,0
       ,0
FROM emrs_d_client_plan_eligibility
WHERE client_plan_eligibility_id = 0
HAVING COUNT(*) = 0;       
       