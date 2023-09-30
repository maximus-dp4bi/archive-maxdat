CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPECIALTY_SV
AS
  SELECT network_id provider_number ,
    create_ts date_created ,
    created_by ,
    NULL provider_specialty_code_id ,
    specialty_type_cd provider_specialty_code,
    SPECIALTY_EXT_CD
  FROM network_specialty;
  
  GRANT SELECT ON EMRS_D_PROVIDER_SPECIALTY_SV TO MAXDAT_REPORTS; 
  
--  SELECT * FROM EB.NETWORK_SPECIALTY
