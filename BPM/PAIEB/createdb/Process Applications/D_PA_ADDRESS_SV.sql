CREATE OR REPLACE VIEW D_PA_ADDRESS_SV
AS
SELECT ad.addr_id
 ,ad.addr_street_1 street
 ,ad.addr_street_2 street_2
 ,ad.addr_city city
 ,ad.addr_state_cd state
 ,ad.addr_zip zip_code
 ,COALESCE(ad.addr_ctlk_id,z.attrib_county, 'UD') county_code
 ,ad.addr_type_cd
 ,ad.addr_case_id case_id
FROM  address ad
LEFT JOIN enum_zipcode z ON ad.addr_zip = z.value;
    
GRANT SELECT ON D_PA_ADDRESS_SV TO MAXDAT_REPORTS;  