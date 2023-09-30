CREATE OR REPLACE VIEW EMRS_D_TERMINATION_REASON_SV
AS
  SELECT NULL term_reason_code_id ,
    spd.program_cd managed_care_program ,
    NULL source_record_id ,
    edr.value reason_code ,
    edr.description reason ,
    plan_name
  FROM enum_disenrollment_reason edr
  JOIN selection_prg_disenrol_reason spd ON edr.value = spd.disenroll_reason_cd
  JOIN (SELECT DISTINCT plan_code plan_name, program_type_cd 
      FROM plans p, contract c 
      WHERE p.plan_id = c.plan_id AND end_date IS NULL AND status_cd = 'ACTIVE'
    ) tmp_plans ON tmp_plans.program_type_cd = spd.program_cd ; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_TERMINATION_REASON_SV TO EB_MAXDAT_REPORTS;  