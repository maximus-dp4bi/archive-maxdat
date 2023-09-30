insert into emrs_d_federal_poverty_level
   ( FPL_NUMBER_IN_FAMILY
   , FPL_MAX_DOLLARS
   , FPL_DESCRIPTION
   , FPL_ID   
   , FPL_LOCALE
   , FPL_YEAR
 )
SELECT 0
   , 0
   , 'Unknown'
   , 0
   , 'Unknown'
   , NULL  
FROM emrs_d_federal_poverty_level
WHERE fpl_id = 0
 HAVING COUNT(*) = 0;