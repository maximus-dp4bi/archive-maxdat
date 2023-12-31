DROP VIEW MAXDAT_SUPPORT.EMRS_D_TYPE_CASE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_TYPE_CASE_SV
AS
SELECT 
    r.value AS TYPE_CASE_CODE,
    r.description AS TYPE_CASE_DESCRIPTION
  FROM eb.ENUM_TYPE_CASE_CODE r;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TYPE_CASE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TYPE_CASE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TYPE_CASE_SV TO MAXDAT_SUPPORT_READ_ONLY;
