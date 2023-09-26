CREATE OR REPLACE VIEW d_pa_addr_type_sv
AS
SELECT value addr_type_cd
      ,report_label addr_type
FROM ats.enum_address_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS addr_type_cd
      , 'Undefined' AS addr_type
FROM DUAL;

GRANT SELECT ON d_pa_addr_type_sv TO MAXDAT_REPORTS;