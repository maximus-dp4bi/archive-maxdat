insert into emrs_d_aid_category
   ( AID_CATEGORY_CODE
   , AID_CATEGORY_NAME
   , AID_CATEGORY_ID   
   , MANAGED_CARE_PROGRAM 
 )
SELECT '0'
   , 'Unknown'
   , 0
   , 'Unknown'  
FROM emrs_d_aid_category
WHERE aid_category_code = '0'
HAVING COUNT(*) = 0;