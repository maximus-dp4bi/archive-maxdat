drop view D_PI_PLAN_SV;
CREATE OR REPLACE VIEW D_PI_PLAN_SV
AS
  SELECT pl.plan_id,    
    pl.plan_code,    
    pl.plan_id_ext,
    pl.plan_name,
    pl.dba_name plan_abbreviation    
  FROM eb.plans pl 
UNION
  SELECT 0 plan_id,
    '0' plan_code,
    '0' plan_id_ext,
    'Not Defined' plan_name,
    'Not Defined' plan_abbreviation    
 FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_PLAN_SV TO MAXDAT_REPORTS; 
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_PLAN_SV TO MAXDATSUPPORT_READ_ONLY; 