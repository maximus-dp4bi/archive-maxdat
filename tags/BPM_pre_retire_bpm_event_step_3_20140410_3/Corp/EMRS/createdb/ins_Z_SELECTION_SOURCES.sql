insert into emrs_d_selection_source
   ( MANAGED_CARE_PROGRAM 
    ,SELECTION_SOURCE
    ,SELECTION_SOURCE_CODE
    ,SeLECTION_SOURCE_ID
    ,IS_CHOICE_IND
 )
SELECT   
    'Unknown'
   ,'Unknown'
   , '0'
   , 0
   ,'N'
FROM emrs_d_selection_source
WHERE selection_source_code = '0'
HAVING COUNT(*) = 0 ;