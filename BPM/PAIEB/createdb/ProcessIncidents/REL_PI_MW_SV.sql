CREATE OR REPLACE VIEW REL_PI_MW_SV
AS
SELECT i.incident_header_id AS PI_BI_ID,
  s.step_instance_id AS MW_BI_ID
FROM ats.incident_header i
FULL OUTER JOIN (SELECT si.ref_id, si.step_instance_id
                FROM ats.step_instance si
                JOIN ats.step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
                WHERE si.ref_type='INCIDENT_HEADER') s ON (s.ref_id = i.incident_header_id);
  
  GRANT SELECT ON MAXDAT_SUPPORT.REL_PI_MW_SV TO MAXDAT_REPORTS ;