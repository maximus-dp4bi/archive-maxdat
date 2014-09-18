INSERT INTO emrs_d_plan_type(PLAN_TYPE_ID
 ,PLAN_TYPE
 ,MANAGED_CARE_PROGRAM  )
 SELECT 0
     ,'Unknown'
     ,'Unknown'
FROM emrs_d_plan_type
WHERE plan_type_id = 0
 HAVING COUNT(*) = 0;