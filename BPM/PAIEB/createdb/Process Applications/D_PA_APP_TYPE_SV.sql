CREATE OR REPLACE VIEW d_pa_app_type_sv
AS
SELECT value app_type_code
      ,report_label app_type
FROM enum_app_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS app_type_code
      , 'Undefined' AS app_type
FROM DUAL;

GRANT SELECT ON D_PA_APP_TYPE_SV TO MAXDAT_REPORTS;