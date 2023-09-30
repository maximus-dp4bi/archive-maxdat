insert into emrs_d_citizenship_status
   ( MANAGED_CARE_PROGRAM 
    ,CITIZENSHIP_DESCRIPTION 
    ,CITIZENSHIP_CODE 
    ,CITIZENSHIP_ID 
 )
SELECT 'Unknown'
     ,'Unknown'
     ,'0'
     , 0  
FROM emrs_d_citizenship_status     
WHERE citizenship_code = '0'
HAVING COUNT(*) = 0;