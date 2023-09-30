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
   VALUES
   ( '0'
   , 'Unknown'
   , 0
   , 'Unknown'    
);