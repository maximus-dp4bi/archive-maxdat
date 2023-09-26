DROP VIEW MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV
AS
SELECT e.value citizenship_code,
  e.description citizenship_description    
  FROM EB.enum_citizen e
  UNION
  SELECT '0' citizenship_code,
  'Not Defined' citizenship_description   
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV TO MAXDAT_SUPPORT_READ_ONLY;

