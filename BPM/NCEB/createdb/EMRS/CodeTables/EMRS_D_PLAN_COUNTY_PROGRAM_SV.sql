CREATE OR REPLACE VIEW maxdat_support.EMRS_D_PLAN_COUNTY_PROGRAM_SV AS
SELECT distinct
  c.program_type_cd program_code,
    pl.plan_id,
    pl.plan_code,
    pl.plan_name,
    CCON.COUNTY_CD COUNTY_CODE
    ,pl.plan_type_cd
  FROM eb.plans pl
  JOIN eb.contract c            ON pl.plan_id = c.plan_id
  JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
  JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
  JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
  JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id
  WHERE 1=1
  AND ca.end_date IS NULL
  AND ca.status_cd = 'ACTIVE'
  AND c.end_date IS NULL
  order by  CCON.COUNTY_CD, PLAN_NAME
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_COUNTY_PROGRAM_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_COUNTY_PROGRAM_SV TO MAXDAT_REPORTS;