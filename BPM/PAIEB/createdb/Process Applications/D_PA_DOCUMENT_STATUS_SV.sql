CREATE OR REPLACE VIEW d_pa_document_status_sv
AS
SELECT value doc_status_cd
      ,report_label doc_status
FROM ats.enum_document_status
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS doc_status_cd
      , 'Undefined' AS doc_status
FROM DUAL;

GRANT SELECT ON d_pa_document_status_sv TO MAXDAT_REPORTS;