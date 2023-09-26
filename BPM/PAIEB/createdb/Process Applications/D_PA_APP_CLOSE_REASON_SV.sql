CREATE OR REPLACE VIEW d_pa_app_close_reason_sv
AS
SELECT value close_reason_code
       ,report_label close_reason
FROM enum_app_close_reason
WHERE effective_End_date IS NULL
UNION ALL
SELECT 'UD' AS close_reason_code
      , 'Undefined' AS close_reason
FROM DUAL;

GRANT SELECT ON D_PA_APP_CLOSE_REASON_SV TO MAXDAT_REPORTS;
