CREATE OR REPLACE VIEW d_pa_app_mi_type_sv
AS
SELECT value mi_type_cd
      ,report_label mi_type
FROM ats.enum_app_mi_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS mi_type_cd
      , 'Undefined' AS mi_type
FROM DUAL;

GRANT SELECT ON d_pa_app_mi_type_sv TO MAXDAT_REPORTS;