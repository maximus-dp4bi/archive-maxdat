CREATE OR REPLACE VIEW d_pa_level_need_sv
AS
SELECT value level_of_need_code
       ,report_label level_of_need
FROM enum_mfp_code
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS level_of_need_code
      , 'Undefined' AS level_of_need
FROM DUAL;

GRANT SELECT ON D_PA_LEVEL_NEED_SV TO MAXDAT_REPORTS;
