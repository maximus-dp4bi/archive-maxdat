DROP VIEW MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV
AS
SELECT 
    l.value AS LANGUAGE_CD,
    l.report_label AS LANGUAGE,
    l.effective_start_date AS EFFECTIVE_START_DATE,
    l.effective_end_date AS EFFECTIVE_END_DATE
  FROM EB.ENUM_LANGUAGE l;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV TO MAXDAT_SUPPORT_READ_ONLY;