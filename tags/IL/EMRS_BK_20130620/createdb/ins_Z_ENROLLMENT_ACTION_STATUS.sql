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
   VALUES
   ( '0'
   , 'Unknown'
   , 0
   , 'Unknown'     
);