CREATE OR REPLACE VIEW d_pa_document_type_sv
AS
SELECT value document_type_cd
      ,report_label document_type
FROM ats.enum_document_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS document_type_cd
      , 'Undefined' AS document_type
FROM DUAL;

GRANT SELECT ON d_pa_document_type_sv TO MAXDAT_REPORTS;