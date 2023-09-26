CREATE OR REPLACE VIEW d_pa_enroll_delayed_reason_sv
AS
SELECT r.value enroll_delayed_reason_cd
       ,r.report_label enroll_delayed_reason
FROM ENUM_ENROLL_DELAYED_REASON r
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS enroll_delayed_reason_cd
      , 'Undefined' AS enroll_delayed_reason
FROM DUAL;

GRANT SELECT ON D_PA_ENROLL_DELAYED_REASON_SV TO MAXDAT_REPORTS;