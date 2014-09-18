--
-- Insert the zero dimension record for those facts that DO NOT have a value for 
-- this dimension.
--
INSERT INTO emrs_d_enrollment_error_code(
ENROLLMENT_ERROR_CODE_ID
,ENROLLMENT_ERROR_CODE
,ENROLLMENT_ERROR_DESCRIPTION
,WARNING_IND
,DENIAL_REASON_IND
,NEEDS_IMAGE_IND
,MANUAL_EDIT_IND
,DO_NOT_PERSIST_IND
,RECYCLE_IND
,DENIED_LETTER_IND
,ON_DENIAL_CREATE_TASK_IND
,CORRECT_FOR_PLAN_SVC_TYPES
,MANAGED_CARE_PROGRAM)
SELECT
0
 ,'0'
 ,'Unknown'
 ,0
 ,0
 ,0
 ,0
 ,0
 ,0
 ,0
 ,null
 ,null
 ,'Unknown'
 FROM emrs_d_enrollment_error_code
 WHERE enrollment_error_code = '0'
 HAVING COUNT(*) = 0;
 