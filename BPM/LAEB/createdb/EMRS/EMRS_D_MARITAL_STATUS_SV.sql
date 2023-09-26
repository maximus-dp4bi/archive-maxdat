DROP VIEW MAXDAT_SUPPORT.EMRS_D_MARITAL_STATUS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_MARITAL_STATUS_SV
AS
SELECT 
    c.VALUE AS MARITAL_STATUS_CD
    ,c.REPORT_LABEL AS MARITAL_STATUS
    ,c.EFFECTIVE_START_DATE AS EFFECTIVE_START_DATE
    ,c.EFFECTIVE_END_DATE AS EFFECTIVE_END_DATE
  FROM EB.ENUM_MARITAL_STATUS c;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_MARITAL_STATUS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_MARITAL_STATUS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_MARITAL_STATUS_SV TO MAXDAT_SUPPORT_READ_ONLY;
