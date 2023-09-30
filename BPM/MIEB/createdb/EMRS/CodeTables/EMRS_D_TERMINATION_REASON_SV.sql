CREATE OR REPLACE VIEW EMRS_D_DISENROLL_REASON_SV
AS
 SELECT 
    spd.program_cd managed_care_program ,
    NULL source_record_id ,
    edr.value reason_code ,
    edr.description reason ,
    plan_name
  FROM &schema_name..enum_disenrollment_reason edr
  JOIN &schema_name..selection_prg_disenrol_reason spd ON edr.value = spd.disenroll_reason_cd
  JOIN (SELECT DISTINCT plan_code plan_name, program_type_cd 
      FROM &schema_name..plans p, &schema_name..contract c 
      WHERE p.plan_id = c.plan_id
    ) tmp_plans ON tmp_plans.program_type_cd = spd.program_cd 
  UNION
   SELECT 
    'MEDICAID' managed_care_program ,
    NULL source_record_id ,
    '0' reason_code ,
    'Not Defined' reason ,
    plan_name
  FROM (SELECT DISTINCT plan_code plan_name, program_type_cd 
      FROM &schema_name..plans p, &schema_name..contract c 
      WHERE p.plan_id = c.plan_id  )   ; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV TO MAXDAT_REPORTS;  
