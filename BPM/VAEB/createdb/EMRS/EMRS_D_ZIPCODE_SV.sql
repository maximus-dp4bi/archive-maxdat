CREATE OR REPLACE VIEW EMRS_D_ZIPCODE_SV
AS
  SELECT NULL source_record_id ,    
    value zip_code ,
    DECODE(covers_multiple_county_ind,1,'Y','N') covers_multiple_county ,
    attrib_county zip_county ,
    attrib_state zip_state ,
    attrib_city zip_city
  FROM enum_zipcode
  UNION
  SELECT NULL source_record_id ,    
    '0' zip_code ,
    'N' covers_multiple_county ,
    '0' zip_county ,
    'NA' zip_state ,
    'Unknown' zip_city
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ZIPCODE_SV TO MAXDAT_REPORTS;  