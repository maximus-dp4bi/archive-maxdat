CREATE OR REPLACE VIEW D_PA_REGION_SV
AS
SELECT ed.value AS region_code
  ,ed.report_label AS region
FROM enum_district ed
UNION ALL
SELECT 'UD' AS region_code
  ,'Undefined' AS region
FROM DUAL;
    
GRANT SELECT ON D_PA_REGION_SV TO MAXDAT_REPORTS; 