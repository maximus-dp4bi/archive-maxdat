DROP VIEW MAXDAT_SUPPORT.EMRS_D_SUBPROGRAM_CAT_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_SUBPROGRAM_CAT_SV
AS
SELECT 'GROUP_1'  AS SUBPROGRAM_CAT_CODE,
    'Acute and Behavioral Health' AS SUBPROGRAM_CAT_NAME
  FROM DUAL
  UNION
  SELECT 'GROUP_2' AS SUBPROGRAM_CAT_CODE,
    'Behavioral Health Only' AS SUBPROGRAM_CAT_NAME
  FROM DUAL
  UNION
  SELECT 'GROUP_3' AS SUBPROGRAM_CAT_CODE,
    'HCBS and Chisholm � Acute and Behavioral Health' AS SUBPROGRAM_CAT_NAME
  FROM DUAL
  UNION
  SELECT 'GROUP_4' AS SUBPROGRAM_CAT_CODE,
    'HCBS and Chisholm � Behavioral Health Only' AS SUBPROGRAM_CAT_NAME
  FROM DUAL
  UNION
  SELECT 'UD' AS SUBPROGRAM_CAT_CODE,
    'Not Defined' AS SUBPROGRAM_CAT_NAME
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SUBPROGRAM_CAT_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SUBPROGRAM_CAT_SV TO MAXDATSUPPORT_READ_ONLY;
