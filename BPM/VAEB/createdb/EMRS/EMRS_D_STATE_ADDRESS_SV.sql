CREATE OR REPLACE VIEW EMRS_D_STATE_ADDRESS_SV
AS
SELECT COALESCE(ac.addr_begin_date, acs.addr_begin_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(TO_CHAR(ac.last_update_date,'HH24MI'), TO_CHAR(acs.last_update_date,'HH24MI')) AS MODIFIED_TIME ,
    COALESCE(ac.creation_date, acs.creation_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS DATE_CREATED ,
    COALESCE(ac.created_by, acs.created_by) AS CREATED_BY ,
    COALESCE(ac.addr_id, acs.addr_id, -1*c.client_id) AS ADDRESS_ID ,
    COALESCE(ac.addr_id, acs.addr_id, -1*c.client_id) AS SOURCE_RECORD_ID ,
    COALESCE(ac.addr_street_1, acs.addr_street_1) AS ADDR_STREET_1 ,
    COALESCE(ac.addr_street_2, acs.addr_street_2) AS ADDR_STREET_2 ,
    COALESCE(ac.addr_city, acs.addr_city) AS ADDR_CITY ,
    COALESCE(ac.addr_state_cd, acs.addr_state_cd) AS ADDR_STATE_CD ,
    COALESCE(ac.addr_zip, acs.addr_zip) AS ADDR_ZIP ,
    COALESCE(ac.addr_zip_four, acs.addr_zip_four) AS ADDR_ZIP_FOUR ,
    COALESCE(ac.addr_type_cd, acs.addr_type_cd) AS ADDR_TYPE_CD ,
    COALESCE(atc.description, atcs.description) AS ADDR_TYPE ,
    COALESCE(ac.addr_country, acs.addr_country) AS ADDR_COUNTRY ,
    c.client_id AS CLIENT_NUMBER , 
    COALESCE(ac.addr_attn, acs.addr_attn) AS ADDR_ATTN ,
    COALESCE(ac.addr_house_code, acs.addr_house_code) AS ADDR_HOUSE_CODE ,
    COALESCE(ac.addr_bar_code, acs.addr_bar_code) AS ADDR_BAR_CODE ,
    COALESCE(ac.addr_origin_cd, acs.addr_origin_cd) AS ADDR_ORIGIN_CD ,
    COALESCE(ac.addr_staff_id, acs.addr_staff_id) AS ADDR_STAFF_ID ,
    COALESCE(ac.addr_ctlk_id, acs.addr_ctlk_id) AS ADDR_CTLK_ID ,
    COALESCE(ac.addr_dolk_id, acs.addr_dolk_id) AS ADDR_DOLK_ID ,
    COALESCE(ac.addr_prov_id, acs.addr_prov_id) AS ADDR_PROV_ID ,
    COALESCE(ac.addr_payc_id, acs.addr_payc_id) AS ADDR_PAYC_ID ,
    COALESCE(ac.addr_verified, acs.addr_verified) AS ADDR_VERIFIED ,
    COALESCE(ac.addr_verified_date, acs.addr_verified_date) AS ADDR_VERIFIED_DATE ,
    COALESCE(ac.advy_id, acs.advy_id) AS ADVY_ID ,
    COALESCE(ac.addr_bad_date, acs.addr_bad_date) AS ADDR_BAD_DATE ,
    COALESCE(ac.addr_bad_date_satisfied, acs.addr_bad_date_satisfied) AS ADDR_BAD_DATE_SATISFIED ,
    c.CASE_ID AS CASE_NUMBER,
    COALESCE(ac.start_ndt, acs.start_ndt, 19990101000000000) AS START_NDT ,
    COALESCE(ac.end_ndt, acs.end_ndt, 99991231235959999) AS END_NDT ,
    COALESCE(ac.comparable_key, acs.comparable_key) AS COMPARABLE_KEY ,
    COALESCE(ac.creation_date, acs.creation_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE ,
    COALESCE(TO_CHAR(ac.creation_date,'HH24MI'), TO_CHAR(acs.creation_date,'HH24MI'), '0000') AS RECORD_TIME ,
    COALESCE(ac.created_by, acs.created_by) AS RECORD_NAME ,
    COALESCE(ac.last_update_date, acs.last_update_date) AS MODIFIED_DATE ,
    COALESCE(ac.last_updated_by, acs.last_updated_by) AS MODIFIED_NAME ,
    COALESCE(ac.addr_end_date, acs.addr_end_date) AS SOURCE_ADDR_END_DATE
FROM eb.client_supplementary_info c
LEFT JOIN eb.address ac ON (ac.addr_type_cd IN ('RS', 'ML') 
                                AND ac.END_NDT > to_number(to_char(sysdate, 'yyyymmddHH24misssss')) 
                                AND c.client_id = ac.clnt_client_id)
LEFT JOIN eb.address acs ON (acs.clnt_client_id IS NULL AND acs.addr_type_cd IN ('RS', 'ML') 
                                AND acs.END_NDT > to_number(to_char(sysdate, 'yyyymmddHH24misssss')) 
                                AND c.case_id = acs.addr_case_id)
LEFT JOIN eb.enum_address_type atc ON (ac.addr_type_cd = atc.value)
LEFT JOIN eb.enum_address_type atcs ON (acs.addr_type_cd = atcs.value) 
UNION ALL
SELECT COALESCE(ac.addr_begin_date, acs.addr_begin_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(TO_CHAR(ac.last_update_date,'HH24MI'), TO_CHAR(acs.last_update_date,'HH24MI')) AS MODIFIED_TIME ,
    COALESCE(ac.creation_date, acs.creation_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS DATE_CREATED ,
    COALESCE(ac.created_by, acs.created_by) AS CREATED_BY ,
    COALESCE(ac.addr_id, acs.addr_id, -1*c.client_id) AS ADDRESS_ID ,
    COALESCE(ac.addr_id, acs.addr_id, -1*c.client_id) AS SOURCE_RECORD_ID ,
    COALESCE(ac.addr_street_1, acs.addr_street_1) AS ADDR_STREET_1 ,
    COALESCE(ac.addr_street_2, acs.addr_street_2) AS ADDR_STREET_2 ,
    COALESCE(ac.addr_city, acs.addr_city) AS ADDR_CITY ,
    COALESCE(ac.addr_state_cd, acs.addr_state_cd) AS ADDR_STATE_CD ,
    COALESCE(ac.addr_zip, acs.addr_zip) AS ADDR_ZIP ,
    COALESCE(ac.addr_zip_four, acs.addr_zip_four) AS ADDR_ZIP_FOUR ,
    'ML' AS ADDR_TYPE_CD ,
    COALESCE(atc.description, atcs.description) AS ADDR_TYPE ,
    COALESCE(ac.addr_country, acs.addr_country) AS ADDR_COUNTRY ,
    c.client_id AS CLIENT_NUMBER , 
    COALESCE(ac.addr_attn, acs.addr_attn) AS ADDR_ATTN ,
    COALESCE(ac.addr_house_code, acs.addr_house_code) AS ADDR_HOUSE_CODE ,
    COALESCE(ac.addr_bar_code, acs.addr_bar_code) AS ADDR_BAR_CODE ,
    COALESCE(ac.addr_origin_cd, acs.addr_origin_cd) AS ADDR_ORIGIN_CD ,
    COALESCE(ac.addr_staff_id, acs.addr_staff_id) AS ADDR_STAFF_ID ,
    COALESCE(ac.addr_ctlk_id, acs.addr_ctlk_id) AS ADDR_CTLK_ID ,
    COALESCE(ac.addr_dolk_id, acs.addr_dolk_id) AS ADDR_DOLK_ID ,
    COALESCE(ac.addr_prov_id, acs.addr_prov_id) AS ADDR_PROV_ID ,
    COALESCE(ac.addr_payc_id, acs.addr_payc_id) AS ADDR_PAYC_ID ,
    COALESCE(ac.addr_verified, acs.addr_verified) AS ADDR_VERIFIED ,
    COALESCE(ac.addr_verified_date, acs.addr_verified_date) AS ADDR_VERIFIED_DATE ,
    COALESCE(ac.advy_id, acs.advy_id) AS ADVY_ID ,
    COALESCE(ac.addr_bad_date, acs.addr_bad_date) AS ADDR_BAD_DATE ,
    COALESCE(ac.addr_bad_date_satisfied, acs.addr_bad_date_satisfied) AS ADDR_BAD_DATE_SATISFIED ,
    c.CASE_ID AS CASE_NUMBER,
    COALESCE(ac.start_ndt, acs.start_ndt, 19990101000000000) AS START_NDT ,
    COALESCE(ac.end_ndt, acs.end_ndt, 99991231235959999) AS END_NDT ,
    COALESCE(ac.comparable_key, acs.comparable_key) AS COMPARABLE_KEY ,
    COALESCE(ac.creation_date, acs.creation_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE ,
    COALESCE(TO_CHAR(ac.creation_date,'HH24MI'), TO_CHAR(acs.creation_date,'HH24MI'), '0000') AS RECORD_TIME ,
    COALESCE(ac.created_by, acs.created_by) AS RECORD_NAME ,
    COALESCE(ac.last_update_date, acs.last_update_date) AS MODIFIED_DATE ,
    COALESCE(ac.last_updated_by, acs.last_updated_by) AS MODIFIED_NAME ,
    COALESCE(ac.addr_end_date, acs.addr_end_date) AS SOURCE_ADDR_END_DATE
FROM eb.client_supplementary_info c
LEFT JOIN eb.address ac ON (ac.addr_type_cd = 'RS'
                                AND ac.END_NDT > to_number(to_char(sysdate, 'yyyymmddHH24misssss')) 
                                AND c.client_id = ac.clnt_client_id)
LEFT JOIN eb.address acs ON (acs.clnt_client_id IS NULL AND acs.addr_type_cd = 'RS' 
                                AND acs.END_NDT > to_number(to_char(sysdate, 'yyyymmddHH24misssss')) 
                                AND c.case_id = acs.addr_case_id)
LEFT JOIN eb.enum_address_type atc ON (atc.value = 'ML')
LEFT JOIN eb.enum_address_type atcs ON (atcs.value = 'ML') 
WHERE NOT EXISTS(SELECT 1 FROM address mal WHERE mal.clnt_client_id = ac.clnt_client_id AND mal.addr_type_cd = 'ML'); 

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_STATE_ADDRESS_SV TO MAXDAT_REPORTS;


