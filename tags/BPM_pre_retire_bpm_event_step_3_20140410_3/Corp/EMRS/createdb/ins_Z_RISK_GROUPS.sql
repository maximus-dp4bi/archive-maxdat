--
-- Insert the zero dimension record for those facts that DO NOT have a value for 
-- this dimension.
--

insert into emrs_d_risk_group
   ( RISK_GROUP_CODE
   , RISK_GROUP
   , RISK_GROUP_ID
   , MANAGED_CARE_PROGRAM   
 )
SELECT   
    '0'
   , 'Unknown'
   , 0
   , 'Unknown'    
FROM emrs_d_risk_group
WHERE risk_group_code = '0'
 HAVING COUNT(*) = 0;