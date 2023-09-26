CREATE OR REPLACE VIEW EMRS_D_CASE_STATUS_SV
AS
  SELECT 
    cs.value AS CASE_STATUS_CD,
    cs.report_label AS CASE_STATUS
  FROM &schema_name..ENUM_CASE_STATUS cs
  UNION ALL
  SELECT 
    '0' AS CASE_STATUS_CD,
    'Not Defined' AS CASE_STATUS
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CASE_STATUS_SV TO MAXDAT_REPORTS;