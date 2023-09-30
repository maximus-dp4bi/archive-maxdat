CREATE OR REPLACE VIEW EMRS_D_ENROLL_TRANS_TYPE_SV
 AS    
  SELECT 
    et.value AS ENROLLMENT_TRANS_TYPE_CODE ,
    et.description AS ENROLLMENT_TRANS_TYPE
  FROM ENUM_ENROLLMENT_TRANS_TYPE et
  UNION ALL
  SELECT 
    'NotDefined' AS ENROLLMENT_TRANS_TYPE_CODE
    ,'Not Defined' AS ENROLLMENT_TRANS_TYPE
  FROM DUAL;

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV TO MAXDAT_REPORTS;  
  
  
  