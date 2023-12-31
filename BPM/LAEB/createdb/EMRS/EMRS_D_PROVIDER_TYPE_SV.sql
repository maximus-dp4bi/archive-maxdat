DROP VIEW MAXDAT_SUPPORT.EMRS_D_PROVIDER_TYPE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_PROVIDER_TYPE_SV
AS
SELECT ept.value AS PROVIDER_TYPE_CODE,
    ept.description AS PROVIDER_TYPE_NAME,
    ept.effective_start_date AS EFFECTIVE_START_DATE,
    ept.effective_end_date AS EFFECTIVE_END_DATE
  FROM eb.enum_provider_type ept
  UNION
  SELECT '0' AS PROVIDER_TYPE_CODE,
    'Not Defined' AS PROVIDER_TYPE_NAME,
    TO_DATE('01/01/1900','mm/dd/yyyy') AS EFFECTIVE_START_DATE,
    NULL AS EFFECTIVE_END_DATE    
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_TYPE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_TYPE_SV TO MAXDAT_SUPPORT_READ_ONLY;
