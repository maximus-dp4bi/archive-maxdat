CREATE OR REPLACE VIEW EMRS_D_BENEFITS_PACKAGE_SV 
AS
  SELECT b.value AS BENEFITS_PACKAGE_CD ,
    b.description AS BENEFITS_PACKAGE
  FROM &schema_name..ENUM_BENEFITS_PACKAGE b
  UNION
  SELECT '0' AS BENEFITS_PACKAGE_CD ,
    'Not Defined' AS BENEFITS_PACKAGE
  FROM DUAL; 
  
GRANT SELECT ON maxdat_support.EMRS_D_BENEFITS_PACKAGE_SV TO MAXDAT_REPORTS;
