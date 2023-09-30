CREATE OR REPLACE VIEW EMRS_D_RISK_GROUP_SV
AS
  SELECT 
    NULL AS MANAGED_CARE_PROGRAM ,
    NULL AS SOURCE_RECORD_ID ,
    NULL AS RISK_GROUP_CODE ,
    NULL AS RISK_GROUP
  FROM dual; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RISK_GROUP_SV TO MAXDAT_REPORTS; 