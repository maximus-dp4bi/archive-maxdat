CREATE OR REPLACE VIEW EMRS_D_PLAN_TYPE_SV
AS
  SELECT NULL plan_type_id ,
    NULL source_record_id ,
    pt.value managed_care_program ,
    p.value plan_type
  FROM enum_plan_type p
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_PLAN_TYPE_SV TO EB_MAXDAT_REPORTS; 