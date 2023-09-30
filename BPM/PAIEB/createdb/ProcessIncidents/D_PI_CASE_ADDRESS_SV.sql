CREATE OR REPLACE VIEW D_PI_CASE_ADDRESS_SV
AS
SELECT a.addr_id
 ,a.case_id
 ,a.street
 ,a.street_2
 ,a.city
 ,a.state
 ,a.zip_code
 ,a.county_code
 ,a.addr_type_cd
 FROM 
  (SELECT ad.addr_id
   ,ad.addr_case_id case_id
   ,ad.addr_street_1 street
   ,ad.addr_street_2 street_2
   ,ad.addr_city city
   ,ad.addr_state_cd state
   ,ad.addr_zip zip_code
   ,COALESCE(ad.addr_ctlk_id,z.attrib_county, 'UD') county_code
   ,ad.addr_type_cd
   ,ROW_NUMBER() OVER(PARTITION BY ad.addr_case_id ORDER BY CASE WHEN ad.addr_type_cd = 'RS' THEN 1 
                                                    WHEN ad.addr_type_cd = 'MR' THEN 2 
                                                    WHEN ad.addr_type_cd = 'FA' THEN 3
                                                    ELSE 4 END) AS rnk
  FROM  address ad
  LEFT JOIN enum_zipcode z ON ad.addr_zip = z.value
  WHERE UPPER(ad.addr_type_cd) IN ('RS', 'MR', 'FA') AND ad.addr_end_date IS NULL AND ad.clnt_client_id IS NULL) a
WHERE a.rnk = 1;
    
GRANT SELECT ON D_PI_CASE_ADDRESS_SV TO MAXDAT_REPORTS;  