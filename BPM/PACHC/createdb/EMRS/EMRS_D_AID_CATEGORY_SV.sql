CREATE OR REPLACE VIEW EMRS_D_AID_CATEGORY_SV
AS
  SELECT
    value AS AID_CATEGORY_CODE ,
    description AS AID_CATEGORY_NAME,
    CASE
      WHEN effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END AS ACTIVE_INACTIVE ,
    COALESCE(effective_start_date, TO_DATE('01/01/1900','MM/DD/YYYY'))AS START_DATE ,
    COALESCE(effective_end_date,TO_DATE('12/31/2050','MM/DD/YYYY')) AS END_DATE,
    COALESCE(scope,'MEDICAID') AS MANAGED_CARE_PROGRAM,
    COALESCE(subprogram_codes, 'UD') AS SUBPROGRAM_CODE
  FROM ats.enum_aid_category 
  UNION  
  SELECT 
     '0' AS AID_CATEGORY_CODE,
     'Not Defined' AS AID_CATEGORY_NAME  ,
    'A' AS ACTIVE_INACTIVE,
     TO_DATE('01/01/1900','MM/DD/YYYY') START_DATE,
     TO_DATE('12/31/2050','MM/DD/YYYY') AS END_DATE,
     'MEDICAID' AS MANAGED_CARE_PROGRAM,
     'UD' AS SUBPROGRAM_CODE
  FROM DUAL ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AID_CATEGORY_SV TO MAXDAT_REPORTS;