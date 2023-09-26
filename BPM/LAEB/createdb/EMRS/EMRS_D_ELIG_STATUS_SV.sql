DROP VIEW MAXDAT_SUPPORT.EMRS_D_ELIG_STATUS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_ELIG_STATUS_SV
AS
SELECT 
    e.value AS ELIGIBILITY_STATUS_CODE
    ,e.description AS ELIGIBILITY_STATUS
  FROM EB.ENUM_ENROLL_ELIGIBILITY_STATUS e
  UNION ALL
  SELECT 
    '0' AS ELIGIBILITY_STATUS_CODE
    ,'Not Defined' AS ELIGIBILITY_STATUS
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ELIG_STATUS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ELIG_STATUS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ELIG_STATUS_SV TO MAXDAT_SUPPORT_READ_ONLY;

