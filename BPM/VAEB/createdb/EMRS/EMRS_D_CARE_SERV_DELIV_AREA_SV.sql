CREATE OR REPLACE VIEW EMRS_D_CARE_SERV_DELIV_AREA_SV
AS
  SELECT 
    'MEDICAID' managed_care_program ,
    VALUE csda_code ,
    DESCRIPTION csda_name ,
    NULL region_number_category ,
    CASE
      WHEN effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END status ,
    NULL source_record_id ,
    create_ts record_date ,
    TO_CHAR(create_ts,'HH24MI') record_time ,
    created_by record_name ,
    update_ts modified_date ,
    updated_by modified_name ,
    'N' starplus ,
    effective_start_date implementation_date ,
    TO_CHAR(update_ts,'HH24MI') modified_time
  FROM enum_district
  UNION ALL
  SELECT 
    'MEDICAID' managed_care_program ,
    '-1' csda_code ,
    'Not Defined' csda_name ,
    NULL region_number_category ,
    'A' status ,
    NULL source_record_id ,
    NULL record_date ,
    NULL record_time ,
    NULL record_name ,
    NULL modified_date ,
    NULL modified_name ,
    'N' starplus ,
    NULL implementation_date ,
    NULL modified_time
    FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CARE_SERV_DELIV_AREA_SV TO MAXDAT_REPORTS;