DROP VIEW MAXDAT_SUPPORT.LAEB_413_REPORT_OE_ELIG_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.LAEB_413_REPORT_OE_ELIG_SV
AS
select OE_ELIG_MEMBER_CNT AS OE_ELIG_MEMBER_COUNT,
   REGION_ID AS REGION_ID,
   REGION_NAME AS REGION_NAME,
   REPORT_YEAR AS REPORT_YEAR
FROM MAXDAT_SUPPORT.LAEB_413_REPORT_OE_ELIG;

GRANT SELECT ON MAXDAT_SUPPORT.LAEB_413_REPORT_OE_ELIG_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.LAEB_413_REPORT_OE_ELIG_SV TO MAXDATSUPPORT_READ_ONLY;
