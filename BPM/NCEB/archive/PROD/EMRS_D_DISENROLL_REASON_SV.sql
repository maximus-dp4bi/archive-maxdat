CREATE OR REPLACE VIEW EMRS_D_DISENROLL_REASON_SV
AS
 SELECT distinct
    spd.program_cd managed_care_program ,
    NULL source_record_id ,
    edr.value reason_cd ,
	edr.REPORT_LABEL reason_desc
    , case when edr.scope = 'WITHCAUSE' then 'WITHCAUSE' else 'WITHOUTCAUSE' end DISENROLL_TYPE_CD
    , case when value in ('NFPHPCR03', 'NFPHPCR04','NFPHPCR06', 'NFPHPCR08',  'NFPHPCR09', 'NFPHPCR11') then 'Y' else 'N' end urgent
    , case when value in ('NFPHPCR02','NFPHPCR22-1') then 'Y' else 'N' end PHP_INITIATED
--    plan_name
  FROM EB.enum_disenrollment_reason edr
  JOIN EB.selection_prg_disenrol_reason spd ON edr.value = spd.disenroll_reason_cd
  JOIN (SELECT DISTINCT plan_code plan_name, program_type_cd 
      FROM EB.plans p, EB.contract c 
      WHERE p.plan_id = c.plan_id
    ) tmp_plans ON tmp_plans.program_type_cd = spd.program_cd 
;  
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV TO MAXDATSUPPORT_READ_ONLY;

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV TO MAXDAT_REPORTS;  
