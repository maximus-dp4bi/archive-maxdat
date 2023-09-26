DROP VIEW MAXDAT_SUPPORT.EMRS_D_RELATIONSHIP_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_RELATIONSHIP_SV
AS
SELECT m.value AS RELATIONSHIP_CODE ,
    m.description AS RELATIONSHIP  
  FROM EB.ENUM_RELATIONSHIP m
  UNION
  SELECT '0' AS RELATIONSHIP_CODE ,
    'Not Defined' AS RELATIONSHIP  
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RELATIONSHIP_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RELATIONSHIP_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RELATIONSHIP_SV TO MAXDAT_SUPPORT_READ_ONLY;