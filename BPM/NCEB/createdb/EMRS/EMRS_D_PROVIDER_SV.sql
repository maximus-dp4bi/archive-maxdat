CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SV
AS
  SELECT nw.network_id AS PROVIDER_NUMBER,
    COALESCE(nw.provider_id_ext,p.provider_id_ext,'0') AS PROVIDER_CODE,
    nw.program_type_cd AS MANAGED_CARE_PROGRAM,
    nw.plan_id AS PLAN_ID,
    p.title AS PROVIDER_TITLE,
    nw.first_name AS PROVIDER_FIRST_NAME,
    nw.middle_name AS PROVIDER_MIDDLE_NAME,
    nw.last_name AS PROVIDER_LAST_NAME,
    nw.office_addr_1 AS ADDRESS_1,
    nw.office_addr_2 AS ADDRESS_2,
    nw.office_city AS CITY,
    nw.office_state AS STATE,
    nw.office_zip AS ZIP,
    nw.office_phone AS PHONE,
    COALESCE(nw.office_county, '0') AS COUNTY_CODE,
    COALESCE(p.type_cd, '0') AS PROVIDER_TYPE_CODE,
    nw.sex_limits_cd AS PROVIDER_SEX_RESTRICTIONS,
    nw.age_high_limit AS AGE_HIGH,
    nw.age_low_limit AS AGE_LOW,
    nwl1.language_type_cd AS LANGUAGE_SERVED_1,
    nwl2.language_type_cd AS LANGUAGE_SERVED_2,
    nwl3.language_type_cd AS LANGUAGE_SERVED_3,
    pl.panel_size AS TOTAL_CLIENTS_ALLOWED,
    noh.open_from AS OFC_HR_OPEN_FROM,
    noh.close_at AS OFC_HR_CLOSE_AT,
    noh.day_of_week AS OFC_HR_DAYS_OF_WEEK,
    nw.create_ts AS DATE_CREATED,
    nw.created_by AS CREATED_BY,
    nw.update_ts AS DATE_UPDATED,
    nw.updated_by AS UPDATED_BY 
  FROM &schema_name..NETWORK nw
  LEFT JOIN &schema_name..provider p                  ON (p.provider_id = nw.provider_id)
  LEFT JOIN &schema_name..network_language nwl1       ON (nw.network_id = nwl1.network_id AND nwl1.language_ext_cd = '1')
  LEFT JOIN &schema_name..network_language nwl2       ON (nw.network_id = nwl2.network_id AND nwl2.language_ext_cd = '2')
  LEFT JOIN &schema_name..network_language nwl3       ON (nw.network_id = nwl3.network_id AND nwl3.language_ext_cd = '3')
  LEFT JOIN &schema_name..panel_limit pl              ON (nw.network_id = pl.network_id)
  LEFT JOIN &schema_name..network_office_hours noh    ON (nw.network_id = noh.network_id)
  UNION ALL
  SELECT 
    0 AS PROVIDER_NUMBER,
    '0' AS PROVIDER_CODE,
    'MEDICAID' AS MANAGED_CARE_PROGRAM,
    NULL AS PLAN_ID,
    NULL AS PROVIDER_TITLE,
    NULL AS PROVIDER_FIRST_NAME,
    NULL AS PROVIDER_MIDDLE_NAME,
    NULL AS PROVIDER_LAST_NAME,
    NULL AS ADDRESS_1,
    NULL AS ADDRESS_2,
    NULL AS CITY,
    NULL AS STATE,
    NULL AS ZIP,
    NULL AS PHONE,
    NULL AS COUNTY_CODE,
    NULL AS PROVIDER_TYPE,
    NULL AS PROVIDER_SEX_RESTRICTIONS,
    NULL AS AGE_HIGH,
    NULL AS AGE_LOW,
    NULL AS LANGUAGE_SERVED_1,
    NULL AS LANGUAGE_SERVED_2,
    NULL AS LANGUAGE_SERVED_3,
    NULL AS TOTAL_CLIENTS_ALLOWED,
    NULL AS OFC_HR_OPEN_FROM,
    NULL AS OFC_HR_CLOSE_AT,
    NULL AS OFC_HR_DAYS_OF_WEEK,
    NULL AS DATE_CREATED,
    NULL AS CREATED_BY,
    NULL AS DATE_UPDATED,
    NULL AS UPDATED_BY
  FROM DUAL;  
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_SV TO MAXDAT_REPORTS; 