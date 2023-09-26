 SELECT NULL term_reason_code_id
      ,spd.program_cd managed_care_program
      ,NULL source_record_id
      ,edr.value reason_code
      ,edr.description reason      
      ,plan_name
  FROM enum_disenrollment_reason edr
    INNER JOIN selection_prg_disenrol_reason spd
      ON edr.value = spd.disenroll_reason_cd
    INNER JOIN (SELECT DISTINCT plan_code plan_name, program_type_cd
                FROM plans p, contract c
                WHERE p.plan_id = c.plan_id
                AND end_date IS NULL
                AND status_cd = 'ACTIVE' ) tmp_plans
      ON tmp_plans.program_type_cd = spd.program_cd