CREATE OR REPLACE VIEW EMRS_D_RELATIONSHIP_SV
AS
  SELECT m.value AS RELATIONSHIP_CODE ,
    m.description AS RELATIONSHIP  
  FROM ats.ENUM_RELATIONSHIP m
  UNION
  SELECT '0' AS RELATIONSHIP_CODE ,
    'Not Defined' AS RELATIONSHIP  
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RELATIONSHIP_SV TO MAXDAT_REPORTS;