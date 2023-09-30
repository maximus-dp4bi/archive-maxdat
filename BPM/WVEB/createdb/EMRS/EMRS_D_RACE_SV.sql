CREATE OR REPLACE VIEW EMRS_D_RACE_SV
AS
  SELECT NULL race_id,
    r.value race_code,
    r.value source_record_id,
    pt.value managed_care_program ,
    r.description race_description
  FROM enum_race r,
    enum_program_type pt
  WHERE pt.effective_end_date IS NULL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_RACE_SV TO EB_MAXDAT_REPORTS; 