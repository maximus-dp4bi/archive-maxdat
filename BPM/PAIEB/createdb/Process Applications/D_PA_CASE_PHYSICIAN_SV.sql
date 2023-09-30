CREATE OR REPLACE VIEW D_PA_CASE_PHYSICIAN_SV
AS
SELECT distinct ca.case_id 
,ca.agency_id AS physician_agency_id
FROM case_agency ca
WHERE ca.end_date IS NULL
AND ca.agency_cd = 'PHYSICIAN'
UNION ALL
SELECT distinct ca2.case_id 
,-1 AS physician_agency_id
FROM case_agency ca2
WHERE NOT EXISTS (SELECT ca3.case_id FROM case_agency ca3 WHERE ca3.end_date IS NULL AND ca3.agency_cd = 'PHYSICIAN' AND ca2.case_id = ca3.case_id);
    
GRANT SELECT ON D_PA_CASE_PHYSICIAN_SV TO MAXDAT_REPORTS;