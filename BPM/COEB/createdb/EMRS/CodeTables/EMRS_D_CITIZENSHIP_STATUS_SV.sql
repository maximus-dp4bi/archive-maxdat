CREATE OR REPLACE VIEW EMRS_D_CITIZENSHIP_STATUS_SV
AS
  SELECT e.value citizenship_code,
  e.description citizenship_description    
  FROM &schema_name..enum_citizen e
  UNION
  SELECT '0' citizenship_code,
  'Not Defined' citizenship_description   
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CITIZENSHIP_STATUS_SV TO MAXDAT_REPORTS; 