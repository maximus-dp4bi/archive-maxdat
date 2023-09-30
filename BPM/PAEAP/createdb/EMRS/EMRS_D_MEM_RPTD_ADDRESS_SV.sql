CREATE OR REPLACE VIEW EMRS_D_MEM_RPTD_ADDRESS_SV
AS
  SELECT c.case_id AS CASE_NUMBER,
    c.clnt_client_id AS CLIENT_NUMBER ,
    a.addr_id AS ADDRESS_ID,
    a.addr_street_1 AS ADDR_STREET_1 ,
    a.addr_street_2 AS ADDR_STREET_2 ,
    a.addr_city AS ADDR_CITY ,
    a.addr_state_cd AS ADDR_STATE_CD ,
    a.addr_zip AS ADDR_ZIP ,
    a.addr_zip_four AS ADDR_ZIP_FOUR ,
    a.addr_type_cd AS ADDR_TYPE_CD ,
    a.addr_country AS ADDR_COUNTRY ,
    e1.segment_detail_value_4 AS DISTRICT_CODE,
    a.addr_attn AS ADDR_ATTN ,
    a.addr_house_code AS ADDR_HOUSE_CODE ,
    a.addr_bar_code AS ADDR_BAR_CODE ,
    a.addr_origin_cd AS ADDR_ORIGIN_CD ,
    a.addr_staff_id AS ADDR_STAFF_ID ,
    a.addr_ctlk_id AS ADDR_CTLK_ID ,
    rs.addr_ctlk_id AS OLD_ADDR_CTLK_ID ,
    a.addr_dolk_id AS ADDR_DOLK_ID ,
    a.addr_prov_id AS ADDR_PROV_ID ,
    a.addr_payc_id AS ADDR_PAYC_ID ,
    a.addr_begin_date AS ADDR_BEGIN_DATE ,
    a.addr_end_date AS ADDR_END_DATE ,
    a.addr_verified AS ADDR_VERIFIED ,
    a.addr_verified_date AS ADDR_VERIFIED_DATE ,
    a.advy_id AS ADVY_ID ,
    a.addr_bad_date AS ADDR_BAD_DATE ,
    a.addr_bad_date_satisfied AS ADDR_BAD_DATE_SATISFIED ,
    a.start_ndt AS START_NDT ,
    a.end_ndt AS END_NDT ,
    a.comparable_key AS COMPARABLE_KEY ,
    a.creation_date AS RECORD_DATE ,
    TO_CHAR(a.creation_date,'HH24MI') AS RECORD_TIME ,
    a.created_by AS RECORD_NAME ,
    a.creation_date AS DATE_CREATED ,
    a.created_by AS CREATED_BY ,
    a.last_update_date AS MODIFIED_DATE ,
    a.last_updated_by AS MODIFIED_NAME ,
    TO_CHAR(a.last_update_date,'HH24MI') AS MODIFIED_TIME
  FROM eb.cases c 
  LEFT JOIN eb.elig_segment_and_details e1 ON (c.clnt_client_id = e1.client_id AND e1.segment_type_cd='ME' AND e1.end_nd = 99991231)
  LEFT JOIN (SELECT addr.addr_case_id,
              addr.addr_id,
              addr.addr_street_1,
              addr.addr_street_2,
              addr.addr_city,
              addr.addr_state_cd,
              addr.addr_zip,
              addr.addr_zip_four,
              addr.addr_type_cd,
              addr.addr_country,
              addr.addr_attn,
              addr.addr_house_code,
              addr.addr_bar_code,
              addr.addr_origin_cd,
              addr.addr_staff_id,
              addr.addr_ctlk_id,
              addr.addr_dolk_id,
              addr.addr_prov_id,
              addr.addr_payc_id,
              addr.addr_verified,
              addr.addr_verified_date,
              addr.advy_id,
              addr.addr_bad_date,
              addr.addr_bad_date_satisfied,
              addr.start_ndt,
              addr.end_ndt,
              addr.comparable_key,
              addr.creation_date,
              addr.created_by,
              addr.last_update_date,
              addr.last_updated_by,
              addr.addr_end_date,
              addr.addr_begin_date  
              ,ROW_NUMBER() OVER(PARTITION BY addr.addr_case_id ORDER BY addr.addr_id DESC) AS rn
            FROM eb.address addr
            WHERE  addr.CREATED_BY <> '-11' and addr.ADDR_TYPE_CD = 'MR' AND addr.addr_case_id IS NOT NULL) a ON (c.case_id = a.addr_case_id AND a.rn = 1)
  LEFT JOIN (SELECT a.addr_id
              , a.addr_case_id
              , a.addr_ctlk_id
              , ROW_NUMBER() OVER(PARTITION BY addr_case_id ORDER BY a.addr_id) as rn
             FROM address a
             WHERE a.addr_type_cd = 'RS') rs ON (c.case_id = rs.addr_case_id AND rs.rn = 1); 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_MEM_RPTD_ADDRESS_SV TO EB_MAXDAT_REPORTS;