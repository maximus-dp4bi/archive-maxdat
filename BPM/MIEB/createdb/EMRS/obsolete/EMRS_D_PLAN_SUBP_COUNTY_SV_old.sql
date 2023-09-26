CREATE OR REPLACE VIEW EMRS_D_PLAN_SUBP_COUNTY_SV
AS
  SELECT distinct 
    pl.plan_id,
    pl.plan_code,
    pl.plan_name,
    case when eaid.subprogram_codes = 'MC' then 'MED' else eaid.subprogram_codes end subprogram_code
      , ECON.VALUE COUNTY_CODE
      , ECON.REPORT_LABEL COUNTY_NAME
  FROM eb.plans pl
  JOIN eb.contract c            ON pl.plan_id = c.plan_id
  JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
  JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
  JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
  JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id
  JOIN EB.ENUM_COUNTY ECON ON ECON.VALUE = CCON.COUNTY_CD
  WHERE 1=1
  AND ca.end_date IS NULL
  AND ca.status_cd = 'ACTIVE'
  AND c.end_date IS NULL
  AND ECON.effective_end_date  IS NULL
  order by  COUNTY_CODE, PLAN_NAME;
    
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SUBP_COUNTY_SV TO MAXDAT_REPORTS;
