CREATE OR REPLACE VIEW D_PI_INCIDENT_STATUS_SV
AS
  SELECT value DPIISS_ID ,
    report_label INCIDENT_STATUS
  FROM eb.enum_incident_header_status
  WHERE scope = 'INCIDENT' ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.D_PI_INCIDENT_STATUS_SV TO EB_MAXDAT_REPORTS ; 