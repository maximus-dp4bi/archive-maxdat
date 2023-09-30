CREATE OR REPLACE VIEW EMRS_D_HOME_PHONE_SV
AS
SELECT COALESCE(pnc.PHON_ID, pncs.PHON_ID, -1*c.clnt_client_id) AS PHONE_ID
,COALESCE(pnc.PHON_BEGIN_DATE, pncs.PHON_BEGIN_DATE,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_PHONE_BEGIN_DATE
,COALESCE(pnc.PHON_TYPE_CD, pncs.PHON_TYPE_CD) AS PHON_TYPE_CD
,COALESCE(ptc.REPORT_LABEL, ptcs.REPORT_LABEL) AS PHONE_TYPE
,COALESCE(pnc.PHON_END_DATE, pncs.PHON_END_DATE) AS SOURCE_PHONE_END_DATE
,c.CLNT_CLIENT_ID AS CLIENT_NUMBER
,COALESCE(pnc.PHON_AREA_CODE, pncs.PHON_AREA_CODE, SUBSTR(case_phone,1,3), NULL) AS PHON_AREA_CODE
,COALESCE(pnc.PHON_PHONE_NUMBER, pncs.PHON_PHONE_NUMBER, SUBSTR(case_phone,4,LENGTH(case_phone)-3), NULL) AS PHON_PHONE_NUMBER
,COALESCE(pnc.PHON_EXT, pncs.PHON_EXT, NULL) AS PHON_EXT
,COALESCE(pnc.PHON_PROV_ID, pncs.PHON_PROV_ID) AS PHON_PROV_ID
,COALESCE(pnc.PHON_CNTT_ID, pncs.PHON_CNTT_ID) AS PHON_CNTT_ID
,COALESCE(pnc.PHON_DOLK_ID, pncs.PHON_DOLK_ID) AS PHON_DOLK_ID
,COALESCE(pnc.CREATED_BY, pncs.CREATED_BY) AS RECORD_NAME
,COALESCE(TRUNC(pnc.CREATION_DATE), TRUNC(pncs.CREATION_DATE), TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE
,COALESCE(pnc.LAST_UPDATED_BY, pncs.LAST_UPDATED_BY) AS MODIFIED_NAME
,COALESCE(TRUNC(pnc.LAST_UPDATE_DATE), TRUNC(pncs.LAST_UPDATE_DATE)) AS MODIFIED_DATE
,cs.CASE_ID AS CASE_NUMBER
,COALESCE(pnc.START_NDT, pncs.START_NDT, 19990101000000000) AS START_NDT
,COALESCE(pnc.END_NDT, pncs.END_NDT, 99991231235959999) AS END_NDT
,COALESCE(pnc.PHON_CARRIER_INFO, pncs.PHON_CARRIER_INFO) AS PHON_CARRIER_INFO
,COALESCE(pnc.SMS_ENABLED_IND, pncs.SMS_ENABLED_IND) AS SMS_ENABLED_IND
,COALESCE(pnc.PHON_BAD_DATE, pncs.PHON_BAD_DATE) AS PHON_BAD_DATE
,COALESCE(pnc.PHON_BAD_DATE_SATISFIED, pncs.PHON_BAD_DATE_SATISFIED) AS PHON_BAD_DATE_SATISFIED
FROM eb.client c
JOIN eb.cases cs ON (cs.case_id IN (SELECT case_id from(SELECT clnt_client_id, case_id, RANK() OVER(PARTITION BY(clnt_client_id) ORDER BY case_status DESC, creation_date DESC) AS rnk FROM eb.cases) WHERE rnk = 1)
                      AND c.clnt_client_id = cs.clnt_client_id)
LEFT JOIN eb.phone_number pnc ON (pnc.phon_case_id IS NULL AND pnc.PHON_TYPE_CD IN ('HM', 'CH') 
                                AND pnc.END_NDT > to_number(to_char(sysdate, 'yyyymmddHH24misssss')) 
                                AND c.clnt_client_id = pnc.clnt_client_id)
LEFT JOIN eb.phone_number pncs ON (pncs.clnt_client_id IS NULL AND pncs.PHON_TYPE_CD IN ('HM', 'CH') 
                                AND pncs.END_NDT > to_number(to_char(sysdate, 'yyyymmddHH24misssss')) 
                                AND cs.case_id = pncs.phon_case_id)
LEFT JOIN eb.enum_phone_type ptc ON (pnc.phon_type_cd = ptc.value)
LEFT JOIN eb.enum_phone_type ptcs ON (pncs.phon_type_cd = ptcs.value);

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_HOME_PHONE_SV TO MAXDAT_REPORTS;


