CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SV
AS
  SELECT nw.network_id AS PROVIDER_NUMBER ,
    nw.network_id AS SOURCE_RECORD_ID ,
    nw.network_id AS PROVIDER_ID ,
    COALESCE(nw.provider_id_ext,p.provider_id_ext,'0') AS PROVIDER_CODE ,
    'MEDICAID' AS MANAGED_CARE_PROGRAM ,
    nw.plan_id AS PLAN_ID ,
    p.title AS PROVIDER_TITLE ,
    nw.first_name AS PROVIDER_FIRST_NAME ,
    nw.last_name AS PROVIDER_LAST_NAME ,
    p.ssn as PROVIDER_SSN,
    NULL AS ATTENTION_LINE ,
    nw.office_addr_1 AS ADDRESS_1 ,
    nw.office_addr_2 AS ADDRESS_2 ,
    NULL AS ADDRESS_3 ,
    nw.office_city AS CITY ,
    nw.office_state AS STATE ,
    nw.office_zip AS ZIP ,
    nw.office_phone AS PHONE ,
    nw.office_county AS COUNTY_ID ,
    RTRIM (REGEXP_SUBSTR (nw.license_number, '[^,]+', 1, 2), ',')  AS PROVIDER_LICENSE_NUMBER ,
    RTRIM (REGEXP_SUBSTR (nw.license_number, '[^,]+', 1, 1), ',')  AS PROVIDER_LICENSE_STATE ,
    NULL AS PROVIDER_LICENSE_NUMBER_OLD ,
    NULL AS PROVIDER_LICENSE_NATIONAL_ID ,
    NULL AS PROVIDER_LICENSE_CATEGORY ,
    nw.network_generic_field6_txt AS NPI_BENEFIT_CODE ,
    NULL AS NPI_PRIMARY_TAXONOMY_CODE ,
    NULL AS RACE_ID ,
    p.type_cd AS ENCOUNTER_TYPE ,
    p.classification_cd as PROVIDER_TYPE,
    --eps.description AS PROVIDER_SPECIALTY ,
    NULL AS PROVIDER_TAX_ID ,
    nw.sex_limits_cd AS PROVIDER_SEX_RESTRICTIONS ,
    0 AS CSDA_ID ,
    nw.age_high_limit AS AGE_HIGH ,
    nw.age_low_limit AS AGE_LOW ,
    nwl1.language_type_cd AS LANGUAGE_SERVED_1 ,
    nwl2.language_type_cd AS LANGUAGE_SERVED_2 ,
    nwl3.language_type_cd AS LANGUAGE_SERVED_3 ,
    nwl4.language_type_cd AS LANGUAGE_SERVED_4 ,
    nwl5.language_type_cd AS LANGUAGE_SERVED_5 ,
    pl.panel_size AS TOTAL_CLIENTS_ALLOWED ,
    PL.ENROLLED_COUNT AS CURRENT_CLIENTS_COUNT,
    nw.create_ts AS SOURCE_RECORD_DATE ,
    TO_CHAR(nw.create_ts, 'HH24MI') AS SOURCE_RECORD_TIME ,
    nw.created_by AS SOURCE_RECORD_NAME ,
    nw.Start_Date AS DATE_OF_VALIDITY_START ,
    NW.END_DT AS DATE_OF_VALIDITY_END ,
    nw.created_by AS CREATED_BY ,
    nw.create_ts AS DATE_CREATED ,
    nw.updated_by AS UPDATED_BY ,
    nw.update_ts AS DATE_UPDATED ,
    --noh.open_from AS OFC_HR_OPEN_FROM ,
    --noh.close_at AS OFC_HR_CLOSE_AT ,
    NULL AS OFC_HR_DAYS_OF_WEEK ,
    'Y' AS CURRENT_FLAG ,
    nw.network_id AS CURRENT_PROVIDER_ID ,
    1 AS VERSION ,
    '0' CSDA_CODE ,
    '0' RACE_CODE ,
    nw.office_county AS COUNTY_CODE,
    nw.network_generic_field5_txt OFFERS_PEDIATRIC,
    nw.network_generic_field6_txt OFFERS_NEWBORN,
    nw.network_generic_field10_txt POBOX,
    RTRIM (REGEXP_SUBSTR (nw.network_generic_field9_txt, '[^,]+', 1, 1), ',')    AS TAXID_FLAG,
    RTRIM (REGEXP_SUBSTR (nw.network_generic_field9_txt, '[^,]+', 1, 2), ',')    AS PAYMENT_FLAG,
    RTRIM (REGEXP_SUBSTR (nw.network_generic_field9_txt, '[^,]+', 1, 3), ',')    AS PUBLICTRANS_FLAG,
    RTRIM (REGEXP_SUBSTR (nw.network_generic_field9_txt, '[^,]+', 1, 4), ',')    AS CHILDCARE,
    RTRIM (REGEXP_SUBSTR (nw.network_generic_field9_txt, '[^,]+', 1, 5), ',')    AS SPECIAL_PROGRAM_CARE,
    case when NW.ACCEPTING_NEW_CLIENTS_PCP_IND = 1 then 'Y' else 'N' end ACCEPTING,
    NW.STATUS_CD STATUS_CD,
    case when NW.ACCEPTS_OBSTETRICS_IND = 1 then 'Y' else 'N' end OFFERS_OBGYN,
    NW.OFFICE_FAX,
    NW.MEDICAID_ID_EXT,
    NW.MIDDLE_NAME PROVIDER_MIDDLE_NAME,
    NW.NETWORK_ID_EXT NPI,
    case when NW.FQHC_STATUS_IND = 1 then 'Y' else 'N' end FQHC,
    NW.PROVIDER_GENDER_CD PROVIDER_GENDER ,
    nw.plan_id_ext PROVIDERMHP,
    NW.SITENAME AS PROV_GROUP_NAME,
    NW.NETWORK_GENERIC_FIELD7_TXT PROV_GROUP_ID,
    nws1.specialty_type_cd PROVIDER_SPECIALITY_CODE_1,
    nws2.specialty_type_cd PROVIDER_SPECIALITY_CODE_2,
    nws3.specialty_type_cd PROVIDER_SPECIALITY_CODE_3
  FROM NETWORK nw
--  LEFT JOIN NETWORK_SUPPLEMENTARY_INFO nwsU ON (NW.NETWORK_ID = NWSU.NETWORK_ID)
  LEFT JOIN provider p                  ON (p.provider_id = nw.provider_id)
  LEFT JOIN enum_county ec              ON (nw.office_county = ec.value)
  LEFT JOIN network_language nwl1       ON (nw.network_id = nwl1.network_id AND nwl1.language_ext_cd = 0)
  LEFT JOIN network_language nwl2       ON (nw.network_id = nwl2.network_id AND nwl2.language_ext_cd = 1)
  LEFT JOIN network_language nwl3       ON (nw.network_id = nwl3.network_id AND nwl3.language_ext_cd = 2)
  LEFT JOIN network_language nwl4       ON (nw.network_id = nwl4.network_id AND nwl4.language_ext_cd = 3)
  LEFT JOIN network_language nwl5       ON (nw.network_id = nwl5.network_id AND nwl5.language_ext_cd = 4)
  LEFT JOIN network_specialty nws1       ON (nw.network_id = nws1.network_id AND NWS1.SPECIALTY_EXT_CD = 0)
  LEFT JOIN network_specialty nws2       ON (nw.network_id = nws2.network_id AND NWS2.SPECIALTY_EXT_CD = 1)
  LEFT JOIN network_specialty nws3       ON (nw.network_id = nws3.network_id AND NWS3.SPECIALTY_EXT_CD = 2)
  LEFT JOIN panel_limit pl              ON (nw.network_id = pl.network_id)
--  LEFT JOIN network_office_hours noh    ON (nw.network_id = noh.network_id)
  --LEFT JOIN network_specialty nws1       ON (nw.network_id = nws1.network_id AND NWS1.SPECIALTY_EXT_CD = 0)
  --LEFT JOIN enum_provider_specialty eps ON (nws.specialty_type_cd = eps.value)
 -- where network_generic_field9_txt = 'F,F,Y,Y,'
-- WHERE NW.PROVIDER_ID = 45828
 ;
  
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_SV TO MAXDAT_REPORTS; 
