CREATE OR REPLACE VIEW EMRS_D_COUNTY_SV
AS
SELECT
    NULL sh_region ,   
    CASE
      WHEN out_of_state_ind = 1
      THEN 'OT'
      ELSE 'MI'
    END state ,
    VALUE county_code ,
    value || ' - ' || report_label county_label,
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
    'N' star ,
    'N' starplus ,
    NULL public_health_code ,
    NULL source_record_id
  FROM eb.enum_county ec 
  WHERE ec.effective_end_date is null 
  and out_of_state_ind <> 1    
/*UNION ALL
SELECT NULL sh_region ,
    'NA' AS state ,
    '0' AS county_code ,
    '0 - UNKNOWN' county_label,
    NULL county_fips_code ,
    'UNKNOWN' AS county_name ,
    NULL AS modified_date ,
    NULL AS modified_time ,
    NULL AS modified_name ,
    NULL vol ,
    NULL AS status ,
    '-1' AS csdaid ,
    'N' AS star ,
    'N' AS starplus ,
    NULL public_health_code ,
    NULL source_record_id
FROM DUAL
*/; 
    
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_COUNTY_SV TO MAXDAT_REPORTS;
