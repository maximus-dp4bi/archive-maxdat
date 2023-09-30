CREATE OR REPLACE VIEW D_EMRS_ADDR_TYPE_SV
AS
SELECT value addr_type_cd
      ,report_label addr_type
FROM eb.enum_address_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS addr_type_cd
      , 'Undefined' AS addr_type
FROM DUAL;

GRANT SELECT ON D_EMRS_ADDR_TYPE_SV TO EB_MAXDAT_REPORTS;