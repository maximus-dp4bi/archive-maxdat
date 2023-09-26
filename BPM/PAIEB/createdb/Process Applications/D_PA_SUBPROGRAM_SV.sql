CREATE OR REPLACE VIEW d_pa_subprogram_sv
AS
SELECT value subprogram_code
      ,report_label subprogram
FROM enum_subprogram_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' subprogram_code
      ,'Undefined' subprogram
FROM dual  ;

GRANT SELECT ON D_PA_SUBPROGRAM_SV TO MAXDAT_REPORTS;