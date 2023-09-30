CREATE OR REPLACE VIEW EMRS_D_PLAN_TYPE_SV
AS
  SELECT 
    p.value AS PLAN_TYPE
    ,p.report_label AS PLAN_TYPE_DESC
  FROM EB.enum_plan_type p
  UNION
  SELECT
    '0'  AS PLAN_TYPE
    ,'Not Defined' AS PLAN_TYPE_DESC
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_TYPE_SV TO MAXDAT_REPORTS; 
