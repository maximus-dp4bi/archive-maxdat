CREATE OR REPLACE VIEW D_MW_V2_CUR_FWD_BY_STAFF_SV
AS
  SELECT to_date('01/01/1985') AS UPDATE_TS ,
    to_date('01/01/1985') AS CREATE_TS ,
    to_date('01/01/1985') AS END_DATE ,
    to_date('01/01/1985') AS START_DATE ,
    12345 AS STAFF_ID ,
    'MIDDLE_NAME' AS MIDDLE_NAME ,
    'FIRST_NAME' AS FIRST_NAME ,
    'EXT_STAFF_NUMBER' AS EXT_STAFF_NUMBER ,
    'LAST_NAME' AS LAST_NAME
  FROM DUAL ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_MW_V2_CUR_FWD_BY_STAFF_SV TO MAXDAT_REPORTS ;