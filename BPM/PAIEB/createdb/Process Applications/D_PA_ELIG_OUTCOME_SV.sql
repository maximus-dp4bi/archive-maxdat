CREATE OR REPLACE VIEW d_pa_elig_outcome_sv
AS
SELECT value elig_outcome_cd
      ,report_label elig_outcome
FROM ats.enum_elig_outcome
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS elig_outcome_cd
      , 'Undefined' AS elig_outcome
FROM DUAL;

GRANT SELECT ON d_pa_elig_outcome_sv TO MAXDAT_REPORTS;