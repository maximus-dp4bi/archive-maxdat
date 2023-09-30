CREATE OR REPLACE VIEW d_pa_document_source_sv
AS
SELECT value doc_source_code
      ,report_label doc_source
FROM enum_document_source
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS doc_source_code
      , 'Undefined' AS doc_source
FROM DUAL;

GRANT SELECT ON D_PA_DOCUMENT_SOURCE_SV TO MAXDAT_REPORTS;