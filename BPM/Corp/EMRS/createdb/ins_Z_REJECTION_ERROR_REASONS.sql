insert into emrs_d_rejection_error_reason
   ( REJECTION_CODE
   , REJECTION_ERROR_DESCRIPTION
   , REJECTION_CATEGORY
   , REJECTION_ERROR_REASON_ID
   , MANAGED_CARE_PROGRAM    
   , RELATED_FILES)
SELECT  '0'
   , 'Unknown'
   , 'Unknown'
   , 0
   , 'Unknown'
   , 'Unknown' 
FROM emrs_d_rejection_error_reason WHERE rejection_code = '0'
HAVING COUNT(*) = 0 ;
