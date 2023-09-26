CREATE OR REPLACE VIEW EMRS_D_COUNTY_SV
AS
  SELECT NVL(plan_service_type_cd,'UNKNOWN') plan_service_type ,
    NULL sh_region ,
    NULL county_id ,
    CASE
      WHEN out_of_state_ind = 1
      THEN 'OT'
      ELSE 'WV'
    END state ,
    VALUE county_code ,
    attrib_fpis_code county_fips_code ,
    report_label county_name ,
    update_ts modified_date ,
    TO_CHAR(update_ts,'HH24MI') modified_time ,
    updated_by modified_name ,
    NULL vol ,
    CASE
      WHEN effective_end_date IS NULL
      AND maximus_serves_ind = 1
      THEN 'A'
      ELSE 'I'
    END status ,
    COALESCE(attrib_district_cd,'0') csdaid ,
    CASE
      WHEN plan_service_type_cd = 'STAR'
      THEN 'Y'
      ELSE 'N'
    END star ,
    CASE
      WHEN plan_service_type_cd = 'STARP'
      THEN 'Y'
      ELSE 'N'
    END starplus ,
    NULL public_health_code ,
    NULL source_record_id
  FROM eb.enum_county ec
  LEFT OUTER JOIN
    (SELECT DISTINCT plan_service_type_cd, 
      county_cd 
      FROM eb.contract_amendment ca
      JOIN eb.county_contract cc ON (cc.contract_amendment_id = ca.contract_amendment_id )
      JOIN eb.contract c ON (ca.contract_id = c.contract_id )
      WHERE c.end_date IS NULL 
      AND ca.end_date IS NULL 
      AND closed_to_enroll_ind = 0
    ) tmp_contract ON ec.VALUE = tmp_contract.county_cd; 
    
GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_COUNTY_SV TO EB_MAXDAT_REPORTS;