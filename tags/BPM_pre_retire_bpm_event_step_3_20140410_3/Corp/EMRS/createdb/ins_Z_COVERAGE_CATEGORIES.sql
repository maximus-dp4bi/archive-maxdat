insert into emrs_d_coverage_category
   ( COVERAGE_CATEGORY_CODE
   , COVERAGE_CATEGORY
   , COVERAGE_CATEGORY_ID
   , MANAGED_CARE_PROGRAM   
 )
SELECT '0'
   , 'Unknown'
   , 0
   , 'Unknown'  
FROM emrs_d_coverage_category WHERE coverage_category_code = '0'
HAVING COUNT(*) = 0 ;

