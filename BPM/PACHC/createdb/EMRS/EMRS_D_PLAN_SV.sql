CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
  SELECT 
    pl.plan_id AS PLAN_ID,
    pl.plan_code AS PLAN_CODE,
    pl.plan_name AS PLAN_NAME,
    c.contract_name AS PLAN_ABBREVIATION,
    c.program_type_cd AS MANAGED_CARE_PROGRAM,
    COALESCE(c.plan_service_type_cd, 'UD') AS PLAN_SERVICE_TYPE_CD,
    ca.start_date AS PLAN_EFFECTIVE_DATE,
    cn.first_name AS CONTACT_FIRST_NAME,
    cn.middle_name AS CONTACT_MIDDLE_NAME,
    cn.last_name AS CONTACT_LAST_NAME,
    cn.first_name||
    TRIM(CASE
      WHEN SUBSTR(cn.middle_name,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(cn.middle_name,1,1)||' '
    END ||cn.last_name) AS CONTACT_FULL_NAME,
    cad.street_1 AS ADDRESS1,
    cad.street_2 AS ADDRESS2,
    cad.city AS CITY,
    cad.state AS STATE,
    cad.zipcode AS ZIP,
    cn.phone AS CONTACT_PHONE, --contact info
    CASE
      WHEN ca.status_cd = 'CLOSED'
      THEN 'N'
      ELSE 'Y'
    END AS ACTIVE,
    CASE
      WHEN ca.auto_assignment_type_cd <> 'NO_TRANSACTIONS'
      THEN 'Y'
      ELSE 'N'
    END AS ENROLLOK,
    CASE
      WHEN ca.auto_assignment_type_cd = 'ALL_TRANSACTIONS'
      THEN 'Y'
      ELSE 'N'
    END AS PLAN_ASSIGN,
    CASE
      WHEN c.plan_service_type_cd = 'DENTAL'
      THEN 'DENTAL'
      ELSE 'MEDICAL'
    END AS PLAN_TYPE,
    ca.create_ts AS RECORD_DATE,
    TO_CHAR(ca.create_ts,'HH24MI') AS RECORD_TIME,
    ca.created_by AS RECORD_NAME    
  FROM ats.plans pl
  JOIN ats.contract c ON pl.plan_id = c.plan_id
  JOIN ats.contract_amendment ca ON c.contract_id =ca.contract_id
  LEFT JOIN ats.contact cn ON (c.contract_id = cn.contract_id)
  LEFT JOIN ats.contact_address cad ON cn.contact_id = cad.contact_id
  WHERE ca.end_date IS NULL
  AND ca.status_cd = 'ACTIVE'
  AND c.end_date IS NULL
  
  UNION
  
  SELECT 0 AS PLAN_ID,
    '0' AS PLAN_CODE,
    'Not Defined' AS PLAN_NAME,
    'Not Defined' AS PLAN_ABBREVIATION,
    'MEDICAID' AS MANAGED_CARE_PROGRAM,
    'UD' AS PLAN_SERVICE_TYPE_CD,
    TO_DATE('01/01/1900','MM/DD/YYYY') AS PLAN_EFFECTIVE_DATE,
    NULL AS CONTACT_FIRST_NAME,
    NULL AS CONTACT_MIDDLE_NAME,
    NULL AS CONTACT_LAST_NAME,
    NULL AS CONTACT_FULL_NAME,
    NULL AS ADDRESS1,
    NULL AS ADDRESS2,
    NULL AS CITY,
    NULL AS STATE,
    NULL AS ZIP,
    NULL AS CONTACT_PHONE, --contact info
     'N' AS ACTIVE,
    'N' AS ENROLLOK,
    'N' AS PLAN_ASSIGN,
    '0' AS PLAN_TYPE,
    NULL AS RECORD_DATE,
    NULL AS RECORD_TIME,
    NULL AS RECORD_NAME
 FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SV TO MAXDAT_REPORTS; 