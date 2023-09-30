CREATE OR REPLACE VIEW d_pa_elig_outcome_reason_sv
AS
SELECT value elig_outcome_reason_cd
      ,report_label elig_outcome_reason
FROM ats.enum_elig_outcome_reason
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS elig_outcome_reason_cd
      , 'Undefined' AS elig_outcome_reason
FROM DUAL;

GRANT SELECT ON d_pa_elig_outcome_reason_sv TO MAXDAT_REPORTS;