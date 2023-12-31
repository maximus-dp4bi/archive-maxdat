CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SV
AS
  SELECT nw.network_id AS PROVIDER_NUMBER ,
    nw.network_id AS SOURCE_RECORD_ID ,
    COALESCE(nw.provider_id_ext,p.provider_id_ext,'0') AS PROVIDER_CODE ,
    'MEDICAID' AS MANAGED_CARE_PROGRAM ,
    NULL AS PLAN_ID ,
    p.title AS PROVIDER_TITLE ,
    nw.first_name AS PROVIDER_FIRST_NAME ,
    nw.middle_name AS PROVIDER_MIDDLE_NAME ,
    nw.last_name AS PROVIDER_LAST_NAME ,
    NULL AS ATTENTION_LINE ,
    nw.office_addr_1 AS ADDRESS_1 ,
    nw.office_addr_2 AS ADDRESS_2 ,
    NULL AS ADDRESS_3 ,
    nw.office_city AS CITY ,
    nw.office_state AS STATE ,
    nw.office_zip AS ZIP ,
    nw.office_phone AS PHONE ,
    nw.office_county AS COUNTY_ID ,
    nw.license_number AS PROVIDER_LICENSE_NUMBER ,
    NULL AS PROVIDER_LICENSE_NUMBER_OLD ,
    NULL AS PROVIDER_LICENSE_NATIONAL_ID ,
    NULL AS PROVIDER_LICENSE_CATEGORY ,
    nw.network_generic_field6_txt AS NPI_BENEFIT_CODE ,
    NULL AS NPI_PRIMARY_TAXONOMY_CODE ,
    NULL AS RACE_ID ,
    p.type_cd AS PROVIDER_TYPE ,
    eps.description AS PROVIDER_SPECIALTY ,
    NULL AS PROVIDER_TAX_ID ,
    nw.sex_limits_cd AS PROVIDER_SEX_RESTRICTIONS ,
    0 AS CSDA_ID ,
    nw.age_high_limit AS AGE_HIGH ,
    nw.age_low_limit AS AGE_LOW ,
    nwl1.language_type_cd AS LANGUAGE_SERVED_1 ,
    nwl2.language_type_cd AS LANGUAGE_SERVED_2 ,
    nwl3.language_type_cd AS LANGUAGE_SERVED_3 ,
    pl.panel_size AS TOTAL_CLIENTS_ALLOWED ,
    nw.create_ts AS SOURCE_RECORD_DATE ,
    TO_CHAR(nw.create_ts, 'HH24MI') AS SOURCE_RECORD_TIME ,
    nw.created_by AS SOURCE_RECORD_NAME ,
    nw.create_ts AS DATE_OF_VALIDITY_START ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END ,
    nw.created_by AS CREATED_BY ,
    nw.create_ts AS DATE_CREATED ,
    nw.updated_by AS UPDATED_BY ,
    nw.update_ts AS DATE_UPDATED ,
    noh.open_from AS OFC_HR_OPEN_FROM ,
    noh.close_at AS OFC_HR_CLOSE_AT ,
    noh.day_of_week AS OFC_HR_DAYS_OF_WEEK ,
    'Y' AS CURRENT_FLAG ,
    nw.network_id AS CURRENT_PROVIDER_ID ,
    1 AS VERSION ,
    '0' CSDA_CODE ,
    '0' RACE_CODE ,
    nw.office_county AS COUNTY_CODE
  FROM NETWORK nw
  LEFT JOIN provider p                  ON (p.provider_id = nw.provider_id)
  LEFT JOIN enum_county ec              ON (nw.office_county = ec.value)
  LEFT JOIN network_language nwl1       ON (nw.network_id = nwl1.network_id AND nwl1.language_ext_cd = '1')
  LEFT JOIN network_language nwl2       ON (nw.network_id = nwl2.network_id AND nwl2.language_ext_cd = '2')
  LEFT JOIN network_language nwl3       ON (nw.network_id = nwl3.network_id AND nwl3.language_ext_cd = '3')
  LEFT JOIN panel_limit pl              ON (nw.network_id = pl.network_id)
  LEFT JOIN network_office_hours noh    ON (nw.network_id = noh.network_id)
  LEFT JOIN network_specialty nws       ON (nw.network_id = nws.network_id)
  LEFT JOIN enum_provider_specialty eps ON (nws.specialty_type_cd = eps.value)
  
  UNION ALL
  
  SELECT 
  0 AS PROVIDER_NUMBER,
  0 AS SOURCE_RECORD_ID,
  '0' AS PROVIDER_CODE,
  'MEDICAID' AS MANAGED_CARE_PROGRAM,
  NULL AS PLAN_ID,
  NULL AS PROVIDER_TITLE,
  NULL AS PROVIDER_FIRST_NAME,
  NULL AS PROVIDER_MIDDLE_NAME,
  NULL AS PROVIDER_LAST_NAME,
  NULL AS ATTENTION_LINE,
  NULL AS ADDRESS_1,
  NULL AS ADDRESS_2,
  NULL AS ADDRESS_3,
  NULL AS CITY,
  NULL AS STATE,
  NULL AS ZIP,
  NULL AS PHONE,
  NULL AS COUNTY_ID,
  NULL AS PROVIDER_LICENSE_NUMBER,
  NULL AS PROVIDER_LICENSE_NUMBER_OLD,
  NULL AS PROVIDER_LICENSE_NATIONAL_ID,
  NULL AS PROVIDER_LICENSE_CATEGORY,
  NULL AS NPI_BENEFIT_CODE,
  NULL AS NPI_PRIMARY_TAXONOMY_CODE,
  NULL AS RACE_ID,
  NULL AS PROVIDER_TYPE,
  NULL AS PROVIDER_SPECIALTY,
  NULL AS PROVIDER_TAX_ID,
  NULL AS PROVIDER_SEX_RESTRICTIONS,
  0 AS CSDA_ID,
  NULL AS AGE_HIGH,
  NULL AS AGE_LOW,
  NULL AS LANGUAGE_SERVED_1,
  NULL AS LANGUAGE_SERVED_2,
  NULL AS LANGUAGE_SERVED_3,
  NULL AS TOTAL_CLIENTS_ALLOWED,
  NULL AS SOURCE_RECORD_DATE,
  NULL AS SOURCE_RECORD_TIME,
  NULL AS SOURCE_RECORD_NAME,
  TO_DATE('01/01/1900','mm/dd/yyyy') AS DATE_OF_VALIDITY_START,
  TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END,
  NULL AS CREATED_BY,
  NULL AS DATE_CREATED,
  NULL AS UPDATED_BY,
  NULL AS DATE_UPDATED,
  NULL AS OFC_HR_OPEN_FROM,
  NULL AS OFC_HR_CLOSE_AT,
  NULL AS OFC_HR_DAYS_OF_WEEK,
  'Y' AS CURRENT_FLAG,
  0 AS CURRENT_PROVIDER_ID,
  1 AS VERSION,
  '0' AS CSDA_CODE,
  '0' AS RACE_CODE,
  '0' AS COUNTY_CODE
FROM DUAL;
  
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_SV TO MAXDAT_REPORTS; 