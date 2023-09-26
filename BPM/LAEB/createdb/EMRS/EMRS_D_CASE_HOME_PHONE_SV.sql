DROP VIEW MAXDAT_SUPPORT.EMRS_D_CASE_HOME_PHONE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CASE_HOME_PHONE_SV
AS
SELECT COALESCE(p.PHON_ID, -1*c.case_id) AS PHONE_ID
  ,c.CASE_ID AS CASE_ID
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
FROM EB.CASES c
LEFT JOIN EB.PHONE_NUMBER p ON (p.PHON_TYPE_CD IN ('HM','CH', 'H2', 'PR') 
                                AND c.case_id = p.phon_case_id)
LEFT JOIN EB.ENUM_PHONE_TYPE t ON (p.PHON_TYPE_CD = t.VALUE);

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_HOME_PHONE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_HOME_PHONE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_HOME_PHONE_SV TO MAXDAT_SUPPORT_READ_ONLY;