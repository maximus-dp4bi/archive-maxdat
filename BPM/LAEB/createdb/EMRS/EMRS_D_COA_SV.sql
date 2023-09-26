DROP VIEW MAXDAT_SUPPORT.EMRS_D_COA_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_COA_SV
AS
SELECT 
    coa.value AS COA_CD,
    coa.DESCRIPTION AS COA_DESCRIPTION
  FROM EB.ENUM_CATEGORY_OF_ASSISTANCE coa
  UNION ALL
  SELECT 
    '0' AS COA_CD,
    'Not Defined' AS COA_DESCRIPTION
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_COA_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_COA_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_COA_SV TO MAXDAT_SUPPORT_READ_ONLY;