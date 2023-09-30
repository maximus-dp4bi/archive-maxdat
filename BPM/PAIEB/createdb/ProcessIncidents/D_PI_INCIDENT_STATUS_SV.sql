CREATE OR REPLACE VIEW D_PI_INCIDENT_STATUS_SV
AS
  SELECT value INCIDENT_STATUS_CODE ,
    report_label INCIDENT_STATUS
  FROM ats.enum_incident_header_status
  UNION ALL
  SELECT '0' AS INCIDENT_STATUS_CODE ,
    NULL AS  INCIDENT_STATUS
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_STATUS_SV TO MAXDAT_REPORTS ; 