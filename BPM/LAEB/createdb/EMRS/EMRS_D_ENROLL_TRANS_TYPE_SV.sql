DROP VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV
AS
SELECT 
    et.value AS ENROLLMENT_TRANS_TYPE_CODE ,
    et.description AS ENROLLMENT_TRANS_TYPE
  FROM EB.ENUM_ENROLLMENT_TRANS_TYPE et
  UNION ALL
  SELECT 
    'AutoTransfer' AS ENROLLMENT_TRANS_TYPE_CODE
    ,'Auto Transfer' AS ENROLLMENT_TRANS_TYPE
  FROM DUAL
  UNION ALL
  SELECT 
    'NotDefined' AS ENROLLMENT_TRANS_TYPE_CODE
    ,'Not Defined' AS ENROLLMENT_TRANS_TYPE
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV TO MAXDAT_SUPPORT_READ_ONLY;