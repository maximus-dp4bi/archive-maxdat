CREATE OR REPLACE VIEW EMRS_D_CLIENT_TYPE_SV
AS
  SELECT 
    c.VALUE AS CLIENT_TYPE_CD
    ,c.REPORT_LABEL AS CLIENT_TYPE
  FROM &schema_name..ENUM_CLIENT_TYPE c;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_TYPE_SV TO MAXDAT_REPORTS;
  
  
