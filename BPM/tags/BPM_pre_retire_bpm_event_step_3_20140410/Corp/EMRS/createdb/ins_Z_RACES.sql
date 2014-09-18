insert into emrs_d_race
   ( RACE_CODE
   , RACE_DESCRIPTION
   , RACE_ID
   , MANAGED_CARE_PROGRAM    
 )
SELECT   
    '0'
   , 'Unknown'
   , 0
   , 'Unknown'  
FROM emrs_d_race
WHERE race_code = '0'
HAVING COUNT(*) = 0;