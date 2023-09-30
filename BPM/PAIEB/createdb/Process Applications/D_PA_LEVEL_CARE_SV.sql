CREATE OR REPLACE VIEW d_pa_level_care_sv
AS
SELECT value level_care_code
       ,report_label level_care
FROM enum_level_care
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS level_care_code
      , 'Undefined' AS level_care
FROM DUAL;

GRANT SELECT ON D_PA_LEVEL_CARE_SV TO MAXDAT_REPORTS;