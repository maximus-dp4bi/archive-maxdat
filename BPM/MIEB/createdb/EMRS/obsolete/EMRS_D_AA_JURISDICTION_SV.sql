CREATE OR REPLACE VIEW EMRS_D_AA_JURISDICTION_SV AS
SELECT jurisdiction county_code
       , county_name
       ,region_cd
       ,factor_value2 group_number
       ,factor_value plan_code
       ,p.plan_id
       ,p.plan_name
       ,p.subprogram_code
       ,p.plan_type_cd
       ,factor_number group_percentage
       ,factor_number3 capacity
       ,factor_number4 current_enrollment
       ,CASE WHEN j.factor_value2 = '1' AND factor_number4  < factor_number3 THEN factor_value2 END plan_group1_notat_capacity
       ,CASE WHEN j.factor_value2 = '2' AND factor_number4  < factor_number3 THEN factor_value2 END plan_group2_notat_capacity
       ,CASE WHEN j.factor_value2 = '3' AND factor_number4  < factor_number3 THEN factor_value2 END plan_group3_notat_capacity
FROM jurisdiction_factor j
  JOIN (SELECT DISTINCT pl.plan_id,pl.plan_code, pl.plan_name, CASE WHEN eaid.subprogram_codes = 'MC' THEN 'MED' ELSE eaid.subprogram_codes END subprogram_code
              ,esub.report_label subprogram_name
              ,ccon.county_cd
              , ec.report_label county_name
              ,ec.attrib_district_cd region_cd
              ,pl.plan_type_cd
        FROM eb.plans pl
         JOIN eb.contract c ON pl.plan_id = c.plan_id
         JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
         JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
         JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
         JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id
         join eb.enum_county ec on ec.value = ccon.county_cd
         JOIN eb.enum_subprogram_type esub on esub.value = CASE WHEN eaid.subprogram_codes = 'MC' THEN 'MED' ELSE eaid.subprogram_codes END
        WHERE 1=1
        AND ca.end_date IS NULL
        AND ca.status_cd = 'ACTIVE'
        AND c.end_date IS NULL
) P ON (j.factor_value = p.plan_code  AND j.jurisdiction = p.county_cd)
where jurisdiction_type = 'COUNTY'
AND factor_name = 'AA_PERCENT'
AND factor_value2 IS NOT NULL;
    
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AA_JURISDICTION_SV TO MAXDAT_REPORTS;
