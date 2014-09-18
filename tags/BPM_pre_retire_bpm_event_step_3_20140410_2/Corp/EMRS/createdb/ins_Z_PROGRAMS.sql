insert into emrs_d_program
   (PROGRAM_CODE
   , PROGRAM_NAME
   , PROGRAM_ID
   , START_DATE
   , END_DATE 
   ,MANAGED_CARE_PROGRAM
   ,ACTIVE_INACTIVE)
 SELECT '0'
   , 'Unknown'
   , 0
   ,SYSDATE
   ,TO_DATE('12/31/2050','MM/DD/YYYY')
   ,'Unknown'
   ,'I'
FROM emrs_d_program
WHERE program_code = '0'
 HAVING COUNT(*) = 0;