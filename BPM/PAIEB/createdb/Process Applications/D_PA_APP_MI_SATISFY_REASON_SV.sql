CREATE OR REPLACE VIEW d_pa_app_mi_satisfy_reason_sv
AS
SELECT value satisfied_reason_cd
      ,report_label satisfied_reason
FROM ats.enum_app_mi_satisfy_reason
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS satisfied_reason_cd
      , 'Undefined' AS satisfied_reason
FROM DUAL;

GRANT SELECT ON d_pa_app_mi_satisfy_reason_sv TO MAXDAT_REPORTS;