DROP VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV
AS
SELECT e.value AS SELECTION_REASON_CODE ,
    e.description AS SELECTION_REASON 
  FROM eb.enum_choice_reason e
  UNION
  SELECT '0' AS SELECTION_REASON_CODE ,
    'Not Defined' AS SELECTION_REASON 
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV TO MAXDAT_SUPPORT_READ_ONLY;

