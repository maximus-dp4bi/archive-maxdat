insert into emrs_d_county
(COUNTY_CODE
 ,COUNTY_FIPS_CODE
 ,COUNTY_ID
 ,COUNTY_NAME
 ,CSDAID
 ,STAR
 ,STARPLUS
 ,STATE  ) 
SELECT '0'
  ,'0'
  ,0
  ,'Unknown'
  ,'0'
  ,'N'
  ,'N'
  ,'Unknown'
FROM emrs_d_county
WHERE county_code = '0'
  HAVING COUNT(*) = 0;