insert into emrs_d_selection_reason
   ( MANAGED_CARE_PROGRAM 
    ,SELECTION_REASON 
    ,SELECTION_REASON_CODE 
    ,SELECTION_REASON_ID 
 )
 SELECT
    'Unknown'
    ,'Unknown'
   , '0'
   , 0
FROM emrs_d_selection_reason
WHERE selection_reason_code = '0'
HAVING COUNT(*) = 0;