CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPECIALTY_SV
AS
  SELECT network_id provider_number ,
    create_ts date_created ,
    created_by ,
    specialty_type_cd provider_specialty_code
  FROM network_specialty;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_SPECIALTY_SV TO EB_MAXDAT_REPORTS; 