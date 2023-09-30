CREATE OR REPLACE VIEW EMRS_D_CLIENT_BUS_PHONE_SV
AS
SELECT COALESCE(p.PHON_ID, -1*c.clnt_client_id) AS PHONE_ID
  ,c.CLNT_CLIENT_ID AS CLIENT_ID
  ,p.PHON_AREA_CODE AS PHON_AREA_CODE
  ,p.PHON_BAD_DATE AS PHON_BAD_DATE
  ,p.PHON_BAD_DATE_SATISFIED AS PHON_BAD_DATE_SATISFIED
  ,p.PHON_CARRIER_INFO AS PHON_CARRIER_INFO
  ,p.PHON_CNTT_ID AS PHON_CNTT_ID
  ,p.PHON_DOLK_ID AS PHON_DOLK_ID
  ,p.PHON_EXT AS PHON_EXT
  ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) AS PHON_PHONE_NUMBER
  ,p.PHON_PROV_ID AS PHON_PROV_ID
  ,COALESCE(p.PHON_TYPE_CD, 'UD') AS PHON_TYPE_CD
  ,COALESCE(t.REPORT_LABEL, 'Undefined') AS PHONE_TYPE
  ,p.SMS_ENABLED_IND AS SMS_ENABLED_IND
  ,COALESCE(p.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
  ,p.PHON_END_DATE AS SOURCE_PHONE_END_DATE
  ,COALESCE(p.START_NDT, 19990101000000000) AS START_NDT
  ,COALESCE(p.END_NDT, 99991231235959999) AS END_NDT
  ,COALESCE(TRUNC(p.CREATION_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
  ,p.CREATED_BY AS RECORD_NAME
  ,p.LAST_UPDATE_DATE AS MODIFIED_DATE
  ,p.LAST_UPDATED_BY AS MODIFIED_NAME
  ,CASE WHEN ROW_NUMBER() OVER(PARTITION BY c.CLNT_CLIENT_ID ORDER BY COALESCE(p.PHON_ID, -1*c.clnt_client_id)) = 1 
        THEN 'Y'
        ELSE 'N' 
        END AS IS_CURRENT
FROM &schema_name..CLIENT c
LEFT JOIN &schema_name..PHONE_NUMBER p ON (p.PHON_TYPE_CD IN ('BF','B2')  
                                AND c.clnt_client_id = p.clnt_client_id)
LEFT JOIN &schema_name..ENUM_PHONE_TYPE t ON (p.PHON_TYPE_CD = t.VALUE);

GRANT SELECT ON EMRS_D_CLIENT_BUS_PHONE_SV TO MAXDAT_REPORTS;
