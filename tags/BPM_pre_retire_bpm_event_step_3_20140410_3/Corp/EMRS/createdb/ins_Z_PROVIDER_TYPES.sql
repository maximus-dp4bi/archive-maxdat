
insert into emrs_d_provider_type
   ( PROVIDER_CODE
   , PROVIDER_NAME
   , PROVIDER_TYPE_ID
   , MANAGED_CARE_PROGRAM
   , VALID
   , INVALID     
 )
 SELECT
     '0'
   , 'Unknown'
   , 0
   , 'Unknown'
   , 'N'
   , 'N'
 FROM emrs_d_provider_type
 WHERE provider_code = '0'
 HAVING COUNT(*) = 0;