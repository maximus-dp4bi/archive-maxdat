CREATE OR REPLACE VIEW D_PI_COUNTY_SV
AS
SELECT ec.value AS county_code
  ,ec.report_label AS county
  ,ec.description
  ,COALESCE(ec.attrib_district_cd, 'UD') AS region_code
FROM enum_county ec  
UNION ALL 
SELECT 'UD' AS county_code
  ,'Undefined' AS county
  ,'UNDEFINED' AS description
  ,'UD' AS region_code
FROM DUAL;
    
GRANT SELECT ON D_PI_COUNTY_SV TO MAXDAT_REPORTS;  