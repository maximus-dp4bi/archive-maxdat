CREATE OR REPLACE VIEW EMRS_D_PHONE_TYPE_SV
AS
SELECT value AS PHON_TYPE_CD
      ,report_label AS PHONE_TYPE
FROM eb.enum_phone_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS PHONE_TYP_CD
      , 'Undefined' AS PHONE_TYPE
FROM DUAL;

GRANT SELECT ON EMRS_D_PHONE_TYPE_SV TO MAXDAT_REPORTS;
