CREATE OR REPLACE VIEW d_pa_reason_delay_sv
AS
SELECT r.value reason_delay_code
       ,r.report_label reason_delay
       ,CASE WHEN r.value IN ('1','2','3','4','5') THEN 'Delayed Enrollment'
          ELSE 'Delay Excuse'
          END AS reason_delay_group
FROM enum_reason_delay_code r
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS reason_delay_code
      , 'Undefined' AS reason_delay
      , 'Undefined' AS reason_delay_group
FROM DUAL;

GRANT SELECT ON D_PA_REASON_DELAY_SV TO MAXDAT_REPORTS;