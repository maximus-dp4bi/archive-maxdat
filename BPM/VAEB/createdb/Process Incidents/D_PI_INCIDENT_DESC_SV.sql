CREATE OR REPLACE VIEW D_PI_INCIDENT_DESC_SV
AS
    SELECT 1 DPIID_DP,
    'Test' INCIDENT_DESCRIPTION FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_DESC_SV TO MAXDAT_REPORTS;  