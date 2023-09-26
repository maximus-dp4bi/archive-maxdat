DROP VIEW MAXDAT_SUPPORT.EMRS_D_PLAN_SERVICE_TYPE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_PLAN_SERVICE_TYPE_SV
AS
SELECT value AS PLAN_SERVICE_TYPE_CD
        ,report_label AS PLAN_SERVICE_TYPE
  FROM EB.ENUM_PLAN_SERVICE_TYPE
  UNION ALL
  SELECT 'UD' AS PLAN_SERVICE_TYPE_CD
        , 'Undefined' AS PLAN_SERVICE_TYPE
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SERVICE_TYPE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SERVICE_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SERVICE_TYPE_SV TO MAXDAT_SUPPORT_READ_ONLY;