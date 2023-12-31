CREATE OR REPLACE VIEW EMRS_D_ELIG_STATUS_SV
AS
  SELECT 
    e.value AS ELIGIBILITY_STATUS_CODE
    ,e.description AS ELIGIBILITY_STATUS
  FROM &schema_name..ENUM_ENROLL_ELIGIBILITY_STATUS e
  UNION ALL
  SELECT 
    '0' AS ELIGIBILITY_STATUS_CODE
    ,'Not Defined' AS ELIGIBILITY_STATUS
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ELIG_STATUS_SV TO MAXDAT_REPORTS; 