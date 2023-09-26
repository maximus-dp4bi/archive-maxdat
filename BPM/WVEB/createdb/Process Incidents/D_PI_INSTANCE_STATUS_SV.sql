CREATE OR REPLACE VIEW D_PI_INSTANCE_STATUS_SV
AS
  SELECT 346 DPIIS_ID , 'Complete' INSTANCE_STATUS FROM DUAL
  UNION
  SELECT 345 , 'Active' FROM dual ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.D_PI_INSTANCE_STATUS_SV TO EB_MAXDAT_REPORTS ; 