--
-- Insert the zero dimension record for those facts that DO NOT have a value for 
-- this dimension.
--

insert into emrs_d_enrollment_action_statu
   ( ENROLLMENT_ACTION_STATUS_CODE
   , ENROLLMENT_ACTION_STATUS_CODE_
   , ENROLLMENT_ACTION_STATUS_ID
   , MANAGED_CARE_PROGRAM 
 )
SELECT '0'
   , 'Unknown'
   , 0
   , 'Unknown'     
FROM emrs_d_enrollment_action_statu
WHERE enrollment_action_status_code = '0'
HAVING COUNT(*) = 0;