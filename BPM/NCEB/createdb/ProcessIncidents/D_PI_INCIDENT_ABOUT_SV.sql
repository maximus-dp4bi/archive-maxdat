drop view D_PI_INCIDENT_ABOUT_SV;
CREATE OR REPLACE VIEW D_PI_INCIDENT_ABOUT_SV
AS
  SELECT value DPIIA_ID ,
    report_label INCIDENT_ABOUT
  FROM eb.enum_affected_party_type
  WHERE scope = 'INCIDENT' 
  AND effective_end_date IS NULL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_ABOUT_SV TO MAXDAT_REPORTS ; 
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_INCIDENT_ABOUT_SV TO MAXDATSUPPORT_READ_ONLY;