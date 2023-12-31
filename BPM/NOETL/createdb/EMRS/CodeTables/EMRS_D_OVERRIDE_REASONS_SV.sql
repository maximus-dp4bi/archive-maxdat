CREATE OR REPLACE VIEW EMRS_D_OVERRIDE_REASONS_SV 
AS
  SELECT 
    o.value AS OVERRIDE_REASON_CD
    ,o.description AS OVERRIDE_REASON
  FROM eb.ENUM_OVERRIDE_REASONS o
  UNION ALL
  SELECT 
    '0' AS OVERRIDE_REASON_CD
    ,'Not Defined' AS OVERRIDE_REASON
  FROM DUAL;
  
GRANT SELECT ON maxdat_support.EMRS_D_OVERRIDE_REASONS_SV TO MAXDAT_REPORTS;
