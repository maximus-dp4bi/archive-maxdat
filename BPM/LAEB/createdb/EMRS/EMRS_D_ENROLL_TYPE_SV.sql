DROP VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_TYPE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_TYPE_SV
AS
SELECT 
    et.value AS ENROLLMENT_TYPE_CODE ,
    et.description AS ENROLLMENT_TYPE,
    et.order_by_default AS ORDER_BY_DEFAULT
  FROM EB.ENUM_ENROLL_TYPE et
  UNION ALL
  SELECT 
    'NotDefined' AS ENROLLMENT_TYPE_CODE
    ,'Not Defined' AS ENROLLMENT_TYPE
    , 50 AS ORDER_BY_DEFAULT
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TYPE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TYPE_SV TO MAXDAT_SUPPORT_READ_ONLY;
