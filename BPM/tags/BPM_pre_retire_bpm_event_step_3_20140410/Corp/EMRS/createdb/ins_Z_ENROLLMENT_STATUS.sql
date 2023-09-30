insert into emrs_d_enrollment_status
   ( ENROLLMENT_STATUS_CODE
   , ENROLLMENT_STATUS_DESC  
   , ENROLLMENT_STATUS_ID   
   , MANAGED_CARE_PROGRAM  
   , IS_AA_PCE_IND
   , IS_MANDATORY_UNASSIGN_IND
 )
SELECT '0'
   , 'Unknown'   
   , 0
   , 'Unknown'
   ,0
   ,0
FROM emrs_d_enrollment_status
WHERE enrollment_status_code = '0'
HAVING COUNT(*) = 0;