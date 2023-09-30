insert into emrs_d_change_reason
   ( CHANGE_REASON_CODE
   , CHANGE_REASON
   , CHANGE_REASON_CODE_PLAN
   , CHANGE_REASON_ID   
   , MANAGED_CARE_PROGRAM  
 )
SELECT '0'
   , 'Unknown'
   , '0'
   , 0
   , 'Unknown'
FROM emrs_d_change_reason
WHERE change_reason_code = '0'
HAVING COUNT(*) = 0;