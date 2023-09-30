CREATE OR REPLACE VIEW D_PI_INCIDENT_TYPE_SV
AS
  SELECT value INCIDENT_TYPE_CODE ,
    report_label INCIDENT_TYPE
  FROM ats.enum_incident_header_type
--  WHERE scope = 'INCIDENT' 
  ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_TYPE_SV TO MAXDAT_REPORTS ; 