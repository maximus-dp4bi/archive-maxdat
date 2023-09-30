insert into emrs_d_status_in_group
   ( STATUS_IN_GROUP_CODE
   , STATUS_IN_GROUP
   , STATUS_IN_GROUP_CATEGORY   
   , STATUS_IN_GROUP_ID
   , MANAGED_CARE_PROGRAM      
 )
SELECT
    '0'
   , 'Unknown'
   ,'Unknown'
   , 0
   , 'Unknown'  
FROM emrs_d_status_in_group
WHERE status_in_group_code = '0'
HAVING COUNT(*) = 0;

