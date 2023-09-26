CREATE OR REPLACE VIEW EMRS_D_COUNTY_SV
AS
select 
    COUNTY_CODE ,
     COUNTY_NAME ,
    PLAN_SERVICE_TYPE ,
    COUNTY_FIPS_CODE ,
    CSDA_CODE ,
    STATE ,
    STATUS ,
    MODIFIED_DATE ,
    MODIFIED_TIME ,
    MODIFIED_NAME 
    ,COUNTY_LATITUDE
    ,COUNTY_LONGITUDE
 from (
SELECT
    ec.value COUNTY_CODE ,
    ec.report_label COUNTY_NAME ,
    NVL(c.plan_service_type_cd,'UNKNOWN') PLAN_SERVICE_TYPE ,
    ec.attrib_fpis_code COUNTY_FIPS_CODE ,
    COALESCE(ec.attrib_district_cd, '-1') AS CSDA_CODE,
    'NC' AS STATE,
    CASE
      WHEN ec.effective_end_date IS NULL
      AND ec.maximus_serves_ind = 1
      THEN 'A'
      ELSE 'I'
    END STATUS ,
    ec.update_ts MODIFIED_DATE ,
    TO_CHAR(ec.update_ts,'HH24MI') MODIFIED_TIME ,
    ec.updated_by MODIFIED_NAME
  , CL.LATITUDE COUNTY_LATITUDE
  , CL.LONGITUDE COUNTY_LONGITUDE
  , row_number() over (partition by ec.value order by c.plan_service_type_cd desc) rown
  FROM EB.enum_county ec
  LEFT JOIN MAXDAT_SUPPORT.EMRS_D_COUNTY_LOCATIONS CL ON CL.COUNTY_CODE = ec.value
  LEFT OUTER JOIN
    (SELECT DISTINCT c.plan_service_type_cd,
      cc.county_cd
      FROM EB.contract_amendment ca
      JOIN EB.county_contract cc ON (cc.contract_amendment_id = ca.contract_amendment_id )
      JOIN EB.contract c ON (ca.contract_id = c.contract_id )
      WHERE c.end_date IS NULL
      AND (ca.end_date IS NULL or ca.end_date >= to_date('1/1/9999','mm/dd/yyyy'))
      AND ca.status_cd = 'ACTIVE'
      AND closed_to_enroll_ind = 0
    ) c ON ec.VALUE = c.county_cd
  WHERE ec.effective_end_date IS NULL
--  and county_cd = 101
--  AND ec.maximus_serves_ind = 1
) where rown = 1
UNION ALL
SELECT 
    '0' AS COUNTY_CODE ,
    'UNKNOWN' AS COUNTY_NAME ,
    'UNKNOWN' AS PLAN_SERVICE_TYPE ,
    NULL AS COUNTY_FIPS_CODE ,
    '-1' AS CSDA_CODE ,
    'NA' AS STATE ,
    NULL AS STATUS ,
    NULL AS MODIFIED_DATE ,
    NULL AS MODIFIED_TIME ,
    NULL AS MODIFIED_NAME 
    , null COUNTY_LATITUDE
    , null COUNTY_LONGITUDE
    FROM DUAL
;
GRANT SELECT ON EMRS_D_COUNTY_SV TO MAXDATSUPPORT_READ_ONLY;   
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_COUNTY_SV TO MAXDAT_REPORTS;
