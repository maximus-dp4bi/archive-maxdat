insert into emrs_d_termination_reason
   ( REASON_CODE
   , REASON
   , PLAN_NAME
   , TERM_REASON_CODE_ID   
   , MANAGED_CARE_PROGRAM  
 )
SELECT   
   '0'
   , 'Unknown'
   , 'Unknown'
   , 0
   , 'Unknown'     
FROM emrs_d_termination_reason
WHERE reason_code = '0'
HAVING COUNT(*) = 0;