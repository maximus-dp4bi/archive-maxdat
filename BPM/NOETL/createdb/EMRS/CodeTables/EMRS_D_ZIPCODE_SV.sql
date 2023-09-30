CREATE OR REPLACE VIEW EMRS_D_ZIPCODE_SV
AS
  SELECT value AS ZIP_CODE,
    attrib_city AS ZIP_CITY,
    attrib_county AS ZIP_COUNTY,
    attrib_state AS ZIP_STATE,
    DECODE(covers_multiple_county_ind,1,'Y','N') AS COVERS_MULTIPLE_COUNTY
  FROM enum_zipcode
  UNION
  SELECT '0' AS ZIP_CODE,
    'Unknown' AS ZIP_CITY,
    '0' AS ZIP_COUNTY,
    'NA' AS ZIP_STATE,
    'N' AS COVERS_MULTIPLE_COUNTY
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ZIPCODE_SV TO MAXDAT_REPORTS;  