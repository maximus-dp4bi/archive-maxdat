CREATE OR REPLACE VIEW EMRS_D_COUNTY_SV
AS
  SELECT 
    ec.value COUNTY_CODE ,
    ec.report_label COUNTY_NAME ,
    NVL(c.plan_service_type_cd,'UNKNOWN') PLAN_SERVICE_TYPE ,
    ec.attrib_fpis_code COUNTY_FIPS_CODE ,
    COALESCE(ec.attrib_district_cd, '-1') AS PA_DISTRICT_ID,
    'CO' AS STATE,
    CASE
      WHEN ec.effective_end_date IS NULL
      AND ec.maximus_serves_ind = 1
      THEN 'A'
      ELSE 'I'
    END STATUS ,
    ec.update_ts MODIFIED_DATE ,
    TO_CHAR(ec.update_ts,'HH24MI') MODIFIED_TIME ,
    ec.updated_by MODIFIED_NAME 
  FROM &schema_name..enum_county ec
  LEFT OUTER JOIN
    (SELECT DISTINCT c.plan_service_type_cd, 
      cc.county_cd 
      FROM &schema_name..contract_amendment ca
      JOIN &schema_name..county_contract cc ON (cc.contract_amendment_id = ca.contract_amendment_id )
      JOIN &schema_name..contract c ON (ca.contract_id = c.contract_id )
      WHERE c.end_date IS NULL 
      AND ca.end_date IS NULL 
      AND ca.status_cd = 'ACTIVE'
      AND closed_to_enroll_ind = 0
    ) c ON ec.VALUE = c.county_cd
  WHERE ec.effective_end_date IS NULL  
  AND ec.maximus_serves_ind = 1
UNION ALL
SELECT 
    '0' AS COUNTY_CODE ,
    'UNKNOWN' AS COUNTY_NAME ,
    'UNKNOWN' AS PLAN_SERVICE_TYPE ,
    NULL AS COUNTY_FIPS_CODE ,
    '-1' AS PA_DISTRICT_ID ,
    'NA' AS STATE ,
    NULL AS STATUS ,
    NULL AS MODIFIED_DATE ,
    NULL AS MODIFIED_TIME ,
    NULL AS MODIFIED_NAME 
FROM DUAL
;
    
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_COUNTY_SV TO MAXDAT_REPORTS;
