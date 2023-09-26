DROP VIEW MAXDAT_SUPPORT.D_PI_INCIDENT_STATUS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PI_INCIDENT_STATUS_SV
AS
SELECT value AS INCIDENT_STATUS_CD
      , description AS INCIDENT_STATUS
FROM eb.ENUM_INCIDENT_HEADER_STATUS
UNION ALL
SELECT 'UD' AS INCIDENT_STATUS_CD
      , 'Undefined' AS INCIDENT_STATUS
FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_STATUS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_STATUS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_STATUS_SV TO MAXDAT_SUPPORT_READ_ONLY;