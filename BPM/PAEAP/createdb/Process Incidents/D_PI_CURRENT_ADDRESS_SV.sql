CREATE OR REPLACE VIEW D_PI_CURRENT_ADDRESS_SV
AS
  SELECT COALESCE(addr.addr_begin_date, TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(TO_CHAR(addr.last_update_date,'HH24MI'), '0000') AS MODIFIED_TIME ,
    COALESCE(addr.creation_date, TO_DATE('01/01/1900','MM/DD/YYYY')) AS DATE_CREATED ,
    addr.created_by AS CREATED_BY ,
    COALESCE(addr.addr_id, 0) AS ADDRESS_ID ,
    COALESCE(addr.addr_id, 0) AS SOURCE_RECORD_ID ,
    addr.addr_street_1 AS ADDR_STREET_1 ,
    addr.addr_street_2 AS ADDR_STREET_2 ,
    addr.addr_city AS ADDR_CITY ,
    addr.addr_state_cd AS ADDR_STATE_CD ,
    addr.addr_zip AS ADDR_ZIP ,
    addr.addr_zip_four AS ADDR_ZIP_FOUR ,
    addr.addr_type_cd AS ADDR_TYPE_CD ,
    eat.description AS ADDR_TYPE ,
    addr.addr_country AS ADDR_COUNTRY ,
    COALESCE(c.clnt_client_id, addr.clnt_client_id) AS CLIENT_ID ,
    COALESCE(c.clnt_client_id, addr.clnt_client_id) AS CLIENT_NUMBER , 
    addr.addr_attn AS ADDR_ATTN ,
    addr.addr_house_code AS ADDR_HOUSE_CODE ,
    addr.addr_bar_code AS ADDR_BAR_CODE ,
    addr.addr_origin_cd AS ADDR_ORIGIN_CD ,
    addr.addr_staff_id AS ADDR_STAFF_ID ,
    addr.addr_ctlk_id AS ADDR_CTLK_ID ,
    addr.addr_dolk_id AS ADDR_DOLK_ID ,
    addr.addr_prov_id AS ADDR_PROV_ID ,
    addr.addr_payc_id AS ADDR_PAYC_ID ,
    addr.addr_verified AS ADDR_VERIFIED ,
    addr.addr_verified_date AS ADDR_VERIFIED_DATE ,
    addr.advy_id AS ADVY_ID ,
    COALESCE(addr.addr_bad_date, TO_DATE('01/01/1900','MM/DD/YYYY')) AS ADDR_BAD_DATE ,
    COALESCE(addr.addr_bad_date_satisfied, TO_DATE('01/01/1900','MM/DD/YYYY')) AS ADDR_BAD_DATE_SATISFIED ,
    c.CASE_ID AS CASE_NUMBER ,
    COALESCE(addr.start_ndt, 19990101000000000) AS START_NDT ,
    COALESCE(addr.end_ndt, 99991231235959999) AS END_NDT ,
    addr.comparable_key AS COMPARABLE_KEY ,
    COALESCE(addr.creation_date, TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE ,
    COALESCE(TO_CHAR(addr.creation_date,'HH24MI'), '0000') AS RECORD_TIME ,
    addr.created_by AS RECORD_NAME ,
    COALESCE(addr.last_update_date, TO_DATE('01/01/1900','MM/DD/YYYY')) AS MODIFIED_DATE ,
    addr.last_updated_by AS MODIFIED_NAME ,
    addr_end_date AS SOURCE_ADDR_END_DATE
  FROM EB.CASES c
  LEFT JOIN EB.ADDRESS addr ON (addr.addr_case_id IS NOT NULL 
                                          AND addr.addr_type_cd = 'RS'
                                          AND addr.end_ndt = 99991231235959999
                                          AND addr.addr_case_id = c.case_id)
  LEFT JOIN EB.ENUM_ADDRESS_TYPE eat ON (addr.addr_type_cd = eat.value);

  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_ADDRESS_SV TO EB_MAXDAT_REPORTS;