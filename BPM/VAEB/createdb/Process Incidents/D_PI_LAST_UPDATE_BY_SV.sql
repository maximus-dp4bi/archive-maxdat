CREATE OR REPLACE VIEW D_PI_LAST_UPDATE_BY_SV
AS
  SELECT staff_id DPIUB_ID ,
    last_name||','||first_name LAST_UPDATE_BY_NAME
  FROM eb.staff
  WHERE staff_type_cd = 'PROJECT_STAFF' ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_LAST_UPDATE_BY_SV TO MAXDAT_REPORTS ; 