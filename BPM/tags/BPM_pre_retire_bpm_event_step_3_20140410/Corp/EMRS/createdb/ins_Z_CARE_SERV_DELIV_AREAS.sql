
insert into emrs_d_care_serv_deliv_area
   ( CSDA_CODE
   , CSDA_NAME
   , CSDA_ID
   , MANAGED_CARE_PROGRAM    
 )
SELECT
    '0'
   , 'Unknown'
   , 0
   , 'Unknown'   
FROM emrs_d_care_serv_deliv_area
WHERE csda_code = '0'
HAVING COUNT(*) = 0;