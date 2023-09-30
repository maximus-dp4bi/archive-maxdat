DROP VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_MAIL_ADDRESS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_MAIL_ADDRESS_SV
AS
WITH tmp AS
  (SELECT /*+ parallel(10) */ a.ADDR_ID 
  , a.CLNT_CLIENT_ID
  , ROW_NUMBER() OVER(PARTITION BY a.CLNT_CLIENT_ID ORDER BY CASE WHEN a.ADDR_TYPE_CD = 'MM' THEN 1 
                                                                    WHEN a.ADDR_TYPE_CD = 'ML' THEN 2 
                                                                    WHEN a.ADDR_TYPE_CD = 'GM' THEN 3
                                                                    WHEN a.ADDR_TYPE_CD = 'MR' THEN 4
                                                                    WHEN a.ADDR_TYPE_CD = 'RS' THEN 5
                                                                    WHEN a.ADDR_TYPE_CD = 'FA' THEN 6
                                                                    WHEN a.ADDR_TYPE_CD = 'FR' THEN 7
                                                                    WHEN a.ADDR_TYPE_CD = 'BL' THEN 8
                                                                    WHEN a.ADDR_TYPE_CD = 'SP' THEN 9
                                                                    ELSE 10 END, a.ADDR_ID DESC) as MAIL
  FROM EB.ADDRESS a
  WHERE a.ADDR_TYPE_CD IN ('MR','RS','FA', 'MM', 'ML', 'GM', 'FR', 'BL', 'SP')
  AND a.ADDR_END_DATE IS NULL
  AND a.clnt_client_id IS NOT NULL)
              
  SELECT /*+ parallel(10) */
    addr.addr_id AS ADDRESS_ID ,
    addr.clnt_client_id AS CLIENT_ID , 
    COALESCE(addr.addr_type_cd, 'UD') AS ADDR_TYPE_CD ,
    addr.addr_attn AS ADDR_ATTN ,
    addr.addr_house_code AS ADDR_HOUSE_CODE ,
    addr.addr_street_1 AS ADDR_STREET_1 ,
    addr.addr_street_2 AS ADDR_STREET_2 ,
    addr.addr_city AS ADDR_CITY ,
    addr.addr_state_cd AS ADDR_STATE_CD ,
    addr.addr_zip AS ADDR_ZIP ,
    addr.addr_zip_four AS ADDR_ZIP_FOUR ,
    addr.addr_country AS ADDR_COUNTRY ,
    addr.addr_begin_date AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(addr.addr_end_date, TO_DATE('12/31/2050','mm/dd/yyyy')) AS SOURCE_ADDR_END_DATE,
    addr.start_ndt AS START_NDT ,
    addr.end_ndt AS END_NDT ,
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
    addr.addr_bad_date AS ADDR_BAD_DATE ,
    addr.addr_bad_date_satisfied AS ADDR_BAD_DATE_SATISFIED ,
    addr.comparable_key AS COMPARABLE_KEY ,
    addr.creation_date AS RECORD_DATE ,
    TO_CHAR(addr.creation_date,'HH24MI') AS RECORD_TIME ,
    addr.created_by AS RECORD_NAME ,
    addr.last_update_date AS MODIFIED_DATE ,
    TO_CHAR(addr.last_update_date,'HH24MI') AS MODIFIED_TIME ,
    addr.last_updated_by AS MODIFIED_NAME 
  FROM EB.ADDRESS addr
  JOIN tmp b ON (addr.addr_id = b.addr_id and b.MAIL = 1)
  WHERE addr.clnt_client_id IS NOT NULL            
  UNION ALL
  SELECT /*+ parallel(10) */
    c.clnt_client_id AS ADDRESS_ID ,
    c.clnt_client_id AS CLIENT_ID, 
    'UD' AS ADDR_TYPE_CD ,
    NULL AS ADDR_ATTN ,
    NULL AS ADDR_HOUSE_CODE ,
    NULL AS ADDR_STREET_1 ,
    NULL AS ADDR_STREET_2 ,
    NULL AS ADDR_CITY ,
    NULL AS ADDR_STATE_CD ,
    NULL AS ADDR_ZIP ,
    NULL AS ADDR_ZIP_FOUR ,
    NULL AS ADDR_COUNTRY ,
    TO_DATE('1/1/1900','mm/dd/yyyy') AS SOURCE_ADDR_BEGIN_DATE ,
    TO_DATE('12/31/2050','mm/dd/yyyy') AS SOURCE_ADDR_END_DATE,
    19000101000000000 AS START_NDT ,
    99991231235959999 AS END_NDT ,
    NULL AS ADDR_BAR_CODE ,
    NULL AS ADDR_ORIGIN_CD ,
    NULL AS ADDR_STAFF_ID ,
    '0' AS ADDR_CTLK_ID ,
    NULL AS ADDR_DOLK_ID ,
    NULL AS ADDR_PROV_ID ,
    NULL AS ADDR_PAYC_ID ,
    'N' AS ADDR_VERIFIED ,
    NULL AS ADDR_VERIFIED_DATE ,
    NULL AS ADVY_ID ,
    NULL AS ADDR_BAD_DATE ,
    NULL AS ADDR_BAD_DATE_SATISFIED ,
    NULL AS COMPARABLE_KEY ,
    NULL AS RECORD_DATE ,
    NULL AS RECORD_TIME ,
    'No Address' AS RECORD_NAME ,
    NULL AS MODIFIED_DATE ,
    NULL AS MODIFIED_TIME ,
    'No Address' AS MODIFIED_NAME 
  FROM client c
  WHERE c.CLNT_CLIENT_ID NOT IN (SELECT /*+ parallel(10) */ CLNT_CLIENT_ID FROM tmp);

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_MAIL_ADDRESS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_MAIL_ADDRESS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_MAIL_ADDRESS_SV TO MAXDAT_SUPPORT_READ_ONLY;
