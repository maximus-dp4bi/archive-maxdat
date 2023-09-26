CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPECIALTY_SV
AS
  SELECT network_id provider_number ,
    create_ts date_created ,
    created_by ,
    NULL provider_specialty_code_id ,
    specialty_type_cd provider_specialty_code
  FROM network_specialty;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_PROVIDER_SPECIALTY_SV TO EB_MAXDAT_REPORTS; 