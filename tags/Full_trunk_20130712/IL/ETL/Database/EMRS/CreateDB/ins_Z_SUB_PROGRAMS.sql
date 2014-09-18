insert into emrs_d_sub_program
   ( SUB_PROGRAM_CODE
   , SUB_PROGRAM_NAME
   , SUB_PROGRAM_ID
   , PARENT_PROGRAM_ID
   , PARENT_PROGRAM_NAME 
   , START_DATE
   , END_DATE 
   ,MANAGED_CARE_PROGRAM
 )
   VALUES
   ('0'
   , 'Unknown'
   , 0
   , 0
   , 'Unknown'   
   ,SYSDATE
   ,'31-DEC-2050'
   ,'Unknown'   
);