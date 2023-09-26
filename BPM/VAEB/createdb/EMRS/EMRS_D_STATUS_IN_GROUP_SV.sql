CREATE OR REPLACE VIEW EMRS_D_STATUS_IN_GROUP_SV
AS
  SELECT NULL AS SOURCE_RECORD_ID ,
    NULL AS STATUS_IN_GROUP ,
    NULL AS STATUS_IN_GROUP_CATEGORY ,
    NULL AS MANAGED_CARE_PROGRAM ,
    NULL AS STATUS_IN_GROUP_CODE
  FROM dual; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_STATUS_IN_GROUP_SV TO MAXDAT_REPORTS;  