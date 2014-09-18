INSERT INTO emrs_d_client_plan_enrl_status
(CLIENT_ENROLL_STATUS_ID
 ,CLIENT_NUMBER 
 ,PLAN_TYPE_ID
 ,ENROLLMENT_STATUS_ID
 ,CURRENT_ENROLLMENT_STATUS_ID
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
       ,0
       ,user
       ,SYSDATE
       ,TO_DATE('01/01/1995','MM/DD/YYYY')
       ,TO_DATE('12/31/2050','MM/DD/YYYY')
       ,'N'
       ,0
       ,0
FROM emrs_d_client_plan_enrl_status
WHERE client_enroll_status_id = 0
HAVING COUNT(*) = 0;
       