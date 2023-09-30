
insert into emrs_d_provider_specialty_code
   ( PROVIDER_SPECIALTY_CODE
   , PROVIDER_SPECIALTY
   , PROVIDER_SPECIALTY_CODE_ID
   , MANAGED_CARE_PROGRAM
   , VALID_PCP
   , INVALID_PCP
   , SPECIAL_NEEDS  
 )
SELECT '0'
   , 'Unknown'
   , 0
   , 'Unknown'
   , 'N'
   , 'N'
   , 'N'     
FROM emrs_d_provider_specialty_code
WHERE provider_specialty_code = '0'
HAVING COUNT(*) = 0;
