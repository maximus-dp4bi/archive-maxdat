insert into emrs_d_language
   ( LANGUAGE_CODE
   , LANGUAGE
   , LANGUAGE_CODE_ID
   , MANAGED_CARE_PROGRAM
 )
SELECT
    '0'
   , 'Unknown'
   , 0
   , 'Unknown'     
FROM emrs_d_language
WHERE language_code = '0'
HAVING COUNT(*) = 0;