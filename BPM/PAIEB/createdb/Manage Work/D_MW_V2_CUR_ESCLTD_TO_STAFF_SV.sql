CREATE OR REPLACE VIEW D_MW_V2_CUR_ESCLTD_TO_STAFF_SV
AS
  SELECT UPDATE_TS ,
      CREATE_TS ,
      END_DATE ,
      START_DATE ,
      ext_staff_number AS staff_id ,
      MIDDLE_NAME ,
      FIRST_NAME ,
      EXT_STAFF_NUMBER ,
      LAST_NAME
  FROM staff 
  UNION
  SELECT UPDATE_TS ,
      CREATE_TS ,
      END_DATE ,
      START_DATE ,
      TO_CHAR(staff_id) AS staff_id ,
      MIDDLE_NAME ,
      FIRST_NAME ,
      EXT_STAFF_NUMBER ,
      LAST_NAME
  FROM staff
UNION  
  SELECT to_date('01/01/1985', 'mm/dd/yyyy') AS UPDATE_TS ,
    to_date('01/01/1985', 'mm/dd/yyyy') AS CREATE_TS ,
    to_date('01/01/1985', 'mm/dd/yyyy') AS END_DATE ,
    to_date('01/01/1985', 'mm/dd/yyyy') AS START_DATE ,
    '0' AS STAFF_ID ,
    NULL AS MIDDLE_NAME ,
    NULL AS FIRST_NAME ,
    NULL AS EXT_STAFF_NUMBER ,
    NULL AS LAST_NAME
  FROM DUAL ; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_MW_V2_CUR_ESCLTD_TO_STAFF_SV TO MAXDAT_REPORTS ;