CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
select
    PLAN_ID,
    plan_id_ext,
    PLAN_CODE,
    PLAN_NAME,
    PLAN_ABBREVIATION,
    MANAGED_CARE_PROGRAM,
    PLAN_EFFECTIVE_DATE,
    CONTACT_FIRST_NAME,
    CONTACT_MIDDLE_NAME,
    CONTACT_LAST_NAME,
    CONTACT_FULL_NAME,
    ADDRESS1,
    ADDRESS2,
    CITY,
    STATE,
    ZIP,
    CONTACT_PHONE, --contact info
    ACTIVE,
    ENROLLOK,
    PLAN_ASSIGN,
    PLAN_TYPE,
    RECORD_DATE,
    RECORD_TIME,
    RECORD_NAME,
    PLAN_SERVICE_TYPE_CD
   from
  (
  SELECT
    pl.plan_id AS PLAN_ID,
    pl.plan_id_ext as plan_id_ext,
    pl.plan_code AS PLAN_CODE,
    case when c.plan_Service_type_Cd = 'ACC' then substr(pl.plan_code,4,1) ||'-'|| pl.plan_name else pl.plan_name end AS PLAN_NAME,
    pl.plan_name AS PLAN_ABBREVIATION,
    c.program_type_cd AS MANAGED_CARE_PROGRAM,
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
--    ,CCON.COUNTY_CD COUNTY_CODE
  , row_number() over(partition by pl.plan_id order by ca.start_date)  rown
  , c.plan_service_type_cd
  FROM EB.plans pl
  JOIN EB.contract c ON pl.plan_id = c.plan_id
  JOIN EB.contract_amendment ca ON c.contract_id =ca.contract_id
--  JOIN EB.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id
  LEFT JOIN EB.contact cn ON (c.contract_id = cn.contract_id)
  LEFT JOIN EB.contact_address cad ON cn.contact_id = cad.contact_id
  WHERE 1=1
  and (ca.end_date IS NULL or ca.end_date > ca.start_date)
  AND ca.status_cd = 'ACTIVE'
  AND c.end_date IS NULL
  )
  where rown = 1
  UNION
  SELECT 0 AS PLAN_ID,
    '0' as plan_id_ext,
    '0' AS PLAN_CODE,
    'No Plan Designated' AS PLAN_NAME,
    'No Plan Designated' AS PLAN_ABBREVIATION,
    'MEDICAID' AS MANAGED_CARE_PROGRAM,
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
    NULL AS RECORD_NAME,
    NULL AS PLAN_SERVICE_TYPE_CD
 --   ,null COUNTY_CODE
 FROM DUAL
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SV TO MAXDATSUPPORT_READ_ONLY;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SV TO MAXDAT_REPORTS; 
  
  
