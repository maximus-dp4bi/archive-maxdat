CREATE OR REPLACE VIEW d_pa_language_sv
AS

SELECT value language_code
      ,report_label language_desc
FROM enum_language
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS language_code
      ,'Undefined' AS language_desc
FROM DUAL;

GRANT SELECT ON D_PA_LANGUAGE_SV TO MAXDAT_REPORTS;
