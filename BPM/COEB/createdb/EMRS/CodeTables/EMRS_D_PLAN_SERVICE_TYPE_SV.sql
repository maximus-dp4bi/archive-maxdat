CREATE OR REPLACE VIEW EMRS_D_PLAN_SERVICE_TYPE_SV
AS
  SELECT value AS PLAN_SERVICE_TYPE_CD
        ,report_label AS PLAN_SERVICE_TYPE
        ,CASE WHEN VALUE = 'ACC' THEN 'Health First Colorado' 
              WHEN VALUE = 'CHP' THEN 'CHP+'
              ELSE 'Undefined'
              END AS PLAN_SERVICE_TYPE_label
          FROM &schema_name..ENUM_PLAN_SERVICE_TYPE
  UNION ALL
  SELECT 'UD' AS PLAN_SERVICE_TYPE_CD
        , 'Undefined' AS PLAN_SERVICE_TYPE
        , 'Undefined' AS PLAN_SERVICE_TYPE_label
  FROM DUAL;

GRANT SELECT ON EMRS_D_PLAN_SERVICE_TYPE_SV TO MAXDAT_REPORTS;

