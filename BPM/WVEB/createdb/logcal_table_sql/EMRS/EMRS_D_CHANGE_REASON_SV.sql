    SELECT NULL change_reason_id
       ,'MEDICAID' managed_care_program 
       ,NULL source_record_id
       ,edr.value change_reason_code
        ,edr.description change_reason
        ,change_reason_code_plan
    FROM eb.enum_disenrollment_reason edr
      CROSS JOIN (SELECT DISTINCT plan_code change_reason_code_plan, program_type_cd
                  FROM eb.plans p, eb.contract c
                  WHERE p.plan_id = c.plan_id
                  AND end_date IS NULL
                  AND status_cd = 'ACTIVE' 
                  AND program_type_cd = 'MEDICAID') tmp_plans