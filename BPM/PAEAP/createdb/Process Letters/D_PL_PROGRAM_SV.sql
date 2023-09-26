CREATE OR REPLACE VIEW D_PL_PROGRAM_SV
AS
  SELECT NULL source_record_id ,
    NULL program_id ,
    value program_code ,
    report_label program_name ,
    CASE
      WHEN effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END active_inactive ,
    effective_end_date end_date ,
    NULL program_category ,
    value managed_care_program ,
    effective_start_date start_date
  FROM enum_program_type;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PL_PROGRAM_SV TO EB_MAXDAT_REPORTS; 