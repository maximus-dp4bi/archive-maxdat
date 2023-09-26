DROP VIEW MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV
AS
SELECT 
    ee.value ENROLLMENT_ERROR_CODE ,
    ee.description ENROLLMENT_ERROR 
  FROM eb.enum_enrollment_error_code ee
  UNION
  SELECT 
    '0' ENROLLMENT_ERROR_CODE ,
    'Not Defined' ENROLLMENT_ERROR 
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV TO MAXDAT_SUPPORT_READ_ONLY;
