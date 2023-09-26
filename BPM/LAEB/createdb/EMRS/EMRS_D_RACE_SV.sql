DROP VIEW MAXDAT_SUPPORT.EMRS_D_RACE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_RACE_SV
AS
SELECT 
    r.value AS RACE_CODE,
    r.description AS RACE_DESCRIPTION
  FROM eb.enum_race r;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RACE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RACE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RACE_SV TO MAXDAT_SUPPORT_READ_ONLY;
