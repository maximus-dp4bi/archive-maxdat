CREATE OR REPLACE VIEW EMRS_D_RACE_SV
AS
  SELECT 
    r.value race_code,
    r.value source_record_id,
    pt.value managed_care_program ,
    r.description race_description
  FROM enum_race r,
    enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION
  SELECT 
    '0' race_code,
    '0' source_record_id,
    'MEDICAID' managed_care_program ,
    'Not Defined' race_description
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RACE_SV TO EB_MAXDAT_REPORTS; 