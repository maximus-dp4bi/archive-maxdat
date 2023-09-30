--
-- Insert the zero dimension record for those facts that DO NOT have a value for 
-- this dimension.
--

insert into emrs_d_selection_status
   ( SELECTION_STATUS_ID
    ,SELECTION_STATUS_CODE
    ,SELECTION_STATUS_DESCRIPTION
    ,OVERWRITE_IND
    ,OVERWRITE_TO_VALUE
    ,VALID_SELECTION_IND
    ,ALLOW_NEW_SELECTION_IND
    ,MANAGED_CARE_PROGRAM 
 )
SELECT 0
   , '0'
   , 'Unknown'
   , 0
   ,null
   ,0
   ,0
   ,'Unknown'
FROM emrs_d_selection_status
WHERE selection_status_code = '0'
HAVING COUNT(*) = 0;
