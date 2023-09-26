CREATE OR REPLACE VIEW d_pa_length_care_sv
AS
SELECT value length_care_code
       ,report_label length_care
FROM enum_length_care
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS length_care_code
      , 'Undefined' AS length_care
FROM DUAL;

GRANT SELECT ON D_PA_LENGTH_CARE_SV TO MAXDAT_REPORTS;
