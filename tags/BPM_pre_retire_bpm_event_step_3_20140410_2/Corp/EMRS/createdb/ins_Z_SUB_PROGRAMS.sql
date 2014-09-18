insert into emrs_d_sub_program
   ( SUB_PROGRAM_CODE
   , SUB_PROGRAM_NAME
   , SUB_PROGRAM_ID
   , PARENT_PROGRAM_ID
   , PARENT_PROGRAM_NAME 
   , START_DATE
   , END_DATE 
   ,MANAGED_CARE_PROGRAM)
SELECT    
   '0'
   , 'Unknown'
   , 0
   , 0
   , 'Unknown'   
   ,SYSDATE
   ,TO_DATE('12/31/2050','MM/DD/YYYY')
   ,'Unknown'   
FROM emrs_d_sub_program
WHERE sub_program_code = '0'
HAVING COUNT(*) = 0;