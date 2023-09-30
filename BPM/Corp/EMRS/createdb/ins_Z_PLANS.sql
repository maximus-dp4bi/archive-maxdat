insert into emrs_d_plan
   (ACTIVE       
    ,CSDA    
    ,ENROLLOK
    ,MANAGED_CARE_PROGRAM    
    ,PLAN_ABBREVIATION
    ,PLAN_ASSIGN
    ,PLAN_CODE    
    ,PLAN_ID
    ,PLAN_NAME
    ,PLAN_TYPE_ID
 )
 SELECT 'N'
   ,'0'
   , 'N'
   , 'Unknown'   
   , 'Unknown'
   , 'N'
   , '0'
   , 0
   ,'Unknown'
   ,0
FROM emrs_d_plan
WHERE plan_code = '0'
 HAVING COUNT(*) = 0;