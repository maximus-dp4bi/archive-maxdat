CREATE OR REPLACE VIEW D_PI_CURRENT_PHONE_SV
AS
   SELECT p.PHON_ID,
    p.PHON_BEGIN_DATE,
    p.PHON_TYPE_CD,
    pt.DESCRIPTION AS PHON_TYPE,
    p.PHON_END_DATE,
    p.CLNT_CLIENT_ID AS CLIENT_ID,
    p.PHON_AREA_CODE,
    p.PHON_PHONE_NUMBER,
    p.PHON_EXT,
    p.PHON_PROV_ID,
    p.PHON_CNTT_ID,
    p.PHON_DOLK_ID,
    p.CREATED_BY,
    p.CREATION_DATE,
    p.LAST_UPDATED_BY,
    p.LAST_UPDATE_DATE,
    p.PHON_CASE_ID AS CASE_NUMBER,
    p.START_NDT,
    p.END_NDT,
    p.PHON_CARRIER_INFO,
    p.SMS_ENABLED_IND,
    p.PHON_BAD_DATE,
    p.PHON_BAD_DATE_SATISFIED,
    p.COMPARABLE_KEY
  FROM EB.PHONE_NUMBER p
  JOIN EB.ENUM_PHONE_TYPE pt ON (p.PHON_TYPE_CD = pt.VALUE)
  WHERE PHON_END_DATE IS NULL
  AND p.PHON_CASE_ID IS NOT NULL
  AND p.PHON_ID IN (select MAX(p.PHON_ID) KEEP (DENSE_RANK LAST ORDER BY p.PHON_TYPE_CD DESC, p.PHON_BEGIN_DATE) AS cur_phon_id
          FROM EB.PHONE_NUMBER p
          WHERE PHON_END_DATE IS NULL
          AND p.PHON_CASE_ID IS NOT NULL
          GROUP BY p.PHON_CASE_ID)
  UNION ALL
  SELECT 0 AS PHON_ID,
  TO_DATE('01/01/1900','MM/DD/YYYY') AS PHON_BEGIN_DATE,
  NULL AS PHON_TYPE_CD,
  NULL AS PHON_TYPE,
  NULL AS PHON_END_DATE,
  c.clnt_client_id AS CLIENT_ID,
  '000' AS PHON_AREA_CODE,
  '0000000' AS PHON_PHONE_NUMBER,
  '000' AS PHON_EXT,
  NULL AS PHON_PROV_ID,
  NULL AS PHON_CNTT_ID,
  NULL AS PHON_DOLK_ID,
  NULL AS CREATED_BY,
  TO_DATE('01/01/1900','MM/DD/YYYY') AS CREATION_DATE,
  NULL AS LAST_UPDATED_BY,
  TO_DATE('01/01/1900','MM/DD/YYYY') AS LAST_UPDATE_DATE,
  c.CASE_ID  AS CASE_NUMBER,
  0 AS START_NDT,
  0 AS END_NDT,
  NULL AS PHON_CARRIER_INFO,
  NULL AS SMS_ENABLED_IND,
  NULL AS PHON_BAD_DATE,
  NULL AS PHON_BAD_DATE_SATISFIED,
  NULL AS COMPARABLE_KEY
FROM EB.CASES c 
WHERE NOT EXISTS (SELECT PHON_CASE_ID FROM EB.PHONE_NUMBER p WHERE p.PHON_END_DATE IS NULL AND p.PHON_CASE_ID IS NOT NULL and p.PHON_CASE_ID = c.case_id); 
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_PHONE_SV TO EB_MAXDAT_REPORTS;